using System;
using System.Collections.Generic;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore;
using Website_tour_Be.Data;
using Website_tour_Be.Models;

namespace Website_tour_Be.Data
{
    public class ToursStoresContext : IdentityDbContext<User>
    {
        public ToursStoresContext(DbContextOptions<ToursStoresContext> options)
            : base(options)
        {
        }

        #region DbSet Properties
        public DbSet<RefreshToken> RefreshTokens { get; set; }
        public DbSet<User> Users { get; set; }
        public DbSet<Tour> Tours { get; set; }
        public DbSet<TourType> TourTypes { get; set; }
        public DbSet<TourTranslation> TourTranslations { get; set; }
        public DbSet<TourImage> TourImages { get; set; }
        public DbSet<TourItinerary> TourItineraries { get; set; }
        public DbSet<TourDeparture> TourDepartures { get; set; }
        public DbSet<Booking> Bookings { get; set; }
        public DbSet<Payment> Payments { get; set; }
        public DbSet<Review> Reviews { get; set; }
        //public DbSet<Location> Locations { get; set; }
        //public DbSet<Hotel> Hotels { get; set; }
        //public DbSet<Room> Rooms { get; set; }
        //public DbSet<HotelImage> HotelImages { get; set; }
        //public DbSet<RoomImage> RoomImages { get; set; }
        //public DbSet<RoomBooking> RoomBookings { get; set; }
        //public DbSet<RoomBookingPayment> RoomBookingPayments { get; set; }
        //public DbSet<HotelReview> HotelReviews { get; set; }
        #endregion

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);

            // Xóa prefix AspNet của các bảng Identity
            foreach (var entityType in modelBuilder.Model.GetEntityTypes())
            {
                var tableName = entityType.GetTableName();
                if (tableName != null && tableName.StartsWith("AspNet"))
                {
                    entityType.SetTableName(tableName.Substring(6));
                }
            }


            // Cấu hình cho Tour
            modelBuilder.Entity<Tour>(entity =>
            {
                entity.HasKey(e => e.TourId);
                entity.HasIndex(e => e.Code).IsUnique();

                entity.HasOne(d => d.TourType)
                      .WithMany(t => t.Tours)
                      .HasForeignKey(d => d.TourTypeId)
                      .OnDelete(DeleteBehavior.Restrict);

                // Relationship với Reviews
                entity.HasMany(d => d.Reviews)
                      .WithOne(r => r.Tour)
                      .HasForeignKey(r => r.TourId)
                      .OnDelete(DeleteBehavior.Restrict);

                // Các relationship khác
                entity.HasMany(d => d.TourTranslations)
                      .WithOne(p => p.Tour)
                      .HasForeignKey(p => p.TourId)
                      .OnDelete(DeleteBehavior.Cascade);

                entity.HasMany(d => d.TourImages)
                      .WithOne(p => p.Tour)
                      .HasForeignKey(p => p.TourId)
                      .OnDelete(DeleteBehavior.Cascade);

                entity.HasMany(d => d.TourItineraries)
                      .WithOne(p => p.Tour)
                      .HasForeignKey(p => p.TourId)
                      .OnDelete(DeleteBehavior.Cascade);

                entity.HasMany(d => d.TourDepartures)
                      .WithOne(p => p.Tour)
                      .HasForeignKey(p => p.TourId)
                      .OnDelete(DeleteBehavior.Cascade);

                entity.HasMany(d => d.Bookings)
                      .WithOne(p => p.Tour)
                      .HasForeignKey(p => p.TourId)
                      .OnDelete(DeleteBehavior.Restrict);
            });


            // Cấu hình cho TourTranslation
            modelBuilder.Entity<TourTranslation>(entity =>
            {
                entity.HasKey(e => e.TranslationId);
                entity.HasIndex(e => new { e.TourId, e.LanguageCode }).IsUnique();
            });

