using Microsoft.AspNetCore.Mvc;

namespace Website_tour_Fe.Areas.Manage.Controllers
{
    public class ReportsController : ManageController
    {
        public IActionResult Index()
        {
            return View();
        }
    }
}
