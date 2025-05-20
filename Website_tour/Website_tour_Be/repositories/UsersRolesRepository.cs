using Microsoft.AspNetCore.Identity;  // Đảm bảo sử dụng Microsoft.AspNetCore.Identity
using Microsoft.EntityFrameworkCore;
using BCrypt.Net;
using Website_tour_Be.Models;
using Microsoft.Extensions.Logging;
using Website_tour_Be.repositories;
using Website_tour_Be.IRepository;

namespace Website_tour_Be.Repositories
{
    public class UsersRolesRepository : IUsersRolesRepository
    {
        private readonly UserManager<User> _userManager;
        private readonly RoleManager<IdentityRole> _roleManager;
        private readonly ILogger<AccountRepository> _logger;

        public UsersRolesRepository(UserManager<User> userManager, RoleManager<IdentityRole> roleManager, ILogger<AccountRepository> logger)
        {
            _userManager = userManager;
            _roleManager = roleManager;
            _logger = logger;
        }

        public async Task<List<UserRoleModel>> GetAllUsersAndRolesAsync()
        {
            var users = _userManager.Users.ToList();
            var userRoleModels = new List<UserRoleModel>();

            foreach (var user in users)
            {
                var roles = await _userManager.GetRolesAsync(user);
                var userRoleModel = new UserRoleModel
                {
                    UserId = user.Id,
                    Email = user.Email,
                    FirstName = user.FirstName,
                    LastName = user.LastName,
                    PhoneNumber = user.PhoneNumber,
                    Gender = user.Gender,
                    BirthDate = user.BirthDate,
                    CreatedAt = user.CreatedAt,
                    Address = user.Address,
                    Password = user.PasswordHash,
                    Role = roles.ToList()
                };
                userRoleModels.Add(userRoleModel);
            }

            return userRoleModels;
        }

        public async Task<UserRoleModel> GetUserAndRolesAsync(string id)
        {
            var user = await _userManager.FindByIdAsync(id);
            if (user == null)
            {
                return null;
            }

            var roles = await _userManager.GetRolesAsync(user);
            var userRoleModel = new UserRoleModel
            {
                UserId = user.Id,
                Email = user.Email,
                FirstName = user.FirstName,
                LastName = user.LastName,
                PhoneNumber = user.PhoneNumber,
                Gender = user.Gender,
                BirthDate = user.BirthDate,
                CreatedAt = user.CreatedAt,
                Address = user.Address,
                Password = user.PasswordHash,
                Role = roles.ToList()
            };

            return userRoleModel;
        }

        public async Task<IdentityResult> AddUserAsync(UserRoleModel model)
        {
            var existingUser = await _userManager.FindByEmailAsync(model.Email);
            if (existingUser != null)
            {
                return IdentityResult.Failed(new IdentityError { Description = "Email đã tồn tại." });
            }

            if (string.IsNullOrWhiteSpace(model.Password))
            {
                return IdentityResult.Failed(new IdentityError { Description = "Mật khẩu không được để trống." });
            }

            var hashedPassword = BCrypt.Net.BCrypt.HashPassword(model.Password, workFactor: 12);
            var user = new User
            {
                FirstName = model.FirstName,
                LastName = model.LastName,
                Email = model.Email,
                UserName = model.Email,
                PhoneNumber = model.PhoneNumber,
                Address = model.Address,
                BirthDate = model.BirthDate,
                Gender = model.Gender,
                PasswordHash = hashedPassword
            };

            var result = await _userManager.CreateAsync(user);
            if (!result.Succeeded)
            {
                _logger.LogWarning("Thêm người dùng không thành công: {Errors}", string.Join(", ", result.Errors.Select(e => e.Description)));
                return result;
            }

            if (model.Role == null || !model.Role.Any())
            {
                return IdentityResult.Failed(new IdentityError { Description = "Phải gán ít nhất một vai trò cho người dùng." });
            }

            var addRoleResult = await _userManager.AddToRolesAsync(user, model.Role);
            if (!addRoleResult.Succeeded)
            {
                await _userManager.DeleteAsync(user);
                _logger.LogWarning("Gán vai trò không thành công: {Errors}", string.Join(", ", addRoleResult.Errors.Select(e => e.Description)));
                return addRoleResult;
            }

            return result;
        }

        public async Task<IdentityResult> UpdateUserAsync(string userId, UserRoleModel model)
        {
            var user = await _userManager.FindByIdAsync(model.UserId);
            if (user == null)
            {
                return IdentityResult.Failed(new IdentityError { Description = "Người dùng không tồn tại." });
            }

            user.FirstName = model.FirstName;
            user.LastName = model.LastName;
            user.PhoneNumber = model.PhoneNumber;
            user.Address = model.Address;
            user.BirthDate = model.BirthDate;
            user.Gender = model.Gender;

            if (!string.IsNullOrEmpty(model.Password))
            {
                var hashedPassword = BCrypt.Net.BCrypt.HashPassword(model.Password);
                user.PasswordHash = hashedPassword;
            }

            var result = await _userManager.UpdateAsync(user);
            if (!result.Succeeded)
            {
                return result;
            }

            var currentRoles = await _userManager.GetRolesAsync(user);
            var rolesToRemove = currentRoles.Except(model.Role).ToList();
            if (rolesToRemove.Any())
            {
                var removeRoleResult = await _userManager.RemoveFromRolesAsync(user, rolesToRemove);
                if (!removeRoleResult.Succeeded)
                {
                    return removeRoleResult;
                }
            }

            var rolesToAdd = model.Role.Except(currentRoles).ToList();
            if (rolesToAdd.Any())
            {
                var addRoleResult = await _userManager.AddToRolesAsync(user, rolesToAdd);
                if (!addRoleResult.Succeeded)
                {
                    return addRoleResult;
                }
            }

            return IdentityResult.Success;
        }

        public async Task<IdentityResult> DeleteUserAsync(string id)
        {
            var user = await _userManager.FindByIdAsync(id);
            if (user == null)
            {
                return IdentityResult.Failed(new IdentityError { Description = "Người dùng không tồn tại." });
            }

            var result = await _userManager.DeleteAsync(user);
            return result;
        }

        public async Task<List<string>> GetAllRolesAsync()
        {
            try
            {
                var roles = await _roleManager.Roles.Select(r => r.Name).ToListAsync();
                return roles;
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Đã xảy ra lỗi khi lấy danh sách các vai trò.");
                throw;
            }
        }
    }
}