            // Cấu hình cho TourImage
            /*modelBuilder.Entity<TourImage>(entity =>
            {
                entity.HasKey(e => e.ImageId);
                // Đảm bảo mỗi tour chỉ có một ảnh chính
                entity.HasIndex(e => new { e.TourId, e.IsMainImage })
                      .HasFilter("IsMainImage = 1")
                      .IsUnique();
            });*/
            /*modelBuilder.Entity<TourImage>(entity =>
            {
                entity.HasKey(e => e.ImageId);
                // Đảm bảo mỗi tour chỉ có một ảnh chính
                entity.HasIndex(e => new { e.TourId })
                      .IsUnique();
            });*/

            // Cấu hình cho TourItinerary
            modelBuilder.Entity<TourItinerary>(entity =>
            {
                entity.HasKey(e => e.ItineraryId);
                // Đảm bảo không trùng số thứ tự ngày trong cùng một tour và ngôn ngữ
                entity.HasIndex(e => new { e.TourId, e.LanguageCode, e.DayNumber }).IsUnique();
            });

            // Cấu hình cho TourDeparture
            modelBuilder.Entity<TourDeparture>(entity =>
            {
                entity.HasKey(e => e.DepartureId);
                entity.HasIndex(e => e.Code).IsUnique();
                entity.HasIndex(e => new { e.TourId, e.DepartureDate });
            });

            // Cấu hình cho Booking
            modelBuilder.Entity<Booking>(entity =>
            {
                entity.HasKey(e => e.BookingId);

                entity.HasOne(d => d.User)
                      .WithMany()
                      .HasForeignKey(d => d.UserId)
                      .OnDelete(DeleteBehavior.Restrict);

                entity.HasMany(d => d.Payments)
                      .WithOne(p => p.Booking)
                      .HasForeignKey(p => p.BookingId)
                      .OnDelete(DeleteBehavior.Restrict);
            });

            // Cấu hình cho Payment
            modelBuilder.Entity<Payment>(entity =>
            {
                entity.HasKey(e => e.PaymentId);
            });

            // Cấu hình cho TourType
            modelBuilder.Entity<TourType>(entity =>
            {
                entity.HasKey(e => e.TourTypeId);
                entity.HasIndex(e => e.Name).IsUnique();

                // Configure the one-to-many relationship with Tour
                entity.HasMany(t => t.Tours)
                      .WithOne(t => t.TourType)
                      .HasForeignKey(t => t.TourTypeId)
                      .OnDelete(DeleteBehavior.Restrict);
            });
            // Cấu hình cho Review
            modelBuilder.Entity<Review>(entity =>
            {
                entity.HasKey(e => e.ReviewId);

                entity.HasOne(d => d.User)
                      .WithMany()
                      .HasForeignKey(d => d.UserId)
                      .OnDelete(DeleteBehavior.Restrict);

                entity.HasOne(d => d.Tour)
                      .WithMany(t => t.Reviews)
                      .HasForeignKey(d => d.TourId)
                      .OnDelete(DeleteBehavior.Restrict);
            });

            // Index cho các trường thường được tìm kiếm
            modelBuilder.Entity<Tour>()
                .HasIndex(e => e.IsActive);

            modelBuilder.Entity<TourDeparture>()
                .HasIndex(e => e.Status);

            modelBuilder.Entity<Booking>()
                .HasIndex(e => e.Status);

            // Thêm các default value
            modelBuilder.Entity<Tour>()
                .Property(e => e.CreatedAt)
                .HasDefaultValueSql("CURRENT_TIMESTAMP");

            modelBuilder.Entity<TourDeparture>()
                .Property(e => e.CreatedAt)
                .HasDefaultValueSql("CURRENT_TIMESTAMP");

            modelBuilder.Entity<Booking>()
                .Property(e => e.BookingDate)
                .HasDefaultValueSql("CURRENT_TIMESTAMP");


        //    modelBuilder.Entity<Location>(entity =>
        //    {
        //        entity.HasKey(e => e.LocationId);
        //        entity.HasIndex(e => e.City).IsUnique();

        //        entity.HasMany(l => l.Hotels)
        //              .WithOne(h => h.Location)
        //              .HasForeignKey(h => h.LocationId)
        //              .OnDelete(DeleteBehavior.Restrict);
        //        // Seed data cho 63 tỉnh thành
        //        entity.HasData(
        //            new Location { LocationId = 1, City = "An Giang" },
        //            new Location { LocationId = 2, City = "Bà Rịa Vũng Tàu" },
        //            new Location { LocationId = 3, City = "Bạc Liêu" },
        //            new Location { LocationId = 4, City = "Bắc Giang" },
        //            new Location { LocationId = 5, City = "Bắc Kạn" },
        //            new Location { LocationId = 6, City = "Bắc Ninh" },
        //            new Location { LocationId = 7, City = "Bến Tre" },
        //            new Location { LocationId = 8, City = "Bình Dương" },
        //            new Location { LocationId = 9, City = "Bình Định" },
        //            new Location { LocationId = 10, City = "Bình Phước" },
        //            new Location { LocationId = 11, City = "Bình Thuận" },
        //            new Location { LocationId = 12, City = "Cà Mau" },
        //            new Location { LocationId = 13, City = "Cao Bằng" },
        //            new Location { LocationId = 14, City = "Cần Thơ" },
        //            new Location { LocationId = 15, City = "Đà Nẵng" },
        //            new Location { LocationId = 16, City = "Đắk Lắk" },
        //            new Location { LocationId = 17, City = "Đắk Nông" },
        //            new Location { LocationId = 18, City = "Điện Biên" },
        //            new Location { LocationId = 19, City = "Đồng Nai" },
        //            new Location { LocationId = 20, City = "Đồng Tháp" },
        //            new Location { LocationId = 21, City = "Gia Lai" },
        //            new Location { LocationId = 22, City = "Hà Giang" },
        //            new Location { LocationId = 23, City = "Hà Nam" },
        //            new Location { LocationId = 24, City = "Hà Nội" },
        //            new Location { LocationId = 25, City = "Hà Tĩnh" },
        //            new Location { LocationId = 26, City = "Hải Dương" },
        //            new Location { LocationId = 27, City = "Hải Phòng" },
        //            new Location { LocationId = 28, City = "Hậu Giang" },
        //            new Location { LocationId = 29, City = "Hòa Bình" },
        //            new Location { LocationId = 30, City = "Hưng Yên" },
        //            new Location { LocationId = 31, City = "Khánh Hòa" },
        //            new Location { LocationId = 32, City = "Kiên Giang" },
        //            new Location { LocationId = 33, City = "Kon Tum" },
        //            new Location { LocationId = 34, City = "Lai Châu" },
        //            new Location { LocationId = 35, City = "Lạng Sơn" },
        //            new Location { LocationId = 36, City = "Lào Cai" },
        //            new Location { LocationId = 37, City = "Lâm Đồng" },
        //            new Location { LocationId = 38, City = "Long An" },
        //            new Location { LocationId = 39, City = "Nam Định" },
        //            new Location { LocationId = 40, City = "Nghệ An" },
        //            new Location { LocationId = 41, City = "Ninh Bình" },
        //            new Location { LocationId = 42, City = "Ninh Thuận" },
        //            new Location { LocationId = 43, City = "Phú Thọ" },
        //            new Location { LocationId = 44, City = "Phú Yên" },
        //            new Location { LocationId = 45, City = "Quảng Bình" },
        //            new Location { LocationId = 46, City = "Quảng Nam" },
        //            new Location { LocationId = 47, City = "Quảng Ngãi" },
        //            new Location { LocationId = 48, City = "Quảng Ninh" },
        //            new Location { LocationId = 49, City = "Quảng Trị" },
        //            new Location { LocationId = 50, City = "Sóc Trăng" },
        //            new Location { LocationId = 51, City = "Sơn La" },
        //            new Location { LocationId = 52, City = "Tây Ninh" },
        //            new Location { LocationId = 53, City = "Thái Bình" },
        //            new Location { LocationId = 54, City = "Thái Nguyên" },
        //            new Location { LocationId = 55, City = "Thanh Hóa" },
        //            new Location { LocationId = 56, City = "TP Hồ Chí Minh" },
        //            new Location { LocationId = 57, City = "Thừa Thiên Huế" },
        //            new Location { LocationId = 58, City = "Tiền Giang" },
        //            new Location { LocationId = 59, City = "Trà Vinh" },
        //            new Location { LocationId = 60, City = "Tuyên Quang" },
        //            new Location { LocationId = 61, City = "Vĩnh Long" },
        //            new Location { LocationId = 62, City = "Vĩnh Phúc" },
        //            new Location { LocationId = 63, City = "Yên Bái" }
        //        );

