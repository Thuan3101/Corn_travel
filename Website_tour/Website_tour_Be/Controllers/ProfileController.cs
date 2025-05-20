using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using System.Security.Claims;
using Website_tour_Be.Models;
using Website_tour_Be.repositories;
using Website_tour_Be.Repositories;

namespace Website_tour_Be.Controllers
{
    [Route("api/profile")]
    [ApiController]
    [Authorize(AuthenticationSchemes = JwtBearerDefaults.AuthenticationScheme)]
    public class ProfileController : ControllerBase
    {
        private readonly IProfileRepository _profileRepository;
        private readonly UserManager<User> _userManager;

        public ProfileController(IProfileRepository profileRepository, UserManager<User> userManager)
        {
            _profileRepository = profileRepository;
            _userManager = userManager;
        }

        [HttpGet("{userId}")]
        [Authorize(Roles = "Admin, Manage, Customer")]
        public async Task<IActionResult> GetUserProfile(string userId)
        {
            var profile = await _profileRepository.GetUserProfileAsync(userId);
            if (profile == null)
            {
                return NotFound();
            }

            return Ok(new ProfileModel
            {
                FirstName = profile.FirstName,
                LastName = profile.LastName,
                PhoneNumber = profile.PhoneNumber,
                Address = profile.Address,
                BirthDate = profile.BirthDate,
                Gender = profile.Gender,
                Email = profile.Email
            });
        }

        [HttpPut]
        [Route("update-profile/{userId}")]
        public async Task<IActionResult> UpdateUserProfile(string userId, [FromBody] ProfileModel profile)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            // Lấy thông tin người dùng từ token
            var user = await _userManager.FindByIdAsync(userId);
            if (user == null)
            {
                return NotFound("User not found");
            }

            // Kiểm tra mật khẩu cũ
            if (!BCrypt.Net.BCrypt.Verify(profile.OldPassword, user.PasswordHash))
            {
                return BadRequest("Mật khẩu cũ không đúng.");
            }

            // Cập nhật hồ sơ
            user.FirstName = profile.FirstName;
            user.LastName = profile.LastName;
            user.PhoneNumber = profile.PhoneNumber;
            user.Address = profile.Address;
            user.BirthDate = profile.BirthDate;
            user.Gender = profile.Gender;

            var result = await _userManager.UpdateAsync(user);
            if (!result.Succeeded)
            {
                return BadRequest("Failed to update profile");
            }

            return Ok("Profile updated successfully");
        }









        [HttpPut("{userId}/email")]
        [Authorize(Roles = "Admin, Manage, Customer")]
        public async Task<IActionResult> UpdateEmail(string userId, [FromBody] string email)
        {
            var result = await _profileRepository.UpdateEmailAsync(userId, email);
            if (!result)
            {
                return NotFound();
            }

            return Ok(new { message = "Cập nhật email thành công" });
        }



    }

    
}
