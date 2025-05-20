using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;

namespace Website_tour_Be.Data
{
    // Bảng lưu lịch khởi hành và giá tour
    public class TourDeparture
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int DepartureId { get; set; }

        public int TourId { get; set; }

        [ForeignKey("TourId")]
        public Tour? Tour { get; set; }

        [Required]
        [MaxLength(50)]
        public string Code { get; set; } = string.Empty; // Mã tour theo ngày khởi hành

        [Required]
        [DataType(DataType.Date)]
        public DateTime DepartureDate { get; set; }

        [Required]
        [DataType(DataType.Date)]
        public DateTime ReturnDate { get; set; }

        [Required]
        [Column(TypeName = "decimal(18, 2)")]
        public decimal Price { get; set; }

        [Required]
        [Column(TypeName = "decimal(18, 2)")]
        public decimal ChildPrice { get; set; } // Giá cho trẻ em

        [Required]
        public int AvailableSeats { get; set; }

        [MaxLength(50)]
        public string Status { get; set; } = "Available"; // Available, Full, Cancelled

        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public DateTime CreatedAt { get; set; } = DateTime.Now;

        public DateTime? UpdatedAt { get; set; }
    }
}
