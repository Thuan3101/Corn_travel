using Microsoft.AspNetCore.Mvc;

namespace Website_tour_Fe.Controllers
{
    public class BookingController : Controller
    {
        public IActionResult Booking()
        {
            return View();
        }
    }
}
