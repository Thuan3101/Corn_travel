using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;
using System.Security.Cryptography;

public class TourDepartureModel
{
    
    public int DepartureId { get; set; }

    public int TourId { get; set; }

    
    public string Code { get; set; } = string.Empty;

    [Required]
    public DateTime DepartureDate { get; set; }

    [Required]
    public DateTime ReturnDate { get; set; }

    [Required]
    [Column(TypeName = "decimal(18, 2)")]
    public decimal Price { get; set; }

    [Required]
    [Column(TypeName = "decimal(18, 2)")]
    public decimal ChildPrice { get; set; }

    [Required]
    public int AvailableSeats { get; set; }

    public string Status { get; set; } = "Available";

    public DateTime CreatedAt { get; set; } = DateTime.Now;

    public DateTime? UpdatedAt { get; set; }

}
