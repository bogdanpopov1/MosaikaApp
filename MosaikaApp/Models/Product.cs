using System;
using System.Collections.Generic;

namespace MosaikaApp.Models;

public partial class Product
{
    public int Id { get; set; }

    public string Article { get; set; } = null!;

    public string Name { get; set; } = null!;

    public int? Producttypeid { get; set; }

    public decimal Mincostforpartner { get; set; }

    public decimal? Rollwidth { get; set; }

    public virtual ICollection<Productmaterial> Productmaterials { get; set; } = new List<Productmaterial>();

    public virtual Producttype? Producttype { get; set; }
}
