using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Shapes;

namespace WPF_Project
{
    /// <summary>
    /// Логика взаимодействия для ClientWindow.xaml
    /// </summary>
    public partial class ClientWindow : Window
    {
        private BooksViewModel _viewModel;
        int userid = ((App)Application.Current).Session.UserId;
        public BooksRepository _repository;
        public BookAndStatusBookViewModel andStatusBookViewModel;
        private bool SortTitle = false;
        private bool SortPrice = false;
        public ClientWindow()
        {
            InitializeComponent();
            string userEmail = ((App)Application.Current).Session.Email;
            UserEmail.Text= userEmail;
            _repository = new BooksRepository();
            _viewModel = new BooksViewModel();
             andStatusBookViewModel = new BookAndStatusBookViewModel();
            andStatusBookViewModel.BooksViewModel = new BooksViewModel();
            andStatusBookViewModel.UserBooksViewModel = new UserBooksViewModel(userid, true);
            DataContext = andStatusBookViewModel;
        }
        private void SearchButton_Click(object sender, RoutedEventArgs e)
        {
            string searchText = searchBox.Text.Trim();
            if (!string.IsNullOrEmpty(searchText))
            {  
                andStatusBookViewModel.BooksViewModel.Books.Clear();
                _repository.SearchBooks(searchText, andStatusBookViewModel.BooksViewModel.Books);
                
            }
            else
            {
                andStatusBookViewModel.BooksViewModel.Books.Clear();
                _repository.LoadBooks(andStatusBookViewModel.BooksViewModel.Books);
            }
        }
        private void SortButtonTitle_Click(object sender, RoutedEventArgs e)
        {
            if (SortTitle == false)
            {
                string iconString = "ArrowSortUp16";
                Wpf.Ui.Common.SymbolRegular icon = (Wpf.Ui.Common.SymbolRegular)Enum.Parse(typeof(Wpf.Ui.Common.SymbolRegular), iconString);
                SortTitleButton.Icon = icon;
                SortTitle = true;
                andStatusBookViewModel.BooksViewModel.Books.Clear();
                _repository.SortTitleDesc(andStatusBookViewModel.BooksViewModel.Books);
            }
            else
            {
                string iconString = "ArrowSortDown16";
                Wpf.Ui.Common.SymbolRegular icon = (Wpf.Ui.Common.SymbolRegular)Enum.Parse(typeof(Wpf.Ui.Common.SymbolRegular), iconString);
                SortTitleButton.Icon = icon;
                andStatusBookViewModel.BooksViewModel.Books.Clear();
                _repository.SortTitleAsc(andStatusBookViewModel.BooksViewModel.Books);
                SortTitle = false;
            }
        }
        private void SortButtonPrice_Click(object sender, RoutedEventArgs e)
        {
            if (SortPrice == false)
            {
                string iconString = "ArrowSortUp16";
                Wpf.Ui.Common.SymbolRegular icon = (Wpf.Ui.Common.SymbolRegular)Enum.Parse(typeof(Wpf.Ui.Common.SymbolRegular), iconString);
                SortPriceButton.Icon = icon;
                SortPrice = true;
                andStatusBookViewModel.BooksViewModel.Books.Clear();
                _repository.SortPriceDesc(andStatusBookViewModel.BooksViewModel.Books);
            }
            else
            {
                string iconString = "ArrowSortDown16";
                Wpf.Ui.Common.SymbolRegular icon = (Wpf.Ui.Common.SymbolRegular)Enum.Parse(typeof(Wpf.Ui.Common.SymbolRegular), iconString);
                SortPriceButton.Icon = icon;
                andStatusBookViewModel.BooksViewModel.Books.Clear();
                _repository.SortPriceAsc(andStatusBookViewModel.BooksViewModel.Books);
                SortPrice = false;
            }
        }
        private void btnBackToLoginWindow_Click(object sender, RoutedEventArgs e)
        {
            LoginWindow loginWindow = new LoginWindow();
            loginWindow.Show();
            this.Close();
        }

        

        private void btnUserBooksWindow_Click(object sender, RoutedEventArgs e)
        {
            UserBooksWindow userBooksWindow = new UserBooksWindow();
            userBooksWindow.ShowDialog();

        }

        private void btnUserOrdersWindow_Click(object sender, RoutedEventArgs e)
        {
            OrdersClientWindow ordersClientWindow = new OrdersClientWindow();
            ordersClientWindow.ShowDialog();
        }

        private void btnRefreshUserBookGrid_Click(object sender, RoutedEventArgs e)
        {
            BookAndStatusBookViewModel andStatusBookViewModel = new BookAndStatusBookViewModel();
            andStatusBookViewModel.BooksViewModel = new BooksViewModel();
            andStatusBookViewModel.UserBooksViewModel = new UserBooksViewModel(userid, true);
            DataContext = andStatusBookViewModel;
        }

        private void productsList_MouseDoubleClick_1(object sender, MouseButtonEventArgs e)
        {
            Book selectedProduct = productsList.SelectedItem as Book;
            if (selectedProduct != null)
            {
                var productDetailsWindow = new ProductDetailsWindow(selectedProduct);
                productDetailsWindow.ShowDialog();
            }
        }

        private void btnUserInfoWindow_Click(object sender, RoutedEventArgs e)
        {
            UserInfo userInfo = new UserInfo();
            userInfo.Show();
        }
    }
}