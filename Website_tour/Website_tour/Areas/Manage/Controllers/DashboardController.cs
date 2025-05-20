using Microsoft.AspNetCore.Mvc;
using WebApplication1.Controllers;

namespace Website_tour_Fe.Areas.Manage.Controllers
{

    public class DashboardController : ManageController
    {

        public IActionResult Index()
        {
            return View();
        }


    }
}
