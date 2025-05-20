/*using Firebase.Auth;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace Website_tour_Be.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ConfigController : ControllerBase
    {
        private readonly IConfiguration _configuration;

        // Thêm ILogger vào constructor của controller
        private readonly ILogger<ConfigController> _logger;

        public ConfigController(IConfiguration configuration, ILogger<ConfigController> logger)
        {
            _configuration = configuration;
            _logger = logger;
        }

        [HttpGet("firebase")]
        public IActionResult GetFirebaseConfig()
        {
            var firebaseConfig = _configuration.GetSection("Firebase").Get<FirebaseConfig>();

            // Log để kiểm tra firebaseConfig
            _logger.LogInformation("FirebaseConfig: {Config}", firebaseConfig);

            if (firebaseConfig == null)
            {
                _logger.LogWarning("Firebase configuration not found.");
                return NotFound("Firebase configuration not found.");
            }

            return Ok(firebaseConfig);
        }
    }

    public class FirebaseConfig
    {
        public String ApiKey { get; set; }
        public String? Bucket { get; set; }
        public String? ProjectId { get; set; }
        public String? AuthDomain { get; set; }
    }
}
*/