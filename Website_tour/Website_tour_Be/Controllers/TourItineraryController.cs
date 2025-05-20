using AutoMapper;
using Microsoft.AspNetCore.Mvc;
using Website_tour_Be.Models;
using Website_tour_Be.IRepository;
using System.Collections.Generic;
using System.Threading.Tasks;
using Website_tour_Be.Data;

namespace Website_tour_Be.Controllers
{
    [Route("api/tour-itinerary")]
    [ApiController]
    public class TourItineraryController : ControllerBase
    {
        private readonly IRepository<TourItinerary> _tourItineraryRepository;
        private readonly IMapper _mapper;

        public TourItineraryController(IRepository<TourItinerary> tourItineraryRepository, IMapper mapper)
        {
            _tourItineraryRepository = tourItineraryRepository;
            _mapper = mapper;
        }

        [HttpGet]
        public async Task<ActionResult<IEnumerable<TourItineraryModel>>> GetAll(
            int? itineraryId = null,
            int? tourId = null,
            string? title = null,
            string? description = null,
            int? dayNumber = null,
            string? destinations = null,
            string? activities = null,
            string? mealInclusions = null,
            string? accommodation = null,
            int page = 1, // Mặc định là trang 1
            int pageSize = 10 // Mặc định là 10 bản ghi trên một trang
            )
        {

            var tourItineraries = await _tourItineraryRepository.GetAllAsync(
                filter: t =>
                (!itineraryId.HasValue || t.ItineraryId == itineraryId.Value) &&
                    (!tourId.HasValue || t.TourId == tourId.Value) &&
                    (string.IsNullOrEmpty(title) || t.Title.Contains(title, StringComparison.OrdinalIgnoreCase)) &&
                    (string.IsNullOrEmpty(description) || t.Description.Contains(description, StringComparison.OrdinalIgnoreCase)) &&
                    (!dayNumber.HasValue || t.DayNumber == dayNumber.Value) &&
                    (string.IsNullOrEmpty(destinations) || t.Destinations.Contains(destinations, StringComparison.OrdinalIgnoreCase)) &&
                    (string.IsNullOrEmpty(activities) || t.Activities.Contains(activities, StringComparison.OrdinalIgnoreCase)) &&
                    (string.IsNullOrEmpty(mealInclusions) || t.MealInclusions.Contains(mealInclusions, StringComparison.OrdinalIgnoreCase)) &&
                    (string.IsNullOrEmpty(accommodation) || t.Accommodation.Contains(accommodation, StringComparison.OrdinalIgnoreCase)),
                page: page,
                pageSize: pageSize
                );
            var tourItineraryModels = _mapper.Map<IEnumerable<TourItineraryModel>>(tourItineraries);
            return Ok(tourItineraryModels);
        }

        [HttpGet("{tourid}")]
        public async Task<ActionResult<IEnumerable<TourItineraryModel>>> GetById(int tourid)
        {
            var tourItineraries = await _tourItineraryRepository.GetByConditionAsync(iti => iti.TourId == tourid);
            if (tourItineraries == null || !tourItineraries.Any())
            {
                return NotFound();
            }
            var tourItineraryModels = _mapper.Map<IEnumerable<TourItineraryModel>>(tourItineraries);
            return Ok(tourItineraryModels);
        }


        [HttpPost]
        public async Task<ActionResult<TourItineraryModel>> Create([FromBody] TourItineraryModel tourItineraryModel)
        {
            var tourItinerary = _mapper.Map<TourItinerary>(tourItineraryModel);
            await _tourItineraryRepository.AddAsync(tourItinerary);
            return CreatedAtAction(nameof(GetById), new { id = tourItinerary.ItineraryId }, tourItineraryModel);
        }

        [HttpPut("{id}")]
        public async Task<IActionResult> Update(int id, [FromBody] TourItineraryModel tourItineraryModel)
        {
            if (id != tourItineraryModel.ItineraryId)
            {
                return BadRequest();
            }
            var tourItinerary = _mapper.Map<TourItinerary>(tourItineraryModel);
            await _tourItineraryRepository.UpdateAsync(tourItinerary);
            return NoContent();
        }

        [HttpDelete("{id}")]
        public async Task<IActionResult> Delete(int id)
        {
            await _tourItineraryRepository.DeleteAsync(id);
            return NoContent();
        }
    }
}