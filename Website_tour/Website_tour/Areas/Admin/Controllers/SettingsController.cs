using Microsoft.AspNetCore.Mvc;

namespace Website_tour_Fe.Areas.Admin.Controllers
{
    public class SettingsController : AdminController
    {
        public IActionResult Index()
        {
            return View();
        }
    }
}
