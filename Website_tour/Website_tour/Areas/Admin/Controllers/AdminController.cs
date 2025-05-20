using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using WebApplication1.Controllers;

namespace Website_tour_Fe.Areas.Admin.Controllers
{
    [Area("admin")]
    public abstract class AdminController : Controller
    {
        public AdminController()
        {
            ViewData["Title"] = "Admin";
        }

    }
}
