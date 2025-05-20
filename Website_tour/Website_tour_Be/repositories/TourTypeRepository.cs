using AutoMapper;
using Microsoft.EntityFrameworkCore;
using Website_tour_Be.Data;
using Website_tour_Be.IRepository;
using Website_tour_Be.Models;

namespace Website_tour_Be.repositories
{
    public class TourTypeRepository : ITourTypeRepository
    {
        private readonly ToursStoresContext _context;
        private readonly IMapper _mapper;

        public TourTypeRepository(ToursStoresContext context,
            IMapper mapper)
        {
            _context = context;
            _mapper = mapper;
        }

        public async Task<TourTypeModel> GetTourTypeAsync(int tourTypeId)
        {
            if (_context.TourTypes == null)
            {
                throw new InvalidOperationException("TourTypes không được khởi tạo");
            }

            // Lấy dữ liệu từ database
            var tourTypeEntity = await _context.TourTypes.FirstOrDefaultAsync(tt => tt.TourTypeId == tourTypeId);

            // Kiểm tra nếu không tìm thấy dữ liệu
            if (tourTypeEntity == null)
            {
                return null;
            }

            // Sử dụng AutoMapper để ánh xạ từ TourType sang TourTypeModel
            return _mapper.Map<TourTypeModel>(tourTypeEntity);
        }
        public async Task<string?> GetTourTypeNameAsync(int tourTypeId)
        {
            if (_context.TourTypes == null)
            {
                throw new InvalidOperationException("TourTypes không được khởi tạo");
            }

            var tourTypeEntity = await _context.TourTypes.FirstOrDefaultAsync(tt => tt.TourTypeId == tourTypeId);

            // Kiểm tra nếu không tìm thấy dữ liệu
            return tourTypeEntity?.Name; // Trả về tên TourType nếu tìm thấy, ngược lại trả về null
        }






    }
}