//using System.ComponentModel.DataAnnotations.Schema;
//using System.ComponentModel.DataAnnotations;
//using Website_tour_Be.Models;

//namespace Website_tour_Be.Data
//{
//    public class Hotel
//    {
//        [Key]
//        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
//        public int HotelId { get; set; }

//        [Required]
//        [MaxLength(50)]
//        public string Code { get; set; } = string.Empty;

//        [Required]
//        [MaxLength(255)]
//        public string Name { get; set; } = string.Empty;

//        [Required]
//        public string Address { get; set; } = string.Empty;

//        // Replace City property with LocationId foreign key
//        public int LocationId { get; set; }

//        [ForeignKey("LocationId")]
//        public virtual Location? Location { get; set; }

//        [Required]
//        [MaxLength(50)]
//        public string Country { get; set; } = string.Empty;

//        [MaxLength(20)]
//        public string? PhoneNumber { get; set; }

//        [MaxLength(255)]
//        public string? Email { get; set; }

//        [Required]
//        public int StarRating { get; set; }

//        public string? Description { get; set; }

//        public string? Amenities { get; set; }

//        [Required]
//        public bool IsActive { get; set; } = true;

//        // Collections
//        public virtual ICollection<HotelImage>? HotelImages { get; set; }
//        public virtual ICollection<Room>? Rooms { get; set; }
//        public virtual ICollection<HotelReview>? Reviews { get; set; }

//        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
//        public DateTime CreatedAt { get; set; } = DateTime.Now;
//        public DateTime? UpdatedAt { get; set; }
//        public string? CreatedBy { get; set; }
//        public string? UpdatedBy { get; set; }
//    }
//    public class Location
//    {
//        [Key]
//        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
//        public int LocationId { get; set; }

//        [Required]
//        [MaxLength(100)]
//        public string City { get; set; } = string.Empty;

//        // Collection navigation property
//        public virtual ICollection<Hotel>? Hotels { get; set; }
    
//    }
//    public class Room
//    {
//        [Key]
//        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
//        public int RoomId { get; set; }

//        public int HotelId { get; set; }

//        [ForeignKey("HotelId")]
//        public Hotel? Hotel { get; set; }

//        [Required]
//        [MaxLength(50)]
//        public string RoomNumber { get; set; } = string.Empty;

//        [Required]
//        [MaxLength(100)]
//        public string RoomType { get; set; } = string.Empty; // Single, Double, Suite, etc.

//        [Required]
//        public int MaxOccupancy { get; set; }

//        [Required]
//        [Column(TypeName = "decimal(18, 2)")]
//        public decimal BasePrice { get; set; }

//        public string? Description { get; set; }

//        public string? Amenities { get; set; } // Các tiện nghi trong phòng

//        [Required]
//        public bool IsAvailable { get; set; } = true;

//        public virtual ICollection<RoomImage>? RoomImages { get; set; }
//        public virtual ICollection<RoomBooking>? RoomBookings { get; set; }

//        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
//        public DateTime CreatedAt { get; set; } = DateTime.Now;
//        public DateTime? UpdatedAt { get; set; }
//    }

//    public class HotelImage
//    {
//        [Key]
//        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
//        public int ImageId { get; set; }

//        public int HotelId { get; set; }

//        [ForeignKey("HotelId")]
//        public Hotel? Hotel { get; set; }

//        [Required]
//        [MaxLength(255)]
//        public string ImageUrl { get; set; } = string.Empty;

//        [MaxLength(255)]
//        public string? Caption { get; set; }

//        public bool IsMainImage { get; set; } = false;

//        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
//        public DateTime CreatedAt { get; set; } = DateTime.Now;
//    }

//    public class RoomImage
//    {
//        [Key]
//        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
//        public int ImageId { get; set; }

//        public int RoomId { get; set; }

//        [ForeignKey("RoomId")]
//        public Room? Room { get; set; }

//        [Required]
//        [MaxLength(255)]
//        public string ImageUrl { get; set; } = string.Empty;

//        [MaxLength(255)]
//        public string? Caption { get; set; }

//        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
//        public DateTime CreatedAt { get; set; } = DateTime.Now;
//    }

//    public class RoomBooking
//    {
//        [Key]
//        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
//        public int BookingId { get; set; }

//        public int RoomId { get; set; }

//        [ForeignKey("RoomId")]
//        public Room? Room { get; set; }

//        public string? UserId { get; set; }

//        [ForeignKey("UserId")]
//        public User? User { get; set; }

//        [Required]
//        [DataType(DataType.Date)]
//        public DateTime CheckInDate { get; set; }

//        [Required]
//        [DataType(DataType.Date)]
//        public DateTime CheckOutDate { get; set; }

//        [Required]
//        public int NumberOfGuests { get; set; }

//        [Required]
//        [Column(TypeName = "decimal(18, 2)")]
//        public decimal TotalPrice { get; set; }

//        [Required]
//        [MaxLength(50)]
//        public string Status { get; set; } = "Pending"; // Pending, Confirmed, Cancelled, Completed

//        public virtual ICollection<RoomBookingPayment>? Payments { get; set; }

//        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
//        public DateTime BookingDate { get; set; } = DateTime.Now;
//        public DateTime? UpdatedAt { get; set; }
//    }

//    public class RoomBookingPayment
//    {
//        [Key]
//        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
//        public int PaymentId { get; set; }

//        public int BookingId { get; set; }

//        [ForeignKey("BookingId")]
//        public RoomBooking? Booking { get; set; }

//        [Required]
//        [Column(TypeName = "decimal(18, 2)")]
//        public decimal Amount { get; set; }

//        [Required]
//        [MaxLength(50)]
//        public string PaymentMethod { get; set; } = string.Empty;

//        [Required]
//        [MaxLength(50)]
//        public string Status { get; set; } = "Pending"; // Pending, Completed, Failed

//        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
//        public DateTime PaymentDate { get; set; } = DateTime.Now;
//    }

//    public class HotelReview
//    {
//        [Key]
//        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
//        public int ReviewId { get; set; }

//        public int HotelId { get; set; }

//        [ForeignKey("HotelId")]
//        public Hotel? Hotel { get; set; }

//        public string? UserId { get; set; }

//        [ForeignKey("UserId")]
//        public User? User { get; set; }

//        [Required]
//        [Range(1, 5)]
//        public int Rating { get; set; }

//        [Required]
//        public string Comment { get; set; } = string.Empty;

//        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
//        public DateTime CreatedAt { get; set; } = DateTime.Now;
//        public DateTime? UpdatedAt { get; set; }
//    }
//}
