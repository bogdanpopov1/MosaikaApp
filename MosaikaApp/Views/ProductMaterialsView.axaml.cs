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
            TotalCostTextBlock.Text = $"�������� ���������: {total:F2} p";
        }

        private async void SaveReportButton_Click(object sender, RoutedEventArgs e)
        {
            var saveFileDialog = new SaveFileDialog
            {
                Title = "��������� �����",
                DefaultExtension = "txt",
                InitialFileName = $"�����_{_product.Article}_{System.DateTime.Now:yyyyMMdd}.txt",
                Filters = { new FileDialogFilter{ Name = "��������� �����", Extensions = { "txt" } } }
            };

            var filePath = await saveFileDialog.ShowAsync((Window)this.GetVisualRoot());

            if (!string.IsNullOrEmpty(filePath))
            {
                var sb = new StringBuilder();
                sb.AppendLine($"����� �� ������� ��������: {_product.Name}");
                sb.AppendLine($"�������: {_product.Article}");
                sb.AppendLine("======================================================================");
                sb.AppendLine($"{"��������",-30} | {"���-��",-10} | {"��.���.",-7} | {"���������",-10}");
                sb.AppendLine("----------------------------------------------------------------------");

                foreach (var item in Materials)
                {
                    sb.AppendLine($"{item.Material.Name,-30} | {item.Quantity,-10} | {item.Material.Unit.Name,-7} | {item.LineTotal,-10:F2} p");
                }

                sb.AppendLine("======================================================================");
                sb.AppendLine($"�������� ���������: {Materials.Sum(m => m.LineTotal):F2} p");

                try
                {
                    await File.WriteAllTextAsync(filePath, sb.ToString());
                    await MessageBoxManager.GetMessageBoxStandard("�������", "����� ������� ��������!", ButtonEnum.Ok, Icon.Success).ShowAsync();
                }
                catch (IOException ex)
                {
                    await MessageBoxManager.GetMessageBoxStandard("������", $"�� ������� ��������� ����: {ex.Message}", ButtonEnum.Ok, Icon.Error).ShowAsync();
                }
            }
        }
    }
}