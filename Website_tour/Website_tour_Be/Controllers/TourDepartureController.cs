using AutoMapper;
using Microsoft.AspNetCore.Mvc;
using System.Collections.Generic;
using System.Threading.Tasks;
using Website_tour_Be.Models;
using Website_tour_Be.IRepository;
using Website_tour_Be.Data;

namespace Website_tour_Be.Controllers
{
    [Route("api/tour-departure")]
    [ApiController]
    public class TourDepartureController : ControllerBase
    {
        private readonly IRepository<TourDeparture> _tourDepartureRepository;
        private readonly IMapper _mapper;

        public TourDepartureController(IRepository<TourDeparture> tourDepartureRepository, IMapper mapper)
        {
            _tourDepartureRepository = tourDepartureRepository;
            _mapper = mapper;
        }

        [HttpGet]
        public async Task<ActionResult<IEnumerable<TourDepartureModel>>> GetAll(
        int? departureId = null,
        int? tourId = null,
        string? code = null,
        DateTime? departureDate = null,
        DateTime? returnDate = null,
        int? price = null,
        int? childPrice = null,
        int? availableSeats = null,
        int page = 1, // Mặc định là trang 1
        int pageSize = 10 // Mặc định là 10 bản ghi trên một trang
)
        {
            var tourDepartures = await _tourDepartureRepository.GetAllAsync(
                filter: t =>
                    (!departureId.HasValue || t.DepartureId == departureId.Value) &&
                    (!tourId.HasValue || t.TourId == tourId.Value) &&
                    (string.IsNullOrEmpty(code) || t.Code.Contains(code)) &&
                    (!departureDate.HasValue || t.DepartureDate == departureDate.Value) &&
                    (!returnDate.HasValue || t.ReturnDate == returnDate.Value) &&
                    (!price.HasValue || t.Price == price.Value) &&
                    (!childPrice.HasValue || t.ChildPrice == childPrice.Value) &&
                    (!availableSeats.HasValue || t.AvailableSeats == availableSeats.Value),
                page: page,
                pageSize: pageSize
                );
            var tourDepartureModels = _mapper.Map<IEnumerable<TourDepartureModel>>(tourDepartures);
            return Ok(tourDepartureModels);
        }

        [HttpGet("{tourid}")]
        public async Task<ActionResult<TourDepartureModel>> GetById(int tourid)
        {
            var tourDeparture = await _tourDepartureRepository.GetByIdAsync(tourid);
            if (tourDeparture == null)
            {
                return NotFound();
            }
            var tourDepartureModel = _mapper.Map<TourDepartureModel>(tourDeparture);
            return Ok(tourDepartureModel);
        }

        [HttpPost]
        public async Task<ActionResult<TourDepartureModel>> Create([FromBody] TourDepartureModel tourDepartureModel)
        {
            var tourDeparture = _mapper.Map<TourDeparture>(tourDepartureModel);
            await _tourDepartureRepository.AddAsync(tourDeparture);
            return CreatedAtAction(nameof(GetById), new { tourid = tourDeparture.DepartureId }, tourDepartureModel);
        }

        [HttpPut("{tourid}")]
        public async Task<IActionResult> Update(int tourid, [FromBody] TourDepartureModel tourDepartureModel)
        {
            if (tourid != tourDepartureModel.DepartureId)
            {
                return BadRequest();
            }
            var tourDeparture = _mapper.Map<TourDeparture>(tourDepartureModel);
            await _tourDepartureRepository.UpdateAsync(tourDeparture);
            return NoContent();
        }

        [HttpDelete("{tourid}")]
        public async Task<IActionResult> Delete(int tourid)
        {
            await _tourDepartureRepository.DeleteAsync(tourid);
            return NoContent();
        }
    }
}
