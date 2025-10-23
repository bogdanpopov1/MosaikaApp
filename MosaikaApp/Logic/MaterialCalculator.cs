using MosaikaApp.Models;
using System;
using System.Linq;

namespace MosaikaApp.Logic;

public static class MaterialCalculator
{
    public static int CalculateMaterialNeeded(int productTypeId, int materialTypeId, int productCount, double param1, double param2, double materialInStock)
    {
        if (productCount <= 0 || param1 <= 0 || param2 <= 0 || materialInStock < 0)
        {
            return -1;
        }

        var db = DbHelper.GetContext();

        var productType = db.Producttypes.FirstOrDefault(pt => pt.Id == productTypeId);
        if (productType == null)
        {
            return -1;
        }

        var materialType = db.Materialtypes.FirstOrDefault(mt => mt.Id == materialTypeId);
        if (materialType == null)
        {
            return -1;
        }

        double requiredPerUnit = param1 * param2 * (double)productType.Coefficient;

        double totalRequired = requiredPerUnit * productCount;

        double totalWithDefect = totalRequired * (1 + ((double)materialType.Losspercentage / 100.0));

        double neededToOrder = totalWithDefect - materialInStock;

        if (neededToOrder <= 0)
        {
            return 0;
        }

        return (int)Math.Ceiling(neededToOrder);
    }
}