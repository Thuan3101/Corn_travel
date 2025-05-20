using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using System.Web.Mvc;
using WebApplication1.Controllers;

namespace Website_tour_Fe.Areas.Admin.Controllers
{

    public class DashboardController : AdminController
    {
        public IActionResult Index()
        {

            return View();
        }
        

    }
}
