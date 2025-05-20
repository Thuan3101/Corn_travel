using Microsoft.AspNetCore.Mvc;

using System.Linq;
using Microsoft.AspNetCore.Mvc.Rendering;



namespace WebApplication1.Controllers
{

    public class HomeController : Controller
    {

        public ActionResult Index1()
        {
            return View();
        }
        
        public ActionResult Index()
        {
            
            return View();
            
        }


        public ActionResult Category()
        {
            return View();
        }
        
        
        
        public IActionResult Contact()
        {
            return View();
        }
        public IActionResult Error()
        {
            return View();
        }




    }
}
