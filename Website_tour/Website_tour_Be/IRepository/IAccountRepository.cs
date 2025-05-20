using Microsoft.AspNetCore.Identity;
using Website_tour_Be.Models;

namespace Website_tour_Be.IRepository
{
    public interface IAccountRepository
    {
        public Task<IdentityResult> SignUpAsync(SignUpModel model);
        public Task<TokenModel> SignInAsync(SignInModel model);






    }
}
