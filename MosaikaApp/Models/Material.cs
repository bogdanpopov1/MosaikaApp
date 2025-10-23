using System;
using System.Collections.Generic;

namespace MosaikaApp.Models;

public partial class Material
{
    public int Id { get; set; }

    public string Name { get; set; } = null!;

    public int? Materialtypeid { get; set; }

    public int? Unitid { get; set; }

    public int Quantityinstock { get; set; }

    public int Minquantity { get; set; }

    public int Quantityinpackage { get; set; }

    public decimal Unitprice { get; set; }

    public virtual Materialtype? Materialtype { get; set; }

    public virtual ICollection<Productmaterial> Productmaterials { get; set; } = new List<Productmaterial>();

    public virtual Unit? Unit { get; set; }

    public virtual ICollection<Supplier> Suppliers { get; set; } = new List<Supplier>();
}
