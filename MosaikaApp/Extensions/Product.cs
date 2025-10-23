using System.Linq;

namespace MosaikaApp.Models;

public partial class Product
{
    public decimal CalculatedCost
    {
        get
        {
            if (Productmaterials == null || !Productmaterials.Any())
            {
                return 0;
            }

            return Productmaterials.Sum(pm => pm.Quantity * pm.Material.Unitprice);
        }
    }
}