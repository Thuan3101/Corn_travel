using Microsoft.AspNetCore.Mvc;

namespace Website_tour_Fe.Controllers
{
    public class PaymentsController : Controller
    {
        public IActionResult Index()
        {
            return View();
        }
    }
}
