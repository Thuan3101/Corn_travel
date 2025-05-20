using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Website_tour_Be.Data;
using Website_tour_Be.IRepository;
using Website_tour_Be.Models;

namespace Website_tour_Be.Controllers
{
    [Route("api/user-role")]
    [ApiController]
    [Authorize(AuthenticationSchemes = JwtBearerDefaults.AuthenticationScheme)]
    public class UserRoleController : ControllerBase
    {
        private readonly IUsersRolesRepository accountRepo;
        private readonly ILogger<IUsersRolesRepository> _logger; // Định nghĩa biến logger
        public UserRoleController(IUsersRolesRepository repo, ILogger<IUsersRolesRepository> logger)
        {
            accountRepo = repo;
            _logger = logger; // Khởi tạo logger

        }



        // Xem danh sach user 


        [HttpGet("get-users-and-roles")] // Đảm bảo phương thức này là HttpGet
        [Authorize(Roles = Role.Admin)]
        public async Task<IActionResult> GetAllUsersAndRolesAsync()
        {
            try
            {
                var usersAndRoles = await accountRepo.GetAllUsersAndRolesAsync();
                return Ok(usersAndRoles);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Đã xảy ra lỗi khi lấy danh sách người dùng và vai trò.");
                return StatusCode(500, "Đã xảy ra lỗi trong quá trình xử lý yêu cầu.");
            }
        }

        // Lấy thông tin chi tiết người dùng theo ID
        [HttpGet("get-user/{id}")]

        [Authorize(Roles = Role.Admin)] // Cho phép truy c?p khi user đã đăng nh?p và có quyền admin
        public async Task<IActionResult> GetUserById(string id)
        {
            try
            {
                var user = await accountRepo.GetUserAndRolesAsync(id);
                if (user == null)
                {
                    return NotFound("Không tìm thấy người dùng.");
                }
                return Ok(user);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, $"Lỗi khi lấy thông tin người dùng với ID {id}.");
                return StatusCode(500, "Đã xảy ra lỗi trong quá trình xử lý yêu cầu.");
            }
        }

        // Thêm người dùng mới
        [HttpPost("add-user")]
        [Authorize(Roles = Role.Admin)]
        public async Task<IActionResult> AddUser([FromBody] UserRoleModel model)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            try
            {
                var result = await accountRepo.AddUserAsync(model);
                if (result.Succeeded)
                {
                    return Ok("Thêm người dùng thành công");
                }
                return BadRequest(result.Errors);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Lỗi khi thêm người dùng.");
                return StatusCode(500, "Đã xảy ra lỗi trong quá trình xử lý yêu cầu.");
            }
        }

        // Sửa người dùng theo ID
        [HttpPut("update-user/{userId}")]
        [Authorize(Roles = Role.Admin)]
        public async Task<IActionResult> UpdateUser(string userId, [FromBody] UserRoleModel model)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            try
            {
                var existingUser = await accountRepo.GetUserAndRolesAsync(userId);
                if (existingUser == null)
                {
                    return NotFound($"Người dùng với ID {userId} không tồn tại.");
                }

                var result = await accountRepo.UpdateUserAsync(userId, model);

                if (result.Succeeded)
                {
                    return Ok(new { success = true }); // Đảm bảo trả về thông tin thành công
                }
                return BadRequest(new { success = false, errors = result.Errors });
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, $"Lỗi khi cập nhật người dùng với ID {userId}.");
                return StatusCode(StatusCodes.Status500InternalServerError, "Đã xảy ra lỗi trong quá trình xử lý yêu cầu.");
            }
        }



        // Xóa người dùng theo ID
        [HttpDelete("delete-user/{id}")]
        [Authorize(Roles = Role.Admin)]

        public async Task<IActionResult> DeleteUser(string id)
        {
            try
            {
                var result = await accountRepo.DeleteUserAsync(id);
                if (result.Succeeded)
                {
                    return Ok(new { success = true, message = "Xóa người dùng thành công." });
                }
                return BadRequest(new { success = false, errors = result.Errors });
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, $"Lỗi khi xóa người dùng với ID {id}.");
                return StatusCode(500, "Đã xảy ra lỗi trong quá trình xử lý yêu cầu.");
            }
        }



        [HttpGet("get-roles")]
        [Authorize(Roles = "Admin")]
        public async Task<IActionResult> GetAllRolesAsync()
        {
            try
            {
                var roles = await accountRepo.GetAllRolesAsync(); // Giả sử phương thức này đã được cài đặt
                return Ok(roles);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Đã xảy ra lỗi khi lấy danh sách vai trò.");
                return StatusCode(500, "Đã xảy ra lỗi trong quá trình xử lý yêu cầu.");
            }
        }

    }

}

