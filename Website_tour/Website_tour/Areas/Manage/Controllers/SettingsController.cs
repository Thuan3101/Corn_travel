using Microsoft.AspNetCore.Mvc;

namespace Website_tour_Fe.Areas.Manage.Controllers
{
    public class SettingsController : ManageController
    {
        public IActionResult Index()
        {
            return View();
        }
    }
}
