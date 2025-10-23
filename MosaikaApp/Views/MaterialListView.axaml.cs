using Avalonia.Controls;
using Microsoft.EntityFrameworkCore;
using MosaikaApp.Models;
using System.Collections.ObjectModel;
using System.Linq;

namespace MosaikaApp.Views
{
    public partial class MaterialListView : UserControl
    {
        private readonly MainWindow _parentWindow;
        public ObservableCollection<Material> Materials { get; } = new ObservableCollection<Material>();

        public MaterialListView()
        {
            InitializeComponent();
        }

        public MaterialListView(MainWindow parent)
        {
            InitializeComponent();
            _parentWindow = parent;
            this.DataContext = this;
            LoadMaterials();
        }

        private void LoadMaterials()
        {
            var db = DbHelper.GetContext();
            var materialsFromDb = db.Materials
                .Include(m => m.Materialtype)
                .Include(m => m.Unit)
                .Include(m => m.Suppliers)
                    .ThenInclude(s => s.Suppliertype)
                .OrderBy(m => m.Name)
                .ToList();

            Materials.Clear();
            foreach (var material in materialsFromDb)
            {
                Materials.Add(material);
            }
        }
    }
}