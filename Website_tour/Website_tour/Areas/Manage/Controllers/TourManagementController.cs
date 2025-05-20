using Microsoft.AspNetCore.Mvc;

namespace Website_tour_Fe.Areas.Manage.Controllers
{
    public class TourManagementController : ManageController
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
