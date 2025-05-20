using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;

namespace Website_tour_Be.Data
{
    public class Tour
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int TourId { get; set; }

        [Required]
        [MaxLength(50)]
        public string Code { get; set; } = string.Empty;

        [Required]
        public string? StartPlace { get; set; }

        [Required]
        public string? EndPlace { get; set; }

        [Required]
        public string StartEndPlace => $"{StartPlace} - {EndPlace}";

        // Loại hình tour
        [Required]
        public int TourTypeId { get; set; }

        [ForeignKey("TourTypeId")]
        public virtual TourType? TourType { get; set; }

        [Required]
        public bool IsActive { get; set; } = true;

        // Các collection
        public virtual ICollection<TourTranslation>? TourTranslations { get; set; }
        public virtual ICollection<TourImage>? TourImages { get; set; }
        public virtual ICollection<TourItinerary>? TourItineraries { get; set; }
        public virtual ICollection<TourDeparture>? TourDepartures { get; set; }
        public virtual ICollection<Booking>? Bookings { get; set; }
        public virtual ICollection<Review>? Reviews { get; set; }

        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public DateTime CreatedAt { get; set; } = DateTime.Now;

        public DateTime? UpdatedAt { get; set; }

        public string? CreatedBy { get; set; }
        public string? UpdatedBy { get; set; }
        

    }
}
