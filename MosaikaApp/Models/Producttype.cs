﻿using System;
using System.Collections.Generic;

namespace MosaikaApp.Models;

public partial class Producttype
{
    public int Id { get; set; }

    public string Name { get; set; } = null!;

    public decimal Coefficient { get; set; }

    public virtual ICollection<Product> Products { get; set; } = new List<Product>();
}
