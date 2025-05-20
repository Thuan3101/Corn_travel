using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;
using System;
using System.Threading.Tasks;
using Website_tour_Be.Data;
using Website_tour_Be.IRepository;
using Website_tour_Be.Models;
using Website_tour_Be.Services;

namespace Website_tour_Be.Controllers
{
    [Route("api/")]
    [ApiController]
    [Authorize(AuthenticationSchemes = JwtBearerDefaults.AuthenticationScheme)]
    public class AccountsController : ControllerBase
    {
        private readonly IAccountRepository accountRepo;
        private readonly ILogger<AccountsController> _logger;
        private readonly IAccountRepository _accountRepository;
        private readonly UserManager<User> _userManager;
        private readonly JwtTokenService _jwtTokenService;
        private readonly ToursStoresContext _context;

        public AccountsController(IAccountRepository repo, ILogger<AccountsController> logger, IAccountRepository accountRepository, UserManager<User> userManager, JwtTokenService jwtTokenService, ToursStoresContext context)
        {
            accountRepo = repo;
            _logger = logger;
            _accountRepository = accountRepository;
            _userManager = userManager;
            _jwtTokenService = jwtTokenService;
            _context = context;
        }

        [HttpPost("signup")]
        [AllowAnonymous]
        public async Task<IActionResult> SignUp([FromBody] SignUpModel signUpModel)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            IdentityResult result;

            try
            {
                result = await accountRepo.SignUpAsync(signUpModel);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Đã xảy ra lỗi khi đăng ký người dùng.");
                return StatusCode(500, "Đã xảy ra lỗi trong quá trình xử lý yêu cầu.");
            }

            if (result.Succeeded)
            {
                return Ok(result.Succeeded);
            }
            else
            {
                return BadRequest(result.Errors);
            }
        }

        [HttpPost("signin")]
        [AllowAnonymous]
        public async Task<IActionResult> SignIn([FromBody] SignInModel model)
        {
            if (ModelState.IsValid)
            {
                var tokenModel = await _accountRepository.SignInAsync(model);
                if (tokenModel == null)
                {
                    return Unauthorized();
                }
                return Ok(new
                {
                    Success = true,
                    message = "Authenticate success",
                    data = new
                    {
                        AccessToken = tokenModel.AccessToken,
                        RefreshToken = tokenModel.RefreshToken,
                        Expiration = tokenModel.Expiration
                    }
                });
            }
            return BadRequest(ModelState);
        }

        [HttpPost("refresh-token")]
        public async Task<IActionResult> RefreshToken([FromBody] RefreshTokenRequest request)
        {
            var storedRefreshToken = await _context.RefreshTokens.SingleOrDefaultAsync(rt => rt.Token == request.RefreshToken);

            if (storedRefreshToken == null || storedRefreshToken.IsRevoked || storedRefreshToken.IsUsed)
            {
                return Unauthorized();
            }

            var user = await _userManager.FindByIdAsync(storedRefreshToken.UserId);
            var userRoles = await _userManager.GetRolesAsync(user);

            var tokenModel = await _jwtTokenService.GenerateToken(user, userRoles);

            storedRefreshToken.IsUsed = true;
            await _context.SaveChangesAsync();

            return Ok(tokenModel);
        }
        public class RefreshTokenRequest
        {
            public string? RefreshToken { get; set; }
        }
    }
}
