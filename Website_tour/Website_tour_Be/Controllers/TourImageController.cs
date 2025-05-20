using AutoMapper;
using Microsoft.AspNetCore.Mvc;
using System.Collections.Generic;
using System.Globalization;
using System.IO;
using System.Text;
using System.Threading.Tasks;
using Website_tour_Be.Models;
using Website_tour_Be.IRepository;
using Website_tour_Be.Data;

namespace Website_tour_Be.Controllers
{
    [Route("api/tour-image")]
    [ApiController]
    public class TourImageController : ControllerBase
    {
        private readonly IRepository<TourImage> _tourImageRepository;
        private readonly IMapper _mapper;
        private readonly IFirebaseRepository _firebaseRepository;
        private readonly ITourTypeRepository _tourTypeRepository;

        public TourImageController(IRepository<TourImage> tourImageRepository, IMapper mapper, IFirebaseRepository firebaseRepository, ITourTypeRepository tourTypeRepository)
        {
            _tourImageRepository = tourImageRepository;
            _mapper = mapper;
            _firebaseRepository = firebaseRepository;
            _tourTypeRepository = tourTypeRepository;
        }

        [HttpGet]
        public async Task<ActionResult<IEnumerable<TourImageModel>>> GetAll(
             int? imageId = null,
             int? tourId = null,
             string? imageUrl = null,
             string? caption = null,
             int page = 1, // Mặc định là trang 1
             int pageSize = 10 // Mặc định là 10 bản ghi trên một trang
             )
        {
            var tourImages = await _tourImageRepository.GetAllAsync(
                filter: t =>
                    (!imageId.HasValue || t.ImageId == imageId.Value) &&
                    (!tourId.HasValue || t.TourId == tourId.Value) &&
                    (string.IsNullOrEmpty(imageUrl) || t.ImageUrl.Contains(imageUrl, StringComparison.OrdinalIgnoreCase)) &&
                    (string.IsNullOrEmpty(caption) || t.Caption.Contains(caption, StringComparison.OrdinalIgnoreCase)),
                page: page,
                pageSize: pageSize
                );
            var tourImageModels = _mapper.Map<IEnumerable<TourImageModel>>(tourImages);
            return Ok(tourImageModels);
        }

        [HttpGet("{tourid}")]
        public async Task<ActionResult<IEnumerable<TourImageModel>>> GetById(int tourid)
        {
            var tourImages = await _tourImageRepository.GetByConditionAsync(img => img.TourId == tourid);

            if (tourImages == null || !tourImages.Any())
            {
                return NotFound("No images found for the specified tour ID.");
            }

            var tourImageModels = _mapper.Map<IEnumerable<TourImageModel>>(tourImages);
            return Ok(tourImageModels);
        }



        // Xóa dấu tiếng Việt và ký tự đặc biệt
        private string RemoveAccents(string text)
        {
            if (string.IsNullOrEmpty(text))
                return text;

            text = text.ToLower();
            var normalizedString = text.Normalize(NormalizationForm.FormD);
            var stringBuilder = new StringBuilder();

            foreach (var c in normalizedString)
            {
                var unicodeCategory = CharUnicodeInfo.GetUnicodeCategory(c);
                if (unicodeCategory != UnicodeCategory.NonSpacingMark)
                {
                    stringBuilder.Append(c);
                }
            }

            return stringBuilder.ToString().Normalize(NormalizationForm.FormC);
        }

        [HttpPost]
        public async Task<ActionResult<TourImageModel>> Create([FromForm] TourImageModel tourImageModel, IFormFile imageFile)
        {
            int imageIndex = 0;
            string cleanFileName = RemoveAccents(Path.GetFileNameWithoutExtension(imageFile.FileName).Replace(" ", "_"));
            string fileName = $"{RemoveAccents(tourImageModel.Caption)}_{imageIndex + 1}".Replace(" ", "_");

            string? imageUrl = await _firebaseRepository.UploadFileToFirebaseStorage(imageFile, fileName, "tour_images");
            if (imageUrl == null)
            {
                return BadRequest("Image upload failed.");
            }

            var tourImage = _mapper.Map<TourImage>(tourImageModel);
            tourImage.ImageUrl = imageUrl;
            await _tourImageRepository.AddAsync(tourImage);

            return CreatedAtAction(nameof(GetById), new { tourid = tourImage.ImageId }, tourImageModel);
        }

        [HttpPut("{tourid}")]
        public async Task<IActionResult> Update(int tourid, [FromForm] TourImageModel tourImageModel, IFormFile? imageFile)
        {
            if (tourid != tourImageModel.ImageId)
            {
                return BadRequest("Image ID mismatch.");
            }

            var existingTourImage = await _tourImageRepository.GetByIdAsync(tourid);
            if (existingTourImage == null)
            {
                return NotFound("Tour image not found.");
            }

            tourImageModel.Caption = RemoveAccents(tourImageModel.Caption).Replace(" ", "_");

            if (imageFile != null)
            {
                string cleanFileName = RemoveAccents(Path.GetFileNameWithoutExtension(imageFile.FileName).Replace(" ", "_"));
                string fileName = $"{RemoveAccents(tourImageModel.Caption)}_{tourid}".Replace(" ", "_");

                string? imageUrl = await _firebaseRepository.UploadFileToFirebaseStorage(imageFile, fileName, "tour_images");
                if (imageUrl == null)
                {
                    return BadRequest("Image upload failed.");
                }

                existingTourImage.ImageUrl = imageUrl;
            }

            existingTourImage.Caption = tourImageModel.Caption;

            await _tourImageRepository.UpdateAsync(existingTourImage);
            return NoContent();
        }

        [HttpDelete("{tourid}")]
        public async Task<IActionResult> Delete(int tourid)
        {
            var tourImage = await _tourImageRepository.GetByIdAsync(tourid);
            if (tourImage == null)
            {
                return NotFound("Tour image not found.");
            }

            try
            {
                var fileName = Path.GetFileName(new Uri(tourImage.ImageUrl).LocalPath);
                await _firebaseRepository.DeleteFileFromFirebaseStorage(fileName, "tour_images");
            }
            catch (Exception ex)
            {
                return StatusCode(500, $"Failed to delete image from Firebase: {ex.Message}");
            }

            await _tourImageRepository.DeleteAsync(tourid);
            return NoContent();
        }
    }
}
