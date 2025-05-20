using System.ComponentModel.DataAnnotations;

namespace Website_tour_Be.Models
{
    public class ProfileModel
    {
        [Required(ErrorMessage = "First name is required.")]
        public string? FirstName { get; set; }

        [Required(ErrorMessage = "Last name is required.")]
        public string? LastName { get; set; }

        [Phone(ErrorMessage = "Invalid phone number.")]
        public string? PhoneNumber { get; set; }

        [Required(ErrorMessage = "Address is required.")]
        [StringLength(400, ErrorMessage = "Address cannot exceed 400 characters.")]
        public string? Address { get; set; }

        [Required(ErrorMessage = "Birth date is required.")]
        [DataType(DataType.Date)]
        public DateTime BirthDate { get; set; }

        [Required(ErrorMessage = "Gender is required.")]
        public string Gender { get; set; } = string.Empty;

        [EmailAddress(ErrorMessage = "Invalid email address.")]
        [Required(ErrorMessage = "Email is required.")]
        public string? Email { get; set; }

        // Chỉ yêu cầu nhập mật khẩu cũ để xác thực khi cập nhật hồ sơ
        [DataType(DataType.Password)]
        [Required(ErrorMessage = "Old password is required.")]
        public string OldPassword { get; set; } = string.Empty; // Mật khẩu cũ (không thể để trống)
    }
}
