using Avalonia.Controls;
using Avalonia.Interactivity;
using Avalonia.VisualTree;
using Microsoft.EntityFrameworkCore;
using MosaikaApp.Models;
using MsBox.Avalonia;
using MsBox.Avalonia.Enums;
using System.Collections.ObjectModel;
using System.IO;
using System.Linq;
using System.Text;

namespace MosaikaApp.Views
{
    public partial class ProductMaterialsView : UserControl
    {
        private readonly MainWindow _parentWindow;
        private readonly Product _product;
        public ObservableCollection<Productmaterial> Materials { get; } = new ObservableCollection<Productmaterial>();

        public ProductMaterialsView(MainWindow parent, Product product)
        {
            InitializeComponent();
            _parentWindow = parent;
            _product = product;
            this.DataContext = this;

            ProductNameTextBlock.Text = _product.Name;
            LoadMaterials();
        }

        private void LoadMaterials()
        {
            var db = DbHelper.GetContext();

            var materialsFromDb = db.Productmaterials
                .Include(pm => pm.Material)
                .ThenInclude(m => m.Unit)
                .Where(pm => pm.Productid == _product.Id)
                .ToList();

            Materials.Clear();
            foreach (var material in materialsFromDb)
            {
                Materials.Add(material);
            }

            UpdateTotalCost();
        }

        private void UpdateTotalCost()
        {
            var total = Materials.Sum(m => m.LineTotal);
            TotalCostTextBlock.Text = $"Итоговая стоимость: {total:F2} p";
        }

        private async void SaveReportButton_Click(object sender, RoutedEventArgs e)
        {
            var saveFileDialog = new SaveFileDialog
            {
                Title = "Сохранить отчет",
                DefaultExtension = "txt",
                InitialFileName = $"Отчет_{_product.Article}_{System.DateTime.Now:yyyyMMdd}.txt",
                Filters = { new FileDialogFilter{ Name = "Текстовые файлы", Extensions = { "txt" } } }
            };

            var filePath = await saveFileDialog.ShowAsync((Window)this.GetVisualRoot());

            if (!string.IsNullOrEmpty(filePath))
            {
                var sb = new StringBuilder();
                sb.AppendLine($"Отчет по составу продукта: {_product.Name}");
                sb.AppendLine($"Артикул: {_product.Article}");
                sb.AppendLine("======================================================================");
                sb.AppendLine($"{"Материал",-30} | {"Кол-во",-10} | {"Ед.изм.",-7} | {"Стоимость",-10}");
                sb.AppendLine("----------------------------------------------------------------------");

                foreach (var item in Materials)
                {
                    sb.AppendLine($"{item.Material.Name,-30} | {item.Quantity,-10} | {item.Material.Unit.Name,-7} | {item.LineTotal,-10:F2} p");
                }

                sb.AppendLine("======================================================================");
                sb.AppendLine($"ИТОГОВАЯ СТОИМОСТЬ: {Materials.Sum(m => m.LineTotal):F2} p");

                try
                {
                    await File.WriteAllTextAsync(filePath, sb.ToString());
                    await MessageBoxManager.GetMessageBoxStandard("Успешно", "Отчет успешно сохранен!", ButtonEnum.Ok, Icon.Success).ShowAsync();
                }
                catch (IOException ex)
                {
                    await MessageBoxManager.GetMessageBoxStandard("Ошибка", $"Не удалось сохранить файл: {ex.Message}", ButtonEnum.Ok, Icon.Error).ShowAsync();
                }
            }
        }
    }
}