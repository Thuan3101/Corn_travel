/*using Microsoft.AspNetCore.Mvc;
using Website_tour_Be.repositories;
using System.Threading.Tasks;
using Website_tour_Be.Models;

namespace Website_tour_Be.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class TicketController : ControllerBase
    {
        private readonly ITourRepository _tourRepository;

        public TicketController(ITourRepository tourRepository)
        {
            _tourRepository = tourRepository;
        }

        [HttpGet("GetAllTours")]
        public async Task<IActionResult> GetAllTours()
        {
            var tours = await _tourRepository.GetAllToursAsync();
            return Ok(tours);
        }

        [HttpGet("GetTour/{tourId}")]
        public async Task<IActionResult> GetTour(int tourId)
        {
            var tour = await _tourRepository.GetTourAsync(tourId);
            return tour != null ? Ok(tour) : NotFound();
        }

        [HttpPost("AddTour")]
        public async Task<IActionResult> AddTour([FromBody] TourModel model)
        {
            var tourId = await _tourRepository.AddTourAsync(model);
            return Ok(tourId);
        }

        [HttpPut("UpdateTour/{tourId}")]
        public async Task<IActionResult> UpdateTour(int tourId, [FromBody] TourModel model)
        {
            await _tourRepository.UpdateTourAsync(tourId, model);
            return NoContent();
        }

        [HttpDelete("DeleteTour/{tourId}")]
        public async Task<IActionResult> DeleteTour(int tourId)
        {
            await _tourRepository.DeleteTourAsync(tourId);
            return NoContent();
        }

        [HttpGet("GetTourBookings/{tourId}")]
        public async Task<IActionResult> GetTourBookings(int tourId)
        {
            var bookings = await _tourRepository.GetBookingsByTourIdAsync(tourId);
            return Ok(bookings);
        }
    }
}
*/