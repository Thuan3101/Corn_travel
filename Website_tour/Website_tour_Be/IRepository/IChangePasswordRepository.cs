namespace Website_tour_Be.IRepository
{
    public interface IChangePasswordRepository
    {
        Task<bool> ChangePasswordAsync(string userId, string oldPassword, string newPassword);
    }

}
