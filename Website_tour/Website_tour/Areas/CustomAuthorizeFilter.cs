using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Filters;

public class CustomAuthorizeFilter : AuthorizeAttribute, IAuthorizationFilter
{
    public void OnAuthorization(AuthorizationFilterContext context)
    {
        // Kiểm tra xem người dùng có quyền truy cập hay không
        if (context.HttpContext.User.Identity.IsAuthenticated == false)
        {
            // Nếu không có quyền, chuyển hướng về trang Index
            context.Result = new RedirectToActionResult("Index", "Home", new { area = "" });
        }
    }
}