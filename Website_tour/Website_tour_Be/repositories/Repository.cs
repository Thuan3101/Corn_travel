using Microsoft.EntityFrameworkCore;
using System.Linq.Expressions;
using Website_tour_Be.Data;
using Website_tour_Be.IRepository;

namespace Website_tour_Be.Repositories
{
    public class Repository<T> : IRepository<T> where T : class
    {
        private readonly ToursStoresContext _context;
        private readonly DbSet<T> _dbSet;
        
        public Repository(ToursStoresContext context)
        {
            _context = context;
            _dbSet = context.Set<T>();
        }

        public async Task<IEnumerable<T>> GetAllAsync(
        Expression<Func<T, bool>>? filter = null,
        Expression<Func<T, object>>? orderBy = null,
        bool ascending = true,
        int? page = null,
        int? pageSize = null
)
        {
            IQueryable<T> query = _dbSet;

            // Lọc dữ liệu theo filter
            if (filter != null)
            {
                query = query.Where(filter);  // Sử dụng Where cho biểu thức filter
            }

            // Sắp xếp dữ liệu theo orderBy
            if (orderBy != null)
            {
                query = ascending
                    ? query.OrderBy(orderBy)
                    : query.OrderByDescending(orderBy);
            }

            // Phân trang
            if (page.HasValue && pageSize.HasValue)
            {
                int skip = (page.Value - 1) * pageSize.Value;
                query = query.Skip(skip).Take(pageSize.Value);
            }

            // Trả về danh sách kết quả dưới dạng một danh sách async
            return await query.ToListAsync();
        }



        public async Task<T> GetByIdAsync(int tourid)
        {
            // Giữ lại FindAsync nếu tourid là khóa chính
            return await _dbSet.FirstOrDefaultAsync(e => EF.Property<int>(e, "TourId") == tourid);

            // Nếu cần tìm theo thuộc tính `TourId` trong trường hợp `tourid` không phải là khóa chính,
            // bạn có thể thay thế bằng đoạn sau:
            // return await _dbSet.FirstOrDefaultAsync(e => EF.Property<int>(e, "TourId") == tourid);
        }

        public async Task AddAsync(T entity)
        {
            await _dbSet.AddAsync(entity);
            await _context.SaveChangesAsync();
        }

        public async Task UpdateAsync(T entity)
        {
            _dbSet.Update(entity);
            await _context.SaveChangesAsync();
        }

        public async Task DeleteAsync(int tourid)
        {
            var entity = await GetByIdAsync(tourid);
            if (entity != null)
            {
                _dbSet.Remove(entity);
                await _context.SaveChangesAsync();
            }
        }
        public async Task<IEnumerable<T>> GetByConditionAsync(Expression<Func<T, bool>> predicate)
        {
            return await _dbSet.Where(predicate).ToListAsync();
        }

    }
}
