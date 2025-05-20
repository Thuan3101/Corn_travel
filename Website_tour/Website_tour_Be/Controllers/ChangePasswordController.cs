using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using System.Security.Claims;
using System.Threading.Tasks;
using Website_tour_Be.IRepository;
using Website_tour_Be.Models;

namespace Website_tour_Be.Controllers
{
    [Route("api/")]
    [ApiController]
    [Authorize(AuthenticationSchemes = JwtBearerDefaults.AuthenticationScheme)]
    public class ChangePasswordController : ControllerBase
    {
        private readonly IChangePasswordRepository _changePasswordRepository;
        private readonly UserManager<User> _userManager;

        public ChangePasswordController(IChangePasswordRepository changePasswordRepository, UserManager<User> userManager)
        {
            _changePasswordRepository = changePasswordRepository;
            _userManager = userManager;
        }

        // Xóa thuộc tính [Authorize] trên phương thức này
        [HttpPost("change-password")]
        [Authorize(Roles = "Admin, Manage, Customer")]
        public async Task<IActionResult> ChangePassword([FromBody] ChangePasswordModel model)
        {
            // Kiểm tra tính hợp lệ của model
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            // Kiểm tra người dùng có tồn tại không
            var user = await _userManager.FindByIdAsync(model.UserId);
            if (user == null)
            {
                return NotFound("Người dùng không tồn tại.");
            }

            // Thay đổi mật khẩu
            var result = await _changePasswordRepository.ChangePasswordAsync(model.UserId, model.OldPassword, model.NewPassword);

            // Kiểm tra kết quả đổi mật khẩu
            if (!result)
            {
                return BadRequest("Đổi mật khẩu không thành công. Mật khẩu cũ không đúng.");
            }

            return Ok("Đổi mật khẩu thành công.");
        }
    }
}
