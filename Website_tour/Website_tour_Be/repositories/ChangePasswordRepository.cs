using Microsoft.AspNetCore.Identity;
using BCrypt.Net;
using System.Threading.Tasks;
using Website_tour_Be.Models;
using Website_tour_Be.IRepository;

public class ChangePasswordRepository : IChangePasswordRepository
{
    private readonly UserManager<User> _userManager; // Sử dụng lớp User tùy chỉnh của bạn

    public ChangePasswordRepository(UserManager<User> userManager)
    {
        _userManager = userManager;
    }

    public async Task<bool> ChangePasswordAsync(string userId, string oldPassword, string newPassword)
    {
        var user = await _userManager.FindByIdAsync(userId);
        if (user == null)
        {
            return false; // Người dùng không tồn tại
        }

        // Kiểm tra mật khẩu cũ
        if (!BCrypt.Net.BCrypt.Verify(oldPassword, user.PasswordHash))
        {
            return false; // Mật khẩu cũ không đúng
        }

        // Băm mật khẩu mới
        user.PasswordHash = BCrypt.Net.BCrypt.HashPassword(newPassword, workFactor: 12);
        var updateResult = await _userManager.UpdateAsync(user);

        return updateResult.Succeeded;
    }
}
