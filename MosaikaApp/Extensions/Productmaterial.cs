namespace MosaikaApp.Models;

public partial class Productmaterial
{
    public decimal LineTotal => (decimal)(Quantity * Material?.Unitprice);
}