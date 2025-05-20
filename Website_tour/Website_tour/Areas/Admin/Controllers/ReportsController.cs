using Microsoft.AspNetCore.Mvc;

namespace Website_tour_Fe.Areas.Admin.Controllers
{
    public class ReportsController : AdminController
    {
        public IActionResult Index()
        {
            return View();
        }
    }
}
