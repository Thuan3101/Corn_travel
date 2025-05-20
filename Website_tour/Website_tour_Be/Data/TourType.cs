using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;

namespace Website_tour_Be.Data
{
    [Table("TourTypes")]
    public class TourType
    {
        public TourType()
        {
            Tours = new HashSet<Tour>();
        }

        [Key]
        public int TourTypeId { get; set; }

        
        [StringLength(50)]
        public string? Name { get; set; }

        // Navigation property for Tours
        public virtual ICollection<Tour> Tours { get; set; }
    }
}