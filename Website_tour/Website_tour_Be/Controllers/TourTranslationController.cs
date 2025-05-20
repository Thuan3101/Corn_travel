using AutoMapper;
using Microsoft.AspNetCore.Mvc;
using Website_tour_Be.Models;
using Website_tour_Be.IRepository;
using System.Collections.Generic;
using System.Threading.Tasks;
using Website_tour_Be.Data;
using Microsoft.EntityFrameworkCore;

namespace Website_tour_Be.Controllers
{
    [Route("api/tour-translation")]
    [ApiController]
    public class TourTranslationController : ControllerBase
    {
        private readonly IRepository<TourTranslation> _tourTranslationRepository;
        private readonly IMapper _mapper;

        public TourTranslationController(IRepository<TourTranslation> tourTranslationRepository, IMapper mapper)
        {
            _tourTranslationRepository = tourTranslationRepository;
            _mapper = mapper;
        }

        [HttpGet]
        public async Task<ActionResult<IEnumerable<TourTranslationModel>>> GetAll(
            int? translationId = null,
            int? tourId = null,
            string? name = null,
            string? description = null,
            string? highlights = null,
            string? includes = null,
            string? excludes = null,
            string? notes = null,
            int page = 1, // Mặc định là trang 1
            int pageSize = 10 // Mặc định là 10 bản ghi trên một trang
            )
        {
            var tourTranslations = await _tourTranslationRepository.GetAllAsync(
                filter: t =>
                    (!translationId.HasValue || t.TranslationId == translationId.Value) &&
                    (!tourId.HasValue || t.TourId == tourId.Value) &&
                    (string.IsNullOrEmpty(name) || EF.Functions.Like(t.Name, $"%{name}%")) &&
                    (string.IsNullOrEmpty(description) || EF.Functions.Like(t.Description, $"%{description}%")) &&
                    (string.IsNullOrEmpty(highlights) || EF.Functions.Like(t.Highlights, $"%{highlights}%")) &&
                    (string.IsNullOrEmpty(includes) || EF.Functions.Like(t.Includes, $"%{includes}%")) &&
                    (string.IsNullOrEmpty(excludes) || EF.Functions.Like(t.Excludes, $"%{excludes}%")) &&
                    (string.IsNullOrEmpty(notes) || EF.Functions.Like(t.Notes, $"%{notes}%")),
                page: page,
                pageSize: pageSize
            );

            var tourTranslationModels = _mapper.Map<IEnumerable<TourTranslationModel>>(tourTranslations);
            return Ok(tourTranslationModels);
        }

        [HttpGet("{id}")]
        public async Task<ActionResult<TourTranslationModel>> GetById(int id)
        {
            var tourTranslation = await _tourTranslationRepository.GetByIdAsync(id);
            if (tourTranslation == null)
            {
                return NotFound();
            }
            var tourTranslationModel = _mapper.Map<TourTranslationModel>(tourTranslation);
            return Ok(tourTranslationModel);
        }

        [HttpPost]
        public async Task<ActionResult<TourTranslationModel>> Create([FromBody] TourTranslationModel tourTranslationModel)
        {
            var tourTranslation = _mapper.Map<TourTranslation>(tourTranslationModel);
            await _tourTranslationRepository.AddAsync(tourTranslation);
            return CreatedAtAction(nameof(GetById), new { id = tourTranslation.TranslationId }, tourTranslationModel);
        }

        [HttpPut("{id}")]
        public async Task<IActionResult> Update(int id, [FromBody] TourTranslationModel tourTranslationModel)
        {
            if (id != tourTranslationModel.TranslationId)
            {
                return BadRequest();
            }
            var tourTranslation = _mapper.Map<TourTranslation>(tourTranslationModel);
            await _tourTranslationRepository.UpdateAsync(tourTranslation);
            return NoContent();
        }

        [HttpDelete("{id}")]
        public async Task<IActionResult> Delete(int id)
        {
            await _tourTranslationRepository.DeleteAsync(id);
            return NoContent();
        }
    }
}