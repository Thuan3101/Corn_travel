using Website_tour_Be.Models;


namespace Website_tour_Be.IRepository
{
    public interface ITourTypeRepository
    {
        Task<TourTypeModel> GetTourTypeAsync(int tourTypeId);
        Task<string?> GetTourTypeNameAsync(int tourTypeId);
    }
}
