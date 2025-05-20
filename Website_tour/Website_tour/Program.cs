using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Builder;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using Microsoft.IdentityModel.Tokens;
using System.Text;

internal class Program
{
    private static void Main(string[] args)
    {
        var builder = WebApplication.CreateBuilder(args);

        // Thêm các dịch vụ vào container.
        builder.Services.AddControllersWithViews();
        // Cấu hình JWT Authentication
        builder.Services.AddAuthentication(JwtBearerDefaults.AuthenticationScheme)
            .AddJwtBearer(options =>
            {
                options.TokenValidationParameters = new TokenValidationParameters
                {
                    ValidateIssuer = true,
                    ValidateAudience = true,
                    ValidateLifetime = true,
                    ValidateIssuerSigningKey = true,
                    ValidIssuer = builder.Configuration["Jwt:ValidIssuer"],
                    ValidAudience = builder.Configuration["Jwt:ValidAudience"],
                    IssuerSigningKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(builder.Configuration["Jwt:Secret"]))
                };

                // Xử lý sự kiện từ chối truy cập
                options.Events = new JwtBearerEvents
                {
                    OnAuthenticationFailed = context =>
                    {
                        context.Response.Headers["Access-Control-Allow-Origin"] = "*"; // Tùy chỉnh nếu cần
                        return Task.CompletedTask;
                    },
                    OnForbidden = context =>
                    {
                        context.Response.StatusCode = StatusCodes.Status403Forbidden; // Forbidden
                        context.Response.ContentType = "application/json";
                        var result = System.Text.Json.JsonSerializer.Serialize(new { message = "Access Denied" });
                        return context.Response.WriteAsync(result);
                    }
                };
            });



        var app = builder.Build();

        // Cấu hình pipeline xử lý HTTP request.
        if (!app.Environment.IsDevelopment())
        {
            app.UseExceptionHandler("/Home/Error");
            // Giá trị mặc định của HSTS là 30 ngày. Có thể thay đổi cho môi trường sản xuất, xem thêm tại https://aka.ms/aspnetcore-hsts.
            app.UseHsts();
        }

        app.UseHttpsRedirection();
        app.UseStaticFiles();

        app.UseRouting();

        app.UseAuthentication(); // Phải có dòng này
        app.UseAuthorization();

        /*app.MapControllerRoute(
            name: "productDetail",
            pattern: "product/detail/{id?}",
            defaults: new { controller = "Product", action = "Detail" });*/


        /*app.MapControllerRoute(
            name: "areaRoute",
            pattern: "{area:exists}/{controller=Dashboard}/{action=Index}/{id?}"
        );*/

        app.MapAreaControllerRoute(
            name: "Manage",
            areaName: "Manage",
            pattern: "Manage/{controller=Dashboard}/{action=Index}/{id?}");

        app.MapAreaControllerRoute(
            name: "Admin",
            areaName: "Admin",
            pattern: "Admin/{controller=Dashboard}/{action=Index}/{id?}");
       
        // Định nghĩa route mặc định
        app.MapControllerRoute(
            name: "default",
        /* pattern: "{controller=Home}/{action=Index1}/{id?}");*/
        pattern: "{controller=Home}/{action=Index1}/{id?}");

        


        app.Run();
    }
}