using Microsoft.AspNetCore.Mvc;

namespace Website_tour_Fe.Areas.Admin.Controllers
{
    public class TourManagementController : AdminController
    {
        public IActionResult Tours()
        {
            return View();
        }
        public IActionResult AddTours()
        {
            return View();
        }
    }
}
