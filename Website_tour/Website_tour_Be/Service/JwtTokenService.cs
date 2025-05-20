using Microsoft.Extensions.Configuration;
using Microsoft.IdentityModel.Tokens;
using System;
using System.Collections.Generic;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;
using Website_tour_Be.Models;
using System.Security.Cryptography;
using Website_tour_Be.Data;

namespace Website_tour_Be.Services
{
    public class JwtTokenService
    {
        private readonly IConfiguration _configuration;
        private readonly ToursStoresContext _context; // Đảm bảo thay thế với DbContext thực tế của bạn

        public JwtTokenService(IConfiguration configuration, ToursStoresContext context)
        {
            _configuration = configuration;
            _context = context;
        }

        public async Task<TokenModel> GenerateToken(User user, IList<string> userRoles)
        {
            // Tiến hành tạo claims
            var authClaims = new List<Claim>
            {
                new Claim("UserId", user.Id),
                new Claim(ClaimTypes.Name, user.Email),
                new Claim(JwtRegisteredClaimNames.Jti, Guid.NewGuid().ToString()),
                new Claim(JwtRegisteredClaimNames.Email, user.Email),
                new Claim(JwtRegisteredClaimNames.Sub, user.Email),
                new Claim("FirstName", user.FirstName),
                new Claim("LastName", user.LastName),
                new Claim("PhoneNumber", user.PhoneNumber),
                new Claim("Address", user.Address),
                new Claim("BirthDate", user.BirthDate.ToString("yyyy-MM-dd")),
                new Claim("Gender", user.Gender),
                new Claim(ClaimTypes.Email, user.Email)
            };

            // Thêm vai trò người dùng vào claims
            foreach (var role in userRoles)
            {
                authClaims.Add(new Claim(ClaimTypes.Role, role));
            }

            // Tạo khóa ký
            var authenKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(_configuration["JWT:Secret"]));

            // Tạo token JWT
            var token = new JwtSecurityToken(
                issuer: _configuration["JWT:ValidIssuer"],
                audience: _configuration["JWT:ValidAudience"],
                expires: DateTime.UtcNow.AddHours(3), // Thay đổi thời gian hết hạn nếu cần
                claims: authClaims,
                signingCredentials: new SigningCredentials(authenKey, SecurityAlgorithms.HmacSha512Signature)
            );

            var tokenHandler = new JwtSecurityTokenHandler();
            var accessToken = tokenHandler.WriteToken(token);
            var refreshToken = GenerateRefreshToken();

            // Lưu Refresh Token vào cơ sở dữ liệu
            var refreshTokenEntity = new RefreshToken
            {
                Id = Guid.NewGuid(),
                UserId = user.Id,
                Token = refreshToken,
                JwtId = token.Id,
                IsUsed = false,
                IsRevoked = false,
                IssuedAt = DateTime.UtcNow,
                ExpiredAt = DateTime.UtcNow.AddHours(1),
            };

            await _context.RefreshTokens.AddAsync(refreshTokenEntity);
            await _context.SaveChangesAsync();


            return new TokenModel
            {
                AccessToken = accessToken,
                RefreshToken = refreshToken,
                Expiration = token.ValidTo // Lưu thời gian hết hạn của Access Token
            };
        }

        private string GenerateRefreshToken()
        {
            var random = new byte[32];
            using (var rng = RandomNumberGenerator.Create())
            {
                rng.GetBytes(random);
                return Convert.ToBase64String(random);
            }
        }


    }
}
