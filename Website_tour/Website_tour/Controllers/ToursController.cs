using Microsoft.AspNetCore.Mvc;

using System.Linq;
namespace WebApplication1.Controllers
{
    public class ToursController : Controller
    {
        //Tour trong nuoc
        public ActionResult Domestic()
        {

           
            
            return View();
        }
        //Tour ngoai nuoc
        public ActionResult International()
        {
            

            
            return View();
        }

        //Tour ket hop
        public ActionResult Combine()
        {
            
            
           
            return View();
        }


        //Chi tiet tour
        public ActionResult TourDetail(int tourid)
        {
            return View();
        }



    }
}
