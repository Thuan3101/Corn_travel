using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;

namespace Website_tour_Be.Models
{
    public class TourTranslationModel
    {
        
        public int TranslationId { get; set; }

        public int TourId { get; set; }

        
        
        public string LanguageCode { get; set; } = "vi";

        [Required]
       
        public string Name { get; set; } = string.Empty;

        [Required]
        public string Description { get; set; } = string.Empty;

        public string? Highlights { get; set; }
        public string? Includes { get; set; }
        public string? Excludes { get; set; }
        public string? Notes { get; set; }

        public DateTime CreatedAt { get; set; } = DateTime.Now;
        public DateTime? UpdatedAt { get; set; }

    }
}
