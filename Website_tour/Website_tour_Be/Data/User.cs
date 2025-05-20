using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;
using Microsoft.AspNetCore.Identity;

namespace Website_tour_Be.Models
{
    public class User : IdentityUser
    {

        public string? FirstName { get; set; } = null;
        public string? LastName { get; set; } = null;

        [Phone]
        public string? PhoneNumber { get; set; }
        //Them dia chi

        [Required]
        [StringLength(400)]
        public string? Address { get; set; } = null;
        // chinh theo ngay thang nam
        [Required]
        [DataType(DataType.Date)]
        [DisplayFormat(ApplyFormatInEditMode = true, DataFormatString = "{0:dd-MM-yyyy}")]
        public DateTime BirthDate { get; set; }

        // Thêm Giới tính
        public string Gender { get; set; } = string.Empty;
        //Tu dong sinh ra ngay tao
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public DateTime CreatedAt { get; set; } = DateTime.Now;
    }
}
