using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;

namespace Website_tour_Be.Models
{
    public class SignUpModel
    {
        [Required]
        public string? FirstName { get; set; } = null;
        [Required]
        public string? LastName { get; set; } = null;

        [Required, EmailAddress]
        public string Email { get; set; } = null!;
        [Required]
        public string Password { get; set; } = null!;

        [Required]
        public string ConfirmPassword { get; set; } = null!;

        [Phone]
        public string? PhoneNumber { get; set; }

        [Required]
        [StringLength(400)]
        public string? Address { get; set; } = null;
        // chinh theo ngay thang nam
        [Required]
        [DataType(DataType.Date)]
        [DisplayFormat(ApplyFormatInEditMode = true, DataFormatString = "{0:dd-MM-yyyy}")]
        public DateTime BirthDate { get; set; }

        // Thêm Giới tính
        public string Gender { get; set; } = string.Empty;
        //Tu dong sinh ra ngay tao
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public DateTime CreatedAt { get; set; } = DateTime.Now;
    }
}
