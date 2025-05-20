using Microsoft.AspNetCore.Identity;
using Website_tour_Be.Models;

namespace Website_tour_Be.IRepository
{
    public interface IUsersRolesRepository
    {
        //Lay roles 
        public Task<List<string>> GetAllRolesAsync();

        // xem user va roles
        public Task<List<UserRoleModel>> GetAllUsersAndRolesAsync();
        // xem user va roles theo id
        public Task<UserRoleModel> GetUserAndRolesAsync(string id);

        // edit
        public Task<IdentityResult> AddUserAsync(UserRoleModel model);
        // update
        public Task<IdentityResult> UpdateUserAsync(string userId, UserRoleModel model);
        // delete
        public Task<IdentityResult> DeleteUserAsync(string id);
    }
}
