using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;
using Website_tour_Be.Data;

namespace Website_tour_Be.Models
{
    public class TourItineraryModel
    {

        
        public int ItineraryId { get; set; }

        public int TourId { get; set; }

        
        
        public string LanguageCode { get; set; } = "vi";

        [Required]
        public int DayNumber { get; set; }

        [Required]
        
        public string Title { get; set; } = string.Empty;

        [Required]
        public string Description { get; set; } = string.Empty;

        
        public string? Destinations { get; set; }
        
        public string? Activities { get; set; }
        
        public string? MealInclusions { get; set; }
        
        public string? Accommodation { get; set; }
    }
}
