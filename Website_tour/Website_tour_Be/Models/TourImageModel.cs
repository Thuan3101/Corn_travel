using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;
using Website_tour_Be.Data;

namespace Website_tour_Be.Models
{
    public class TourImageModel
    {
        
        public int ImageId { get; set; }

        public int TourId { get; set; }

        
        
        public string ImageUrl { get; set; } = string.Empty;

        [Required]
        public string Caption { get; set; } = string.Empty;
        

        public DateTime CreatedAt { get; set; } = DateTime.Now;



        
    }
}
