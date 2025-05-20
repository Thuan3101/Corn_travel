using MailKit.Net.Smtp;
using MimeKit;
using Microsoft.Extensions.Options;
using Website_tour_Be.Data;
using MailKit.Security;

public class EmailService
{
    private readonly IConfiguration _configuration;

    public EmailService(IConfiguration configuration)
    {
        _configuration = configuration;
    }

    public async Task SendEmailAsync(string recipientEmail, string subject, string message)
    {
        var email = _configuration["EmailSettings:SenderEmail"];
        var password = _configuration["EmailSettings:Password"];

        using (var client = new SmtpClient())
        {
            client.Connect(_configuration["EmailSettings:SmtpServer"], int.Parse(_configuration["EmailSettings:SmtpPort"]), SecureSocketOptions.StartTls);
            client.Authenticate(email, password);

            var emailMessage = new MimeMessage();
            emailMessage.From.Add(new MailboxAddress("ToursStores", email));
            emailMessage.To.Add(new MailboxAddress("", recipientEmail));
            emailMessage.Subject = subject;
            emailMessage.Body = new TextPart("plain") { Text = message };

            await client.SendAsync(emailMessage);
            client.Disconnect(true);
        }
    }
}

