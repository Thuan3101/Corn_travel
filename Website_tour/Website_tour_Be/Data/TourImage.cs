using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;

namespace Website_tour_Be.Data
{
    // Bảng lưu nhiều hình ảnh cho tour
    public class TourImage
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int ImageId { get; set; }
        public int TourId { get; set; }

        //[ForeignKey("TourId")]
        public Tour? Tour { get; set; }

        [Required]
        [MaxLength(255)]
        public string ImageUrl { get; set; } = string.Empty;

        [MaxLength(255)]
        public string? Caption { get; set; }

        /*public bool IsMainImage { get; set; } = false;*/

        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public DateTime CreatedAt { get; set; } = DateTime.Now;
    }
}
