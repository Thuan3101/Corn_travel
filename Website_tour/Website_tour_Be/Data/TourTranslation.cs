using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;

namespace Website_tour_Be.Data
{
    // Bảng dịch thông tin tour
    public class TourTranslation
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int TranslationId { get; set; }

        public int TourId { get; set; }

        [ForeignKey("TourId")]
        public Tour? Tour { get; set; }

        [Required]
        [StringLength(5)]
        public string LanguageCode { get; set; } = "vi"; // vi, en, etc.

        [Required]
        [MaxLength(255)]
        public string Name { get; set; } = string.Empty;

        [Required]
        public string Description { get; set; } = string.Empty;

        public string? Highlights { get; set; } // Điểm nổi bật của tour

        public string? Includes { get; set; } // Những gì được bao gồm trong tour

        public string? Excludes { get; set; } // Những gì không được bao gồm

        public string? Notes { get; set; } // Lưu ý cho khách hàng

        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public DateTime CreatedAt { get; set; } = DateTime.Now;

        public DateTime? UpdatedAt { get; set; }
    }
}
