using Microsoft.Win32;
using Oracle.ManagedDataAccess.Client;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.IO;
using System.Linq;
using System.Security.Policy;
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
using ModernWpf.Controls;
using System.Diagnostics;
using WPF_Project.ViewModel;
using WPF_Project.Repository;

namespace WPF_Project
{
    /// <summary>
    /// Логика взаимодействия для AddProductWindow.xaml
    /// </summary>


    public partial class AddProductWindow : Window
    {
        private BooksViewModel _viewModel;
        private BooksRepository _repository;
        private PublishersViewModel _viewModelpublishers;
        private AuthorsViewModel _viewModelauthors;
        private CategoryViewModel _viewModelcategory;
        byte[] bookContentBytes = null;
        
        public AddProductWindow()
        {   InitializeComponent();
            _viewModel = new BooksViewModel();
            _repository = new BooksRepository();
            DataContext = _viewModel;
            priceTextBox.PreviewTextInput += PriceTextBox_PreviewTextInput;
            priceTextBox.PreviewKeyDown += PriceTextBox_PreviewKeyDown;
            quantityTextBox.PreviewTextInput += PriceTextBox_PreviewTextInput;
            quantityTextBox.PreviewKeyDown += PriceTextBox_PreviewKeyDown;
        }




        private void PriceTextBox_PreviewKeyDown(object sender, KeyEventArgs e)
        {
            // Предотвращаем вставку из буфера обмена и ввод пробела
            if (e.Key == Key.Space || (e.Key == Key.V && (Keyboard.Modifiers & ModifierKeys.Control) == ModifierKeys.Control))
            {
                e.Handled = true;
            }
        }
        private void PriceTextBox_PreviewTextInput(object sender, TextCompositionEventArgs e)
        {
            if (!IsNumeric(e.Text))
            {
                e.Handled = true; // Отменяем ввод, если не является цифрой
            }
        }
        private bool IsNumeric(string text)
        {
            return text.All(char.IsDigit);
        }
        private void cancelButton_Click(object sender, RoutedEventArgs e)
        {
            // Закрываем форму без сохранения изменений
            Close();
            _repository.LoadBooks(_viewModel.Books);
        }
       

        private void AddBookButton_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                var selectedPublisher = (Publisher)publishersComboBox.SelectedItem;
                if (selectedPublisher != null && titleTextBox.Text != "" && descriptionTextBox.Text != "" && priceTextBox.Text != "" && yearPublishedDatePicker.SelectedDate.Value != null && bookContentBytes != null)
                {
                    string title = titleTextBox.Text;
                    string description = descriptionTextBox.Text;
                    decimal price = Decimal.Parse(priceTextBox.Text);
                    int publisherId = selectedPublisher.PublisherId;
                    int adminId = ((App)Application.Current).Session.UserId;
                    DateTime yearPublished = yearPublishedDatePicker.SelectedDate.Value;
                    int quantity = int.Parse(quantityTextBox.Text);//TODO
                    // Convert the image to bytes if it's not null
                    byte[] coverImageBytes = null;
                    if (сoverImage.Source != null)
                    {
                        using (MemoryStream memoryStream = new MemoryStream())
                        {
                            JpegBitmapEncoder encoder = new JpegBitmapEncoder();
                            encoder.Frames.Add(BitmapFrame.Create((BitmapSource)сoverImage.Source));
                            encoder.Save(memoryStream);
                            coverImageBytes = memoryStream.ToArray();
                        }
                    }

                    Book book = new Book()
                    {
                        Title = title,
                        Description = description,
                        Price = price,
                        YearPublished = yearPublished,
                        CoverImage = coverImageBytes,
                        PublisherId = publisherId,
                        AdminId = adminId,
                        Content = bookContentBytes,
                        Quantity = quantity

                    };

                    _repository.AddBook(book);


                    var authorsViewModel = (AuthorsViewModel)AutAddList.DataContext;
                    var selectedAuthors = authorsViewModel.Authors.Where(a => a.IsSelected).ToList();
                    foreach (var author in selectedAuthors)
                    {
                        // Create a new Authors_Books object
                        var authorBook = new AuthorBook()
                        {
                            AuthorId = author.AuthorId
                        };

                        // Add the Authors_Books object to the repository
                        _repository.AddAuthorBook(authorBook);
                    }
                    var categoryViewModel = (CategoryViewModel)CatAddList.DataContext;
                    var selectedCategory = categoryViewModel.Category.Where(a => a.IsSelected).ToList();
                    foreach (var category in selectedCategory)
                    {
                        // Create a new Authors_Books object
                        var categoryBook = new CategoryBook()
                        {
                            CategoryId = category.CategoryId
                        };

                        // Add the Authors_Books object to the repository
                        _repository.AddCategoryBook(categoryBook);
                    }
                    _viewModel.Books.Add(book);
                    _viewModel.Books.Clear();
                    _repository.LoadBooks(_viewModel.Books);
                    MessageBox.Show("Успешно!");
                   
                }
                else
                {
                    MessageBox.Show("Неверные данные!");
                }
            }
            catch(OracleException ex)
            {
                if (ex.Number == 20002)
                {
                    MessageBox.Show("Книга с таким название уже существует");
                }
                else
                {
                    MessageBox.Show(ex.Message);
                }
                
            }
        }
        private class TestDialog : ContentDialog
        {
            public override void OnApplyTemplate()
            {
                base.OnApplyTemplate();

                var dialogShowingStates = GetTemplateChild("DialogShowingStates") as VisualStateGroup;
                var backgroundElement = GetTemplateChild("BackgroundElement") as FrameworkElement;
                Debug.Assert(dialogShowingStates != null && backgroundElement != null);
                dialogShowingStates.CurrentStateChanged += (s, e) =>
                {
                    //Debug.WriteLine($"OldState: {e.OldState?.Name}, NewState: {e.NewState.Name}");
                    if (e.NewState.Name == "DialogShowing")
                    {
                        Dispatcher.BeginInvoke(() =>
                        {
                            Debug.Assert(KeyboardNavigation.GetTabNavigation(backgroundElement) == KeyboardNavigationMode.Cycle);
                        });
                    }
                };
            }
        }
        private void selectImageButton(object sender, RoutedEventArgs e)
        {
                OpenFileDialog openFileDialog = new OpenFileDialog();
        openFileDialog.Filter = "Image files (*.jpg, *.jpeg, *.png) | *.jpg; *.jpeg; *.png";

        if (openFileDialog.ShowDialog() == true)
        {
            string imagePath = openFileDialog.FileName;
            BitmapImage bitmap = new BitmapImage(new Uri(imagePath));
            сoverImage.Source = bitmap;
        }
        }

        private void selectIContentButton(object sender, RoutedEventArgs e)
        {
            OpenFileDialog openFileDialog = new OpenFileDialog();
            
            if (openFileDialog.ShowDialog() == true)
            {
                using (FileStream fs = new FileStream(openFileDialog.FileName, FileMode.Open, FileAccess.Read))
                {
                    using (BinaryReader reader = new BinaryReader(fs))
                    {
                        bookContentBytes = reader.ReadBytes((int)fs.Length);
                    }
                }
            }
        }
    }
}
