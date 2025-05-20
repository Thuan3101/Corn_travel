namespace Website_tour_Be.Data
{
    public class EmailSettings
    {
        public string? SmtpServer { get; set; }
        public int SmtpPort { get; set; }
        public string? SenderEmail { get; set; }
        public string? SenderName { get; set; }
        public string? Username { get; set; }
        public string? Password { get; set; }
        //thoi han 60s
        public DateTime ExpirationTime { get; set; } // Thời gian hết hạn OTP
    }

}
