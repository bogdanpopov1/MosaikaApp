using Avalonia.Controls;
using System.Collections.Generic;
using System.Linq;
using MosaikaApp.Views;

namespace MosaikaApp
{
    public partial class MainWindow : Window
    {
        private readonly Stack<UserControl> _history = new Stack<UserControl>();
        private ContentControl _mainContent;
        private Button _backButton;

        public MainWindow()
        {
            InitializeComponent();
            _mainContent = this.FindControl<ContentControl>("MainContent")!;
            _backButton = this.FindControl<Button>("BackButton")!;

            NavigateTo(new ProductListView(this));
        }

        public void NavigateTo(UserControl page)
        {
            if (_mainContent.Content is UserControl currentPage)
            {
                _history.Push(currentPage);
            }
            _mainContent.Content = page;
            UpdateBackButtonVisibility();
        }

        public void GoBack()
        {
            if (_history.Any())
            {
                var previousPage = _history.Pop();
                _mainContent.Content = previousPage;

                if (previousPage is ProductListView productListView)
                {
                    productListView.LoadProducts();
                }

                UpdateBackButtonVisibility();
            }
        }

        private void GoBack_Click(object sender, Avalonia.Interactivity.RoutedEventArgs e)
        {
            GoBack();
        }

        private void UpdateBackButtonVisibility()
        {
            _backButton.IsVisible = _history.Any();
        }
    }
}