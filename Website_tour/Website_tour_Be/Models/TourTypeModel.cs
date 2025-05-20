using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;



namespace Website_tour_Be.Models
{
    
    public class TourTypeModel
    {
        public TourTypeModel()
        {
            Tours = new HashSet<TourModel>();
        }

        
        public int TourTypeId { get; set; }

        
        
        public string? Name { get; set; }

        public virtual ICollection<TourModel> Tours { get; set; }
    }

}
