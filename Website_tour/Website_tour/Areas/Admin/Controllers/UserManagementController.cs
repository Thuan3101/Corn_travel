using Microsoft.AspNetCore.Mvc;

namespace Website_tour_Fe.Areas.Admin.Controllers
{
    public class UserManagementController : AdminController
    {
        public IActionResult User()
        {
            return View();
        }
        public IActionResult AddUser()
        {
            return View();
        }
    }
}
