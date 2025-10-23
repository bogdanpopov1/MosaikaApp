using Avalonia.Controls;
using Avalonia.Interactivity;
using Microsoft.EntityFrameworkCore;
using MosaikaApp.Models;
using MsBox.Avalonia;
using MsBox.Avalonia.Enums;
using System;
using System.Collections.ObjectModel;
using System.Linq;


namespace MosaikaApp.Views
{
    public partial class ProductListView : UserControl
    {
        private readonly MainWindow _parentWindow;
        public ObservableCollection<Product> Products { get; } = new ObservableCollection<Product>();
        private ListBox _productsListBox;

        public ProductListView()
        {
            InitializeComponent();
        }

        public ProductListView(MainWindow parent)
        {
            InitializeComponent();
            _parentWindow = parent;
            _productsListBox = this.FindControl<ListBox>("ProductsListBox")!;
            this.DataContext = this;

            LoadProducts();
        }

        public void LoadProducts()
        {
            var db = DbHelper.GetContext();
            var productsFromDb = db.Products
                .Include(p => p.Producttype)
                .Include(p => p.Productmaterials)
                .ThenInclude(pm => pm.Material)
                .ToList();

            Products.Clear();
            foreach (var product in productsFromDb)
            {
                Products.Add(product);
            }
        }

        private void AddButton_Click(object sender, RoutedEventArgs e)
        {
            _parentWindow.NavigateTo(new AddEditProductView(_parentWindow));
        }

        private async void EditButton_Click(object sender, RoutedEventArgs e)
        {
            var selectedProduct = _productsListBox.SelectedItem as Product;
            if (selectedProduct == null)
            {
                await MessageBoxManager.GetMessageBoxStandard("Внимание", "Выберите продукт редактирования.", ButtonEnum.Ok, Icon.Warning).ShowAsync();
                return;
            }

            _parentWindow.NavigateTo(new AddEditProductView(_parentWindow, selectedProduct));
        }

        private async void ViewMaterialsButton_Click(object sender, RoutedEventArgs e)
        {
            var selectedProduct = _productsListBox.SelectedItem as Product;
            if (selectedProduct == null)
            {
                await MessageBoxManager.GetMessageBoxStandard("Внимание", "Выберите продукт для просмотра состава.", ButtonEnum.Ok, Icon.Warning).ShowAsync();
                return;
            }

            _parentWindow.NavigateTo(new ProductMaterialsView(_parentWindow, selectedProduct));
        }

        private async void DeleteButton_Click(object sender, RoutedEventArgs e)
        {
            var selectedProduct = _productsListBox.SelectedItem as Product;
            if (selectedProduct == null)
            {
                await MessageBoxManager.GetMessageBoxStandard("Внимание", "Выберите продукт для удаления.", ButtonEnum.Ok, Icon.Warning).ShowAsync();
                return;
            }

            var confirmation = await MessageBoxManager.GetMessageBoxStandard(
                "Подтверждение удаления",
                $"Вы уверены, что хотите удалить продукт {selectedProduct.Name}?\nЭто действие необратимо.",
                ButtonEnum.YesNo,
                Icon.Warning).ShowAsync();

            if (confirmation == ButtonResult.Yes)
            {
                try
                {
                    var db = DbHelper.GetContext();

                    db.Products.Remove(selectedProduct);

                    await db.SaveChangesAsync();

                    await MessageBoxManager.GetMessageBoxStandard("Успешно", "Продукт успешно удален.", ButtonEnum.Ok, Icon.Success).ShowAsync();

                    LoadProducts();
                }
                catch (Exception ex)
                {
                    await MessageBoxManager.GetMessageBoxStandard("Ошибка", $"Произошла ошибка при удалении: {ex.Message}", ButtonEnum.Ok, Icon.Error).ShowAsync();
                }
            }
        }

        private void ViewAllMaterialsButton_Click(object sender, RoutedEventArgs e)
        {
            _parentWindow.NavigateTo(new MaterialListView(_parentWindow));
        }
    }
}