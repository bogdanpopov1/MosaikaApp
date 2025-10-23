using Avalonia.Controls;
using Avalonia.Interactivity;
using Microsoft.EntityFrameworkCore;
using MosaikaApp.Logic;
using MosaikaApp.Models;
using ReactiveUI;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Linq;
using System.Reactive.Linq;

namespace MosaikaApp.Views
{
    public partial class SelectMaterialsView : UserControl
    {
        private readonly MainWindow _parentWindow;
        private readonly Action<List<Productmaterial>, decimal> _onSaveCallback;
        public ObservableCollection<MaterialSelectionItem> AllMaterials { get; } = new ObservableCollection<MaterialSelectionItem>();
        private readonly Product _product;

        public SelectMaterialsView()
        {
            InitializeComponent();
        }

        public SelectMaterialsView(MainWindow parent, Product product, List<Productmaterial> currentMaterials, Action<List<Productmaterial>, decimal> onSaveCallback)
        {
            InitializeComponent();
            _parentWindow = parent;
            _product = product;
            _onSaveCallback = onSaveCallback;
            this.DataContext = this;

            ProductNameTextBlock.Text = _product.Name;
            LoadAllMaterials(currentMaterials);
            UpdateTotalCost();
        }

        private void LoadAllMaterials(List<Productmaterial> currentMaterials)
        {
            var db = DbHelper.GetContext();
            var allDbMaterials = db.Materials.Include(m => m.Unit).ToList();

            foreach (var mat in allDbMaterials)
            {
                var current = currentMaterials.FirstOrDefault(cm => cm.Materialid == mat.Id);
                var item = new MaterialSelectionItem(mat, current?.Quantity ?? 0);

                item.WhenAnyValue(x => x.Quantity)
                    .Skip(1)
                    .Subscribe(_ => UpdateTotalCost());

                AllMaterials.Add(item);
            }
        }

        private void UpdateTotalCost()
        {
            decimal totalCost = AllMaterials.Sum(item => (item.Quantity ?? 0) * item.Material.Unitprice);
            TotalCostTextBlock.Text = $"Итоговая стоимость: {totalCost:F2} p";
        }

        private void SaveButton_Click(object sender, RoutedEventArgs e)
        {
            var selectedMaterials = new List<Productmaterial>();

            decimal totalCost = AllMaterials.Sum(item => (item.Quantity ?? 0) * item.Material.Unitprice);

            foreach (var item in AllMaterials.Where(i => i.Quantity.HasValue && i.Quantity > 0))
            {
                selectedMaterials.Add(new Productmaterial
                {
                    Productid = _product.Id,
                    Materialid = item.Material.Id,
                    Quantity = (int)item.Quantity.Value
                });
            }

            _onSaveCallback(selectedMaterials, totalCost);
            _parentWindow.GoBack();
        }
    }
}