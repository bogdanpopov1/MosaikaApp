using System;
using System.Collections.Generic;

namespace MosaikaApp.Models;

public partial class Supplier
{
    public int Id { get; set; }

    public string Name { get; set; } = null!;

    public int? Suppliertypeid { get; set; }

    public string Inn { get; set; } = null!;

    public int Rating { get; set; }

    public DateOnly Startdate { get; set; }

    public virtual Suppliertype? Suppliertype { get; set; }

    public virtual ICollection<Material> Materials { get; set; } = new List<Material>();
}
