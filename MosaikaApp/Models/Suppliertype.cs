using System;
using System.Collections.Generic;

namespace MosaikaApp.Models;

public partial class Suppliertype
{
    public int Id { get; set; }

    public string Name { get; set; } = null!;

    public virtual ICollection<Supplier> Suppliers { get; set; } = new List<Supplier>();
}
