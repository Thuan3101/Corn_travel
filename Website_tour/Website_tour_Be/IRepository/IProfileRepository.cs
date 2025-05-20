using Website_tour_Be.Models;
using System.Threading.Tasks;

public interface IProfileRepository
{
    Task<User> GetUserProfileAsync(string userId);
    Task<bool> UpdateUserProfileAsync(string userId, ProfileModel profile);
    Task<bool> UpdateEmailAsync(string userId, string email);

    //Xac thuc ho so nguoi dung
    Task<bool> ValidateUserProfile(ProfileModel profile);
}
