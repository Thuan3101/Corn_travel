using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Website_tour_Be.Models;


namespace Website_tour_Be.Data
{
    [Table("RefreshToken")]
    public class RefreshToken
    {
        [Key]
        public Guid Id { get; set; }
        [Required]
        public string UserId { get; set; }
        [ForeignKey(nameof(UserId))]
        public User? User { get; set; }
        public string? Token { get; set; }
        public string? JwtId { get; set; }
        
        public bool IsUsed { get; set; }

        

        public bool IsRevoked { get; set; }
        public DateTime IssuedAt { get; set; }

        // Thời gian tao
        public DateTime ExpiredAt { get; set; }
    }
}
