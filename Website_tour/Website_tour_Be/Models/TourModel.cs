using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;
using Website_tour_Be.Data;
using System.Security.Cryptography;


namespace Website_tour_Be.Models
{
    public class TourModel
    {



        public int TourId { get; set; }
        
        
        public string Code { get; set; }= string.Empty;

        
        public string? StartPlace { get; set; }

        
        public string? EndPlace { get; set; }

        

        public int TourTypeId { get; set; }

        

        [Required]
        public bool IsActive { get; set; } = true;

        

        public DateTime CreatedAt { get; set; } = DateTime.Now;

        
        
        


    }

}

