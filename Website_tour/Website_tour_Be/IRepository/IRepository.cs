using System.Linq.Expressions;

namespace Website_tour_Be.IRepository
{
    public interface IRepository<T> where T : class
    {
        Task<IEnumerable<T>> GetAllAsync(
        Expression<Func<T, bool>>? filter = null,
        Expression<Func<T, object>>? orderBy = null,
        bool ascending = true,
        int? page = null,
        int? pageSize = null
        );
        Task<T> GetByIdAsync(int tourid);
        Task AddAsync(T entity);
        Task UpdateAsync(T entity);
        Task DeleteAsync(int tourid);
        Task<IEnumerable<T>> GetByConditionAsync(Expression<Func<T, bool>> predicate);

    }
}
