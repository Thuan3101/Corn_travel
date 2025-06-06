﻿namespace Website_tour_Be.Models
{
    public class UserRoleModel
    {
        public string? UserId { get; set; }
        public string? Email { get; set; }
        public string? FirstName { get; set; }
        public string? LastName { get; set; }
        public string? PhoneNumber { get; set; }
        public string? Gender { get; set; }
        public DateTime BirthDate { get; set; }
        public DateTime CreatedAt { get; set; }
        public string? Address { get; set; }
        public string? Password { get; set; }   // Mật khẩu của người dùng (đã được hash)
        public List<string> Role { get; set; } = new List<string>();
    }


}
