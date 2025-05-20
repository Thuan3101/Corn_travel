/*using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Website_tour_Be.repositories;

// For more information on enabling Web API for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace Website_tour_Be.Controllers
{
    [Route("api/roles")]
    [ApiController]
    public class RolesController : ControllerBase
    {
        private readonly IAccountRepository accountRepo;
        private readonly RoleManager<IdentityRole> roleManager;
        private readonly ILogger<RolesController> _logger;

        public RolesController(IAccountRepository repo, RoleManager<IdentityRole> roleManager, ILogger<RolesController> logger)
        {
            accountRepo = repo;
            this.roleManager = roleManager;
            _logger = logger;
        }

        // Lấy tất cả các vai trò
        [HttpGet("get-roles")]
        public async Task<IActionResult> GetAllRolesAsync()
        {
            try
            {
                var roles = await accountRepo.GetAllRolesAsync();
                return Ok(roles);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Lỗi khi lấy danh sách các vai trò.");
                return StatusCode(500, "Đã xảy ra lỗi trong quá trình xử lý yêu cầu.");
            }
        }

        // Thêm vai trò mới
        [HttpPost("add-role")]
        public async Task<IActionResult> AddRoleAsync([FromBody] string roleName)
        {
            if (string.IsNullOrWhiteSpace(roleName))
            {
                return BadRequest("Tên vai trò không được để trống.");
            }

            try
            {
                // Kiểm tra xem vai trò đã tồn tại chưa
                var roleExists = await roleManager.RoleExistsAsync(roleName);
                if (roleExists)
                {
                    return BadRequest("Vai trò đã tồn tại.");
                }

                // Thêm vai trò mới
                var result = await roleManager.CreateAsync(new IdentityRole(roleName));
                if (result.Succeeded)
                {
                    return Ok("Thêm vai trò thành công.");
                }
                return BadRequest(result.Errors);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Lỗi khi thêm vai trò.");
                return StatusCode(500, "Đã xảy ra lỗi trong quá trình xử lý yêu cầu.");
            }
        }

        // Xóa vai trò theo tên
        [HttpDelete("delete-role/{roleName}")]
        public async Task<IActionResult> DeleteRoleAsync(string roleName)
        {
            if (string.IsNullOrWhiteSpace(roleName))
            {
                return BadRequest("Tên vai trò không được để trống.");
            }

            try
            {
                // Tìm vai trò theo tên
                var role = await roleManager.FindByNameAsync(roleName);
                if (role == null)
                {
                    return NotFound("Vai trò không tồn tại.");
                }

                // Xóa vai trò
                var result = await roleManager.DeleteAsync(role);
                if (result.Succeeded)
                {
                    return Ok("Xóa vai trò thành công.");
                }
                return BadRequest(result.Errors);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, $"Lỗi khi xóa vai trò {roleName}.");
                return StatusCode(500, "Đã xảy ra lỗi trong quá trình xử lý yêu cầu.");
            }
        }
    }
}
*/