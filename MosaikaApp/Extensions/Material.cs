using System.Linq;

namespace MosaikaApp.Models;

public partial class Material
{
    public string SuppliersString => Suppliers != null && Suppliers.Any()
            ? string.Join(", ", Suppliers.Select(s => $"{s.Suppliertype?.Name} \"{s.Name}\""))
            : "Нет данных";
}