using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Caching.Memory;
using Microsoft.AspNetCore.Identity;
using Website_tour_Be.Models;

[Route("api/otp")]
[ApiController]
public class OtpController : ControllerBase
{
    private readonly IMemoryCache _memoryCache;
    private readonly EmailService _emailService;
    private readonly UserManager<User> _userManager;

    // Kh?i tạo OtpController v?i IMemoryCache v? EmailService
    public OtpController(IMemoryCache memoryCache, EmailService emailService, UserManager<User> userManager)
    {
        _memoryCache = memoryCache;
        _emailService = emailService;
        _userManager = userManager;
    }

    //Gui ma OTP den email cua nguoi dung va luu ma OTP vao cache
    [HttpPost("send-otp")]
    public async Task<IActionResult> SendOtp([FromBody] SendOtpRequest request)
    {
        if (string.IsNullOrEmpty(request.Email))
        {
            return BadRequest("Email is required.");
        }

        // Tạo mã OTP ngẫu nhiên
        var otp = new Random().Next(100000, 999999).ToString();

        // Lưu OTP vào Cache với thời hạn 60 giây
        _memoryCache.Set(request.Email, otp, TimeSpan.FromSeconds(60));

        // Gửi email chứa mã OTP
        var subject = "Mã OTP của bạn";
        var message = $"Mã OTP của bạn là: {otp}. Mã này sẽ hết hạn sau 60 giây.";
        await _emailService.SendEmailAsync(request.Email, subject, message);

        return Ok(new { Message = "OTP đã được gửi thành công" });
    }

    public class SendOtpRequest
    {
        public string? Email { get; set; }
    }

    //Xac minh ma OTP nguoi dung nhap vao
    [HttpPost("verify-otp")]
    public IActionResult VerifyOtp([FromBody] VerifyOtpRequest request)
    {
        // Kiểm tra xem OTP có trong cache không
        if (!_memoryCache.TryGetValue(request.Email, out string cachedOtp))
        {
            return BadRequest("OTP đã hết hạn hoặc không hợp lệ.");
        }

        // So sánh mã OTP người dùng nhập
        if (cachedOtp != request.OtpCode)
        {
            return BadRequest("OTP không hợp lệ.");
        }

        return Ok(new { Message = "OTP đã xác minh thành công" });
    }
    // Đặt lại mật khẩu
    [HttpPost("reset-password")]
    public async Task<IActionResult> ResetPassword([FromBody] ResetPasswordRequest request)
    {
        if (string.IsNullOrEmpty(request.Email) || string.IsNullOrEmpty(request.OtpCode) || string.IsNullOrEmpty(request.NewPassword))
        {
            return BadRequest("Email, mã OTP và mật khẩu mới là bắt buộc.");
        }

        // Kiểm tra mã OTP
        if (!_memoryCache.TryGetValue(request.Email, out string cachedOtp) || cachedOtp != request.OtpCode)
        {
            return BadRequest("Mã OTP không hợp lệ hoặc đã hết hạn.");
        }

        // Tìm người dùng dựa trên email
        var user = await _userManager.FindByEmailAsync(request.Email);
        if (user == null)
        {
            return NotFound("Người dùng không tồn tại.");
        }

        // Mã hóa mật khẩu mới
        var hashedPassword = BCrypt.Net.BCrypt.HashPassword(request.NewPassword);
        user.PasswordHash = hashedPassword;

        // Cập nhật mật khẩu người dùng
        var result = await _userManager.UpdateAsync(user);
        if (!result.Succeeded)
        {
            return StatusCode(500, "Đã xảy ra lỗi trong quá trình cập nhật mật khẩu.");
        }

        // Xóa OTP khỏi cache
        _memoryCache.Remove(request.Email);

        return Ok(new { Message = "Mật khẩu đã được cập nhật thành công." });
    }



}

//Lop request dung de nhan ma OTP tu nguoi dung
public class VerifyOtpRequest
{
    public string? Email { get; set; }
    public string? OtpCode { get; set; }
}

// Lớp request để nhận dữ liệu từ người dùng
    public class ResetPasswordRequest
    {
        public string? Email { get; set; }
        public string? OtpCode { get; set; }
        public string? NewPassword { get; set; }
    }
    