        //    });
        //    // Hotel configurations
        //    modelBuilder.Entity<Hotel>(entity =>
        //    {
        //        entity.HasOne(h => h.Location)
        //          .WithMany(l => l.Hotels)
        //          .HasForeignKey(h => h.LocationId)
        //          .OnDelete(DeleteBehavior.Restrict);

        //        entity.HasKey(e => e.HotelId);
        //        entity.HasIndex(e => e.Code).IsUnique();

        //        entity.HasMany(h => h.Rooms)
        //              .WithOne(r => r.Hotel)
        //              .HasForeignKey(r => r.HotelId)
        //              .OnDelete(DeleteBehavior.Cascade);

        //        entity.HasMany(h => h.HotelImages)
        //              .WithOne(i => i.Hotel)
        //              .HasForeignKey(i => i.HotelId)
        //              .OnDelete(DeleteBehavior.Cascade);

        //        entity.HasMany(h => h.Reviews)
        //              .WithOne(r => r.Hotel)
        //              .HasForeignKey(r => r.HotelId)
        //              .OnDelete(DeleteBehavior.Cascade);
        //    });

        //    // Room configurations
        //    modelBuilder.Entity<Room>(entity =>
        //    {
        //        entity.HasKey(e => e.RoomId);
        //        entity.HasIndex(e => new { e.HotelId, e.RoomNumber }).IsUnique();

        //        entity.HasMany(r => r.RoomImages)
        //              .WithOne(i => i.Room)
        //              .HasForeignKey(i => i.RoomId)
        //              .OnDelete(DeleteBehavior.Cascade);

        //        entity.HasMany(r => r.RoomBookings)
        //              .WithOne(b => b.Room)
        //              .HasForeignKey(b => b.RoomId)
        //              .OnDelete(DeleteBehavior.Restrict);
        //    });

        //    // RoomBooking configurations
        //    modelBuilder.Entity<RoomBooking>(entity =>
        //    {
        //        entity.HasKey(e => e.BookingId);

        //        entity.HasOne(b => b.User)
        //              .WithMany()
        //              .HasForeignKey(b => b.UserId)
        //              .OnDelete(DeleteBehavior.Restrict);

        //        entity.HasMany(b => b.Payments)
        //              .WithOne(p => p.Booking)
        //              .HasForeignKey(p => p.BookingId)
        //              .OnDelete(DeleteBehavior.Cascade);
        //    });

        //    // HotelReview configurations
        //    modelBuilder.Entity<HotelReview>(entity =>
        //    {
        //        entity.HasKey(e => e.ReviewId);

        //        entity.HasOne(r => r.User)
        //              .WithMany()
        //              .HasForeignKey(r => r.UserId)
        //              .OnDelete(DeleteBehavior.Restrict);
        //    });

        //    // Add useful indexes
        //    modelBuilder.Entity<Hotel>()
        //        .HasIndex(e => e.IsActive);

        //    modelBuilder.Entity<Room>()
        //        .HasIndex(e => e.IsAvailable);

        //    modelBuilder.Entity<RoomBooking>()
        //        .HasIndex(e => e.Status);

        //    modelBuilder.Entity<RoomBooking>()
        //        .HasIndex(e => new { e.CheckInDate, e.CheckOutDate });
        }
    }
}
