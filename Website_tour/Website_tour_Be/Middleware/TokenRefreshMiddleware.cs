using System.IdentityModel.Tokens.Jwt;
using Website_tour_Be.Models;
using Website_tour_Be.Services;
using Microsoft.AspNetCore.Identity;

namespace Website_tour_Be.Middleware
{
    public class TokenRefreshMiddleware
    {
        private readonly RequestDelegate _next;
        private readonly JwtTokenService _jwtTokenService;
        private readonly UserManager<User> _userManager;

        public TokenRefreshMiddleware(RequestDelegate next, JwtTokenService jwtTokenService, UserManager<User> userManager)
        {
            _next = next;
            _jwtTokenService = jwtTokenService;
            _userManager = userManager;
        }

        public async Task Invoke(HttpContext context)
        {
            // Kiểm tra xác thực và Authorization header
            if (context.User.Identity.IsAuthenticated &&
                context.Request.Headers.TryGetValue("Authorization", out var authHeader))
            {
                var accessToken = authHeader.ToString().Replace("Bearer ", "");

                if (!string.IsNullOrEmpty(accessToken))
                {
                    var tokenHandler = new JwtSecurityTokenHandler();
                    var token = tokenHandler.ReadToken(accessToken) as JwtSecurityToken;

                    // Kiểm tra thời gian hết hạn của token
                    if (token != null && token.ValidTo < DateTime.UtcNow.AddMinutes(2)) // Nếu còn lại dưới 2 phút
                    {
                        var userId = token.Claims.First(c => c.Type == "UserId").Value;
                        var user = await _userManager.FindByIdAsync(userId);

                        if (user != null)
                        {
                            var userRoles = await _userManager.GetRolesAsync(user);
                            var tokenModel = await _jwtTokenService.GenerateToken(user, userRoles);

                            // Thêm token mới vào headers phản hồi
                            context.Response.Headers.Add("New-Access-Token", tokenModel.AccessToken);
                            context.Response.Headers.Add("New-Refresh-Token", tokenModel.RefreshToken);
                        }
                        else
                        {
                            // Xử lý trường hợp không tìm thấy người dùng
                            context.Response.StatusCode = StatusCodes.Status404NotFound;
                        }
                    }
                }
            }

            await _next(context); // Tiếp tục với pipeline
        }

    }
}
