using Microsoft.AspNetCore.Mvc;

namespace Website_tour.Controllers
{
    public class AccountsController : Controller
    {
        

        public IActionResult Forget()
        {
            return View();
        }   
        public IActionResult Register()
        {
            return View();
        }
        public IActionResult Profile()
        {
            return View();
        }

    }
}
