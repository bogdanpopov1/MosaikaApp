using Avalonia.Controls;
using Avalonia.Interactivity;
using MosaikaApp.Models;
using MsBox.Avalonia;
using MsBox.Avalonia.Enums;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Linq;

namespace MosaikaApp.Views
{
    public partial class AddEditProductView : UserControl
    {
        private readonly MainWindow _parentWindow;
        private Product _productToEdit;
        private List<Productmaterial> _selectedMaterials = new List<Productmaterial>();

        public ObservableCollection<Producttype> ProductTypes { get; } = new ObservableCollection<Producttype>();

        public AddEditProductView()
        {
            InitializeComponent();
        }

        public AddEditProductView(MainWindow parent, Product product = null)
        {
            InitializeComponent();
            _parentWindow = parent;
            _productToEdit = product ?? new Product();
            this.DataContext = this;

            LoadProductTypes();

            if (_productToEdit.Id != 0)
            {
                HeaderTextBlock.Text = "Редактирование продукта:";
                var db = DbHelper.GetContext();
                _selectedMaterials = db.Productmaterials
                                       .Where(pm => pm.Productid == _productToEdit.Id)
                                       .ToList();
            }

            ArticleTextBox.Text = _productToEdit.Article;
            NameTextBox.Text = _productToEdit.Name;
            MinCostTextBox.Text = _productToEdit.Mincostforpartner.ToString("F2");
            RollWidthTextBox.Text = _productToEdit.Rollwidth.HasValue
                ? _productToEdit.Rollwidth.Value.ToString("F2")
                : string.Empty;
            ProductTypeComboBox.SelectedItem = ProductTypeComboBox.Items.Cast<Producttype>().FirstOrDefault(pt => pt.Id == _productToEdit.Producttypeid);
            ProductNameTextBlock.Text = _productToEdit.Name;
            UpdateCostDisplay();
        }

        private void LoadProductTypes()
        {
            var db = DbHelper.GetContext();
            ProductTypes.Clear();
            foreach (var type in db.Producttypes.ToList())
            {
                ProductTypes.Add(type);
            }
        }

        private async void SaveButton_Click(object sender, Avalonia.Interactivity.RoutedEventArgs e)
        {
            if (string.IsNullOrWhiteSpace(ArticleTextBox.Text) ||
                string.IsNullOrWhiteSpace(NameTextBox.Text) ||
                ProductTypeComboBox.SelectedItem == null ||
                !decimal.TryParse(MinCostTextBox.Text, out var minCost) || minCost < 0 ||
                !decimal.TryParse(RollWidthTextBox.Text, out var rollWidth) || rollWidth < 0)
            {
                await MessageBoxManager.GetMessageBoxStandard("Ошибка", "Все поля обязательны для заполнения. Стоимость и ширина должны быть положительными числами.", ButtonEnum.Ok, Icon.Error).ShowAsync();
                return;
            }

            var db = DbHelper.GetContext();

            _productToEdit.Article = ArticleTextBox.Text;
            _productToEdit.Name = NameTextBox.Text;
            _productToEdit.Producttypeid = ((Producttype)ProductTypeComboBox.SelectedItem).Id;
            _productToEdit.Mincostforpartner = minCost;
            _productToEdit.Rollwidth = rollWidth;

            if (_productToEdit.Id == 0)
            {
                db.Products.Add(_productToEdit);
            }
            else
            {
                db.Products.Update(_productToEdit);

                var oldMaterials = db.Productmaterials.Where(pm => pm.Productid == _productToEdit.Id);
                db.Productmaterials.RemoveRange(oldMaterials);
            }
            db.SaveChanges();

            foreach (var material in _selectedMaterials)
            {
                material.Productid = _productToEdit.Id;
            }
            db.Productmaterials.AddRange(_selectedMaterials);
            db.SaveChanges();

            await MessageBoxManager.GetMessageBoxStandard(
                "Успешно",
                "Данные о продукте успешно сохранены!",
                ButtonEnum.Ok,
                Icon.Success).ShowAsync();

            _parentWindow.GoBack();

        }

        private void SelectMaterials_Click(object sender, RoutedEventArgs e)
        {
            _parentWindow.NavigateTo(new SelectMaterialsView(_parentWindow, _productToEdit, _selectedMaterials, UpdateMaterials));
        }

        private void UpdateMaterials(List<Productmaterial> materials, decimal totalCost)
        {
            _selectedMaterials = materials;
            UpdateCostDisplay();
        }

        private void UpdateCostDisplay()
        {
            decimal totalCost = 0;
            if (_selectedMaterials.Any())
            {
                var db = DbHelper.GetContext();
                var materialIds = _selectedMaterials.Select(m => m.Materialid).ToList();
                var materials = db.Materials.Where(m => materialIds.Contains(m.Id)).ToList();

                totalCost = _selectedMaterials.Sum(sm =>
                   materials.First(m => m.Id == sm.Materialid).Unitprice * sm.Quantity);
            }
            CalculatedCostTextBlock.Text = $"{totalCost:F2} pуб";
        }

    }
}
