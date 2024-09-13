using System;
using System.Collections;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.IO;
using System.Linq;
using System.Runtime.CompilerServices;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;
using System.Xml.Serialization;
using GalaSoft.MvvmLight.Command;
using MaterialDesignThemes.Wpf;
using Oracle.ManagedDataAccess.Client;
using static System.Reflection.Metadata.BlobBuilder;

namespace WPF_Project
{
    /// <summary>
    /// Interaction logic for AdminWindow.xaml
    /// ConfigurationManager.ConnectionStrings["OracleConnectionAdmin"].ConnectionString
    /// </summary>
    public partial class BookWindow : Window
    {   string xmlPath = @"F:\ЕБАТОРИЯ\2 курс 2 сем\C#\WPF_ProjectV3\WPF_Project\Product.xml";
        
        private BooksViewModel _viewModel;
        private readonly BooksRepository _repository = new BooksRepository();
        private bool SortTitle = false;
        private bool SortPrice = false;
        public BookWindow()
        {
            
            InitializeComponent();
            
            _viewModel = new BooksViewModel();
            DataContext = _viewModel;
           
        }
        private void BookWindow_Loaded(object sender, RoutedEventArgs e)
        {
            _repository.LoadBooks(_viewModel.Books);
        }
        private void btnDelete_Click(object sender, RoutedEventArgs e)
        {
            // Получаем выбранную книгу из ListBox
            Book selectedBook = productsList.SelectedItem as Book;
            if (selectedBook != null)
            {
                _repository.DeleteBook(selectedBook);
                _viewModel.Books.Clear();
                _repository.LoadBooks(_viewModel.Books);
            }
            else
            {
                MessageBox.Show("Выберите продукт для удаления.");
            }

        }

        private void btnEdit_Click(object sender, RoutedEventArgs e)
        {
            Book selectedProduct = productsList.SelectedItem as Book;
            AuthorBook selectedProductAuthor = productsList.SelectedItem as AuthorBook;

            if (selectedProduct != null)
            {

                ProductEditWindow productEditWindow = new ProductEditWindow(selectedProduct);
                productEditWindow.ShowDialog();
            }
            else
            {
                MessageBox.Show("Выберите продукт для редактирования.");
            }
        }
        

        private void ProductsList_MouseDoubleClick(object sender, MouseButtonEventArgs e)
        {
            Book selectedProduct = productsList.SelectedItem as Book;
            if (selectedProduct != null)
            {
                var productDetailsWindow = new ProductDetailsWindow(selectedProduct);
                
                productDetailsWindow.ShowDialog();
            }
        }
        private void btnOut_Click(object sender, RoutedEventArgs e)
        {       
                var loginForm = new ChooseAdminWindow();
                loginForm.Show();
                this.Close();
        }
        private void btnAddProduct_Click(object sender, RoutedEventArgs e)
        {
            
            var loginForm = new AddProductWindow();
            if (loginForm != null)
            {
                loginForm.ShowDialog();
            }


        }
        
        private void btnRefrechListOfProduct_Click(object sender, RoutedEventArgs e)
        {
            _viewModel.Books.Clear();
            _repository.LoadBooks(_viewModel.Books);
        }



        

        private void SearchButton_Click(object sender, RoutedEventArgs e)
        {
            string searchText = searchBox.Text.Trim();
            if (!string.IsNullOrEmpty(searchText))
            {   _viewModel.Books.Clear();
                _repository.SearchBooks(searchText, _viewModel.Books);
            }
            else
            {
                _viewModel.Books.Clear();
                _repository.LoadBooks(_viewModel.Books);
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
                _viewModel.Books.Clear();
                _repository.SortTitleDesc(_viewModel.Books);
            }
            else
            {
                string iconString = "ArrowSortDown16";
                Wpf.Ui.Common.SymbolRegular icon = (Wpf.Ui.Common.SymbolRegular)Enum.Parse(typeof(Wpf.Ui.Common.SymbolRegular), iconString);
                SortTitleButton.Icon = icon;
                _viewModel.Books.Clear();
                _repository.SortTitleAsc(_viewModel.Books);
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
                _viewModel.Books.Clear();
                _repository.SortPriceDesc(_viewModel.Books);
            }
            else
            {
                string iconString = "ArrowSortDown16";
                Wpf.Ui.Common.SymbolRegular icon = (Wpf.Ui.Common.SymbolRegular)Enum.Parse(typeof(Wpf.Ui.Common.SymbolRegular), iconString);
                SortPriceButton.Icon = icon;
                _viewModel.Books.Clear();
                _repository.SortPriceAsc(_viewModel.Books);
                SortPrice = false;
            }
        }
    }

}
