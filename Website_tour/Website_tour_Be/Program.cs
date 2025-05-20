using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;
using Microsoft.IdentityModel.Tokens;
using Microsoft.OpenApi.Models;
using System.Text;
using Website_tour_Be.Data;
using Website_tour_Be.IRepository;
using Website_tour_Be.Models;
using Website_tour_Be.repositories;
using Website_tour_Be.Repositories;
using Website_tour_Be.Services;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
builder.Services.AddControllers();
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen(options =>
{
    options.SwaggerDoc("v1", new OpenApiInfo { Title = "Tours API", Version = "v1" });
    options.AddSecurityDefinition("Bearer", new OpenApiSecurityScheme
    {
        In = ParameterLocation.Header,
        Description = "Please enter a valid token",
        Name = "Authorization",
        Type = SecuritySchemeType.Http,
        BearerFormat = "JWT",
        Scheme = "Bearer"
    });
    options.AddSecurityRequirement(new OpenApiSecurityRequirement
    {
        {
            new OpenApiSecurityScheme
            {
                Reference = new OpenApiReference
                {
                    Type=ReferenceType.SecurityScheme,
                    Id="Bearer"
                }
            },
            new string[]{}
        }
    });
});

// Cau hinh DbContext
builder.Services.AddDbContext<ToursStoresContext>(options =>
{
    var connectionString = builder.Configuration.GetConnectionString("ToursStore");
    options.UseMySql(connectionString, ServerVersion.AutoDetect(connectionString));
});

// Cau hinh DI repository
builder.Services.AddScoped(typeof(IRepository<>), typeof(Repository<>));
builder.Services.AddScoped<IAccountRepository, AccountRepository>();
builder.Services.AddScoped<IUsersRolesRepository, UsersRolesRepository>();
builder.Services.AddScoped<ITourTypeRepository, TourTypeRepository>();
builder.Services.AddScoped<IProfileRepository, ProfileRepository>();
builder.Services.AddScoped<JwtTokenService>();


// Đăng ký IMemoryCache
builder.Services.AddMemoryCache();
builder.Services.AddScoped<EmailService>();

// Cau hinh Json
builder.Services.AddControllers()
        .AddJsonOptions(options =>
        {
            options.JsonSerializerOptions.ReferenceHandler = System.Text.Json.Serialization.ReferenceHandler.IgnoreCycles;
            options.JsonSerializerOptions.DefaultIgnoreCondition = System.Text.Json.Serialization.JsonIgnoreCondition.WhenWritingNull;
        });

// Cau hinh JWT token
IConfiguration Configuration = builder.Configuration;
builder.Services.AddAuthentication(options =>
{
    options.DefaultAuthenticateScheme = JwtBearerDefaults.AuthenticationScheme;
    options.DefaultChallengeScheme = JwtBearerDefaults.AuthenticationScheme;
})
.AddJwtBearer(options =>
{
    options.TokenValidationParameters = new TokenValidationParameters
    {
        ValidateIssuer = true,
        ValidateAudience = true,
        ValidateLifetime = true,
        ValidateIssuerSigningKey = true,
        ValidIssuer = Configuration["Jwt:ValidIssuer"],
        ValidAudience = Configuration["Jwt:ValidAudience"],
        IssuerSigningKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(Configuration["Jwt:Secret"]))
    };
});

//Cau hinh firebase
builder.Services.Configure<FirebaseConfigurationModel>(
builder.Configuration.GetSection("FirebaseConfiguration"));
builder.Services.AddScoped<IFirebaseRepository, FirebaseRepository>();
builder.Services.AddAutoMapper(typeof(Program));

// Configure Identity
builder.Services.AddIdentity<User, IdentityRole>()
    .AddEntityFrameworkStores<ToursStoresContext>()
    .AddDefaultTokenProviders();

// Configure CORS
builder.Services.AddCors(options =>
{
    options.AddPolicy("CornTravel", build =>
    {
        build.WithOrigins("https://corntravel.azurewebsites.net", "https://localhost:44305") // localhost for local dev
             .AllowAnyHeader()
             .AllowAnyMethod()
             .AllowCredentials();
    });
});


// Build the app
var app = builder.Build();

// Configure middleware
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseHttpsRedirection();
app.UseCors("CornTravel");
app.UseAuthentication();
app.UseAuthorization();
app.MapControllers();
app.Run();
