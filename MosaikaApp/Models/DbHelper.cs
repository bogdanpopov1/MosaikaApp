using Microsoft.EntityFrameworkCore;

namespace MosaikaApp.Models;

public static class DbHelper
{
    private static MosaikaDbContext _context;

    public static MosaikaDbContext GetContext()
    {
        if (_context == null)
        {
            var optionsBuilder = new DbContextOptionsBuilder<MosaikaDbContext>();
            optionsBuilder.UseNpgsql("Host=localhost;Database=mosaika_db;Username=postgres;Password=root");
            _context = new MosaikaDbContext(optionsBuilder.Options);
        }
        return _context;
    }
}