using System.ComponentModel.DataAnnotations;

namespace Website_tour_Be.Models
{
    public class ChangePasswordModel
    {
        public string? UserId { get; set; }

        [Required(ErrorMessage = "Mật khẩu cũ không được để trống.")]
        public string? OldPassword { get; set; }

        [Required(ErrorMessage = "Mật khẩu mới không được để trống.")]
        [StringLength(100, ErrorMessage = "Mật khẩu mới phải có ít nhất {2} ký tự và tối đa {1} ký tự.", MinimumLength = 6)]
        public string? NewPassword { get; set; }

        [Compare("NewPassword", ErrorMessage = "Mật khẩu xác nhận không khớp.")]
        public string? ConfirmPassword { get; set; }
    }
}
