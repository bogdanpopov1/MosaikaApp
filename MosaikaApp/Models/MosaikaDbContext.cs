using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;

namespace MosaikaApp.Models;

public partial class MosaikaDbContext : DbContext
{
    public MosaikaDbContext(DbContextOptions<MosaikaDbContext> options)
        : base(options)
    {
    }

    public virtual DbSet<Material> Materials { get; set; }

    public virtual DbSet<Materialtype> Materialtypes { get; set; }

    public virtual DbSet<Product> Products { get; set; }

    public virtual DbSet<Productmaterial> Productmaterials { get; set; }

    public virtual DbSet<Producttype> Producttypes { get; set; }

    public virtual DbSet<Supplier> Suppliers { get; set; }

    public virtual DbSet<Suppliertype> Suppliertypes { get; set; }

    public virtual DbSet<Unit> Units { get; set; }

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<Material>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("material_pkey");

            entity.ToTable("material");

            entity.HasIndex(e => e.Name, "material_name_key").IsUnique();

            entity.Property(e => e.Id).HasColumnName("id");
            entity.Property(e => e.Materialtypeid).HasColumnName("materialtypeid");
            entity.Property(e => e.Minquantity).HasColumnName("minquantity");
            entity.Property(e => e.Name)
                .HasMaxLength(255)
                .HasColumnName("name");
            entity.Property(e => e.Quantityinpackage).HasColumnName("quantityinpackage");
            entity.Property(e => e.Quantityinstock).HasColumnName("quantityinstock");
            entity.Property(e => e.Unitid).HasColumnName("unitid");
            entity.Property(e => e.Unitprice)
                .HasPrecision(10, 2)
                .HasColumnName("unitprice");

            entity.HasOne(d => d.Materialtype).WithMany(p => p.Materials)
                .HasForeignKey(d => d.Materialtypeid)
                .OnDelete(DeleteBehavior.SetNull)
                .HasConstraintName("material_materialtypeid_fkey");

            entity.HasOne(d => d.Unit).WithMany(p => p.Materials)
                .HasForeignKey(d => d.Unitid)
                .OnDelete(DeleteBehavior.Restrict)
                .HasConstraintName("material_unitid_fkey");

            entity.HasMany(d => d.Suppliers).WithMany(p => p.Materials)
                .UsingEntity<Dictionary<string, object>>(
                    "Materialsupplier",
                    r => r.HasOne<Supplier>().WithMany()
                        .HasForeignKey("Supplierid")
                        .HasConstraintName("materialsupplier_supplierid_fkey"),
                    l => l.HasOne<Material>().WithMany()
                        .HasForeignKey("Materialid")
                        .HasConstraintName("materialsupplier_materialid_fkey"),
                    j =>
                    {
                        j.HasKey("Materialid", "Supplierid").HasName("materialsupplier_pkey");
                        j.ToTable("materialsupplier");
                        j.IndexerProperty<int>("Materialid").HasColumnName("materialid");
                        j.IndexerProperty<int>("Supplierid").HasColumnName("supplierid");
                    });
        });

        modelBuilder.Entity<Materialtype>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("materialtype_pkey");

            entity.ToTable("materialtype");

            entity.HasIndex(e => e.Name, "materialtype_name_key").IsUnique();

            entity.Property(e => e.Id).HasColumnName("id");
            entity.Property(e => e.Losspercentage)
                .HasPrecision(5, 2)
                .HasColumnName("losspercentage");
            entity.Property(e => e.Name)
                .HasMaxLength(100)
                .HasColumnName("name");
        });

        modelBuilder.Entity<Product>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("product_pkey");

            entity.ToTable("product");

            entity.HasIndex(e => e.Article, "product_article_key").IsUnique();

            entity.Property(e => e.Id).HasColumnName("id");
            entity.Property(e => e.Article)
                .HasMaxLength(50)
                .HasColumnName("article");
            entity.Property(e => e.Mincostforpartner)
                .HasPrecision(10, 2)
                .HasColumnName("mincostforpartner");
            entity.Property(e => e.Name)
                .HasMaxLength(255)
                .HasColumnName("name");
            entity.Property(e => e.Producttypeid).HasColumnName("producttypeid");
            entity.Property(e => e.Rollwidth)
                .HasPrecision(10, 2)
                .HasColumnName("rollwidth");

            entity.HasOne(d => d.Producttype).WithMany(p => p.Products)
                .HasForeignKey(d => d.Producttypeid)
                .OnDelete(DeleteBehavior.SetNull)
                .HasConstraintName("product_producttypeid_fkey");
        });

        modelBuilder.Entity<Productmaterial>(entity =>
        {
            entity.HasKey(e => new { e.Productid, e.Materialid }).HasName("productmaterial_pkey");

            entity.ToTable("productmaterial");

            entity.Property(e => e.Productid).HasColumnName("productid");
            entity.Property(e => e.Materialid).HasColumnName("materialid");
            entity.Property(e => e.Quantity).HasColumnName("quantity");

            entity.HasOne(d => d.Material).WithMany(p => p.Productmaterials)
                .HasForeignKey(d => d.Materialid)
                .HasConstraintName("productmaterial_materialid_fkey");

            entity.HasOne(d => d.Product).WithMany(p => p.Productmaterials)
                .HasForeignKey(d => d.Productid)
                .HasConstraintName("productmaterial_productid_fkey");
        });

        modelBuilder.Entity<Producttype>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("producttype_pkey");

            entity.ToTable("producttype");

            entity.HasIndex(e => e.Name, "producttype_name_key").IsUnique();

            entity.Property(e => e.Id).HasColumnName("id");
            entity.Property(e => e.Coefficient)
                .HasPrecision(10, 2)
                .HasColumnName("coefficient");
            entity.Property(e => e.Name)
                .HasMaxLength(100)
                .HasColumnName("name");
        });

        modelBuilder.Entity<Supplier>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("supplier_pkey");

            entity.ToTable("supplier");

            entity.HasIndex(e => e.Inn, "supplier_inn_key").IsUnique();

            entity.HasIndex(e => e.Name, "supplier_name_key").IsUnique();

            entity.Property(e => e.Id).HasColumnName("id");
            entity.Property(e => e.Inn)
                .HasMaxLength(12)
                .HasColumnName("inn");
            entity.Property(e => e.Name)
                .HasMaxLength(255)
                .HasColumnName("name");
            entity.Property(e => e.Rating).HasColumnName("rating");
            entity.Property(e => e.Startdate).HasColumnName("startdate");
            entity.Property(e => e.Suppliertypeid).HasColumnName("suppliertypeid");

            entity.HasOne(d => d.Suppliertype).WithMany(p => p.Suppliers)
                .HasForeignKey(d => d.Suppliertypeid)
                .OnDelete(DeleteBehavior.SetNull)
                .HasConstraintName("supplier_suppliertypeid_fkey");
        });

        modelBuilder.Entity<Suppliertype>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("suppliertype_pkey");

            entity.ToTable("suppliertype");

            entity.HasIndex(e => e.Name, "suppliertype_name_key").IsUnique();

            entity.Property(e => e.Id).HasColumnName("id");
            entity.Property(e => e.Name)
                .HasMaxLength(10)
                .HasColumnName("name");
        });

        modelBuilder.Entity<Unit>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("unit_pkey");

            entity.ToTable("unit");

            entity.HasIndex(e => e.Name, "unit_name_key").IsUnique();

            entity.Property(e => e.Id).HasColumnName("id");
            entity.Property(e => e.Name)
                .HasMaxLength(10)
                .HasColumnName("name");
        });

        OnModelCreatingPartial(modelBuilder);
    }

    partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
}
