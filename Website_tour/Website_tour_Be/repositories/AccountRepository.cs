using Microsoft.AspNetCore.Identity;
using Microsoft.IdentityModel.Tokens;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;
using Website_tour_Be.Data;
using Website_tour_Be.Models;
using BCrypt.Net;
using Microsoft.EntityFrameworkCore;
using Website_tour_Be.Services;
using Website_tour_Be.IRepository;  // Thêm thư viện BCrypt.Net

namespace Website_tour_Be.repositories
{
    public class AccountRepository : IAccountRepository
    {
        // Khai báo các dịch vụ cần sử dụng
        
        private readonly UserManager<User> userManager;
        private readonly SignInManager<User> signInManager;
        
        private readonly RoleManager<IdentityRole> roleManeger;
        private readonly ILogger<AccountRepository> _logger;
        private readonly JwtTokenService _jwtTokenService; // Thêm dịch vụ JWT

        // Khởi tạo
        public AccountRepository(UserManager<User> userManager, SignInManager<User> signInManager,  RoleManager<IdentityRole> roleManeger, ILogger<AccountRepository> logger, JwtTokenService jwtTokenService)
        {
            this.userManager = userManager;
            this.signInManager = signInManager;
            
            this.roleManeger = roleManeger;
            this._logger = logger;
            this._jwtTokenService = jwtTokenService; // Khởi tạo dịch vụ JWT
        }

        // Đăng nhập
        public async Task<TokenModel> SignInAsync(SignInModel model)
        {
            var user = await userManager.FindByEmailAsync(model.Email);

            // Sử dụng BCrypt để kiểm tra mật khẩu
            if (user == null || !BCrypt.Net.BCrypt.Verify(model.Password, user.PasswordHash))
            {
                return null; // Return null if credentials are invalid
            }

            // Lấy vai trò người dùng
            var userRoles = await userManager.GetRolesAsync(user);

            // Tạo token JWT
            var tokenModel = await _jwtTokenService.GenerateToken(user, userRoles);

            return tokenModel; // Trả về cả AccessToken và RefreshToken
        }



        // Đăng ký tài khoản
        public async Task<IdentityResult> SignUpAsync(SignUpModel model)
        {
            // Kiểm tra xem user đã tồn tại hay chưa
            var existingUser = await userManager.FindByEmailAsync(model.Email);
            if (existingUser != null)
            {
                // Trả về lỗi nếu email đã được sử dụng
                var errors = new List<IdentityError>
        {
            new IdentityError { Description = "Email đã được sử dụng." }
        };
                return IdentityResult.Failed(errors.ToArray());
            }

            // Sử dụng BCrypt với độ khó 12 bit để băm mật khẩu
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
                PasswordHash = hashedPassword // Gán mật khẩu đã băm vào trường PasswordHash
            };

            // Tạo user không sử dụng mật khẩu từ UserManager nữa
            var result = await userManager.CreateAsync(user);

            if (result.Succeeded)
            {
                // Tạo và kiểm tra role
                var roles = new List<string> { Role.Admin, Role.Customer, Role.Manage };
                foreach (var role in roles)
                {
                    if (!await roleManeger.RoleExistsAsync(role))
                    {
                        var roleResult = await roleManeger.CreateAsync(new IdentityRole(role));
                        if (!roleResult.Succeeded)
                        {
                            _logger.LogError("Error creating role: " + string.Join(", ", roleResult.Errors.Select(e => e.Description)));
                        }
                    }
                }

                // Thêm vai trò mặc định cho user
                var addRoleResult = await userManager.AddToRoleAsync(user, Role.Customer); // Gán role Customer mặc định
                if (!addRoleResult.Succeeded)
                {
                    _logger.LogError("Error adding role to user: " + string.Join(", ", addRoleResult.Errors.Select(e => e.Description)));
                }
            }
            else
            {
                _logger.LogError("User creation failed: " + string.Join(", ", result.Errors.Select(e => e.Description)));
            }

            return result;
        }
    }
}


