using Microsoft.AspNetCore.Identity;
using System.Threading.Tasks;
using Website_tour_Be.Models;

namespace Website_tour_Be.Repositories
{
    public class ProfileRepository : IProfileRepository
    {
        private readonly UserManager<User> _userManager;

        public ProfileRepository(UserManager<User> userManager)
        {
            _userManager = userManager;
        }

        public async Task<User> GetUserProfileAsync(string userId)
        {
            return await _userManager.FindByIdAsync(userId);
        }

        public async Task<bool> UpdateUserProfileAsync(string userId, ProfileModel profile)
        {
            var user = await _userManager.FindByIdAsync(userId);
            if (user == null) return false;
            user.Email = profile.Email;
            user.FirstName = profile.FirstName;
            user.LastName = profile.LastName;
            user.PhoneNumber = profile.PhoneNumber;
            user.Address = profile.Address;
            user.BirthDate = profile.BirthDate;
            user.Gender = profile.Gender;

            var result = await _userManager.UpdateAsync(user);
            return result.Succeeded;
        }

        public async Task<bool> UpdateEmailAsync(string userId, string email)
        {
            var user = await _userManager.FindByIdAsync(userId);
            if (user == null) return false;

            user.Email = email;
            var result = await _userManager.UpdateAsync(user);
            return result.Succeeded;
        }

        // Phương thức cập nhật mật khẩu mới đã bị xóa
        // public async Task<bool> UpdatePasswordAsync(string userId, string oldPassword, string newPassword) { ... }

        public async Task<bool> ValidateUserProfile(ProfileModel profile)
        {
            // Validate the profile based on your business logic.
            return true;
        }
    }
}
