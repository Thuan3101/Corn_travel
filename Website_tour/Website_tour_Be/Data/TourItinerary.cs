using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;

namespace Website_tour_Be.Data
{
    // Bảng lưu lịch trình từng ngày của tour
    public class TourItinerary
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int ItineraryId { get; set; }

        public int TourId { get; set; }

        [ForeignKey("TourId")]
        public Tour? Tour { get; set; }

        [Required]
        [StringLength(5)]
        public string LanguageCode { get; set; } = "vi"; // vi, en, etc.

        [Required]
        public int DayNumber { get; set; }

        [Required]
        [MaxLength(100)]
        public string Title { get; set; } = string.Empty;

        [Required]
        public string Description { get; set; } = string.Empty;

        [MaxLength(255)]
        public string? Destinations { get; set; }

        [MaxLength(255)]
        public string? Activities { get; set; }

        [MaxLength(100)]
        public string? MealInclusions { get; set; } // Ví dụ: "Ăn sáng, Ăn trưa, Ăn tối"

        [MaxLength(255)]
        public string? Accommodation { get; set; } // Thông tin về khách sạn/nơi nghỉ
    }
}
