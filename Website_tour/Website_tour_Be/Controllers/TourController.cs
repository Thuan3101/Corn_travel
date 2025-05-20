using AutoMapper;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Website_tour_Be.Data;
using Website_tour_Be.IRepository;
using Website_tour_Be.Models;

namespace Website_tour_Be.Controllers
{
    [Route("api/tour")]
    [ApiController]
    public class TourController : ControllerBase
    {
        private readonly IRepository<Tour> _tourRepository;
        private readonly IMapper _mapper;
        private static readonly Random _random = new Random();

        public TourController(IRepository<Tour> tourRepository, IMapper mapper)
        {
            _tourRepository = tourRepository;
            _mapper = mapper;
        }

        [HttpGet]
        public async Task<ActionResult<IEnumerable<TourModel>>> GetTours(
        int? tourId = null,
        string? code = null,
        string? startPlace = null,
        string? endPlace = null,
        int? tourTypeId = null,
        int page = 1, // Mặc định là trang 1
        int pageSize = 5 // Mặc định là 10 bản ghi trên một trang
        )
        {
            var tours = await _tourRepository.GetAllAsync(
                filter: t =>
                    (!tourId.HasValue || t.TourId == tourId.Value) &&
                    (string.IsNullOrEmpty(code) || EF.Functions.Like(t.Code, $"%{code}%")) &&
                    (string.IsNullOrEmpty(startPlace) || EF.Functions.Like(t.StartPlace, $"%{startPlace}%")) &&
                    (string.IsNullOrEmpty(endPlace) || EF.Functions.Like(t.EndPlace, $"%{endPlace}%")) &&
                    (!tourTypeId.HasValue || t.TourTypeId == tourTypeId.Value),
                page: page,
                pageSize: pageSize
            );

            var tourModels = _mapper.Map<IEnumerable<TourModel>>(tours);
            return Ok(tourModels);
        }





        [HttpGet("{tourid}")]
        public async Task<ActionResult<TourModel>> GetTour(int tourid)
        {
            var tour = await _tourRepository.GetByIdAsync(tourid);
            if (tour == null)
            {
                return NotFound();
            }

            var tourModel = _mapper.Map<TourModel>(tour);
            return Ok(tourModel);
        }

        private async Task<string> GenerateUniqueCode()
        {
            string code;
            var existingTours = await _tourRepository.GetAllAsync();

            do
            {
                string letters = new string(Enumerable.Range(0, 4)
                    .Select(_ => (char)_random.Next('A', 'Z' + 1))
                    .ToArray());
                string digits = _random.Next(100000, 999999).ToString();

                code = letters + digits;
            }
            while (existingTours.Any(t => t.Code == code));

            return code;
        }

        [HttpPost]
        public async Task<ActionResult<TourModel>> PostTour(TourModel tourModel)
        {
            tourModel.Code = await GenerateUniqueCode();
            var tour = _mapper.Map<Tour>(tourModel);
            await _tourRepository.AddAsync(tour);

            return CreatedAtAction(nameof(GetTour), new { tourid = tour.TourId }, tourModel);
        }

        [HttpPut("{tourid}")]
        public async Task<IActionResult> PutTour(int tourid, TourModel tourModel)
        {
            if (tourid != tourModel.TourId)
            {
                return BadRequest();
            }

            var tour = _mapper.Map<Tour>(tourModel);
            await _tourRepository.UpdateAsync(tour);
            return NoContent();
        }

        [HttpDelete("{tourid}")]
        public async Task<IActionResult> DeleteTour(int tourid)
        {
            await _tourRepository.DeleteAsync(tourid);
            return NoContent();
        }

        [HttpGet("search")]
        public async Task<ActionResult<IEnumerable<TourModel>>> SearchTours([FromQuery] string? startPlace = null, [FromQuery] string? endPlace = null)
        {
            // Lấy danh sách tất cả các tour
            var tours = await _tourRepository.GetAllAsync();

            // Lọc các tour dựa trên StartPlace hoặc EndPlace, chỉ lọc khi có giá trị được cung cấp
            if (!string.IsNullOrEmpty(startPlace) || !string.IsNullOrEmpty(endPlace))
            {
                tours = tours.Where(t =>
                    (!string.IsNullOrEmpty(startPlace) && t.StartPlace.Contains(startPlace, StringComparison.OrdinalIgnoreCase)) ||
                    (!string.IsNullOrEmpty(endPlace) && t.EndPlace.Contains(endPlace, StringComparison.OrdinalIgnoreCase))
                ).ToList();
            }

            // Áp dụng AutoMapper để chuyển đổi sang model cho response
            var tourModels = _mapper.Map<IEnumerable<TourModel>>(tours);

            // Kiểm tra nếu không có kết quả nào trả về
            if (!tourModels.Any())
            {
                return NotFound("Không tìm thấy tour nào phù hợp với điểm xuất phát hoặc điểm đến đã chọn.");
            }

            return Ok(tourModels);
        }




    }
}
