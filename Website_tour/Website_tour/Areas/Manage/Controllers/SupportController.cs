using Microsoft.AspNetCore.Mvc;

namespace Website_tour_Fe.Areas.Manage.Controllers
{
    public class SupportController : ManageController
    {
        public IActionResult Index()
        {
            return View();
        }
    }
}
