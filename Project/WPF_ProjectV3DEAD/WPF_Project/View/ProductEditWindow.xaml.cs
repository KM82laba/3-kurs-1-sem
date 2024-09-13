using Microsoft.Win32;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.IO;
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
using System.Xml.Linq;
using WPF_Project.Repository;
using WPF_Project.ViewModel;

namespace WPF_Project
{
    /// <summary>
    /// Логика взаимодействия для ProductEditWindow.xaml
    /// </summary>
    public partial class ProductEditWindow : Window
    {
        private BooksViewModel _viewModel;
        private BooksRepository _repository;
        private AuthorsViewModel _authorsView;
        private int CurrentBookId;
        byte[] bookContentBytes = null;
        public ProductEditWindow(Book book)
        {
            _viewModel = new BooksViewModel();
            _repository = new BooksRepository();
            _authorsView = new AuthorsViewModel();
            InitializeComponent();
            DataContext = book;

            titleTextBox.Text = book.Title;
            priceTextBox.Text = book.Price.ToString();
            descriptionTextBox.Text = book.Description;
            quantityTextBox.Text = book.Quantity.ToString();
            yearPublishedDatePicker.SelectedDate = new DateTime?(book.YearPublished);
            var selectedPublisherId = book.PublisherId;
            // Найти элемент в ComboBox, у которого значение свойства PublisherId равно selectedPublisherId
            var selectedPublisher = publishersComboBox.Items.Cast<Publisher>().FirstOrDefault(p => p.PublisherId == selectedPublisherId);
            // Установить выбранный элемент в ComboBox
            publishersComboBox.SelectedItem = selectedPublisher;
            CurrentBookId = book.BookId;
            int bookId = book.BookId;
            AuthorsViewModel authorsViewModel = new AuthorsViewModel(bookId);
            AutAddList.DataContext = authorsViewModel;
            CategoryViewModel categoriesWindow = new CategoryViewModel(bookId);
            CatAddList.DataContext = categoriesWindow;
            bookContentBytes = book.Content;
            byte[] imageData = book.CoverImage;
            BitmapImage image = new BitmapImage();
            using (MemoryStream memory = new MemoryStream(imageData))
            {
                memory.Position = 0;
                image.BeginInit();
                image.StreamSource = memory;
                image.CacheOption = BitmapCacheOption.OnLoad;
                image.EndInit();
            }
            сoverImage.Source = image;

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

        private void SaveButton_Click(object sender, RoutedEventArgs e)
        {
            var selectedPublisher = (Publisher)publishersComboBox.SelectedItem;
            if (selectedPublisher != null || titleTextBox.Text != "" || descriptionTextBox.Text != "" || priceTextBox.Text != "" || yearPublishedDatePicker.SelectedDate.Value != null)
            {
                string title = titleTextBox.Text;
                string description = descriptionTextBox.Text;
                decimal price = Decimal.Parse(priceTextBox.Text);
                int quantity = int.Parse(quantityTextBox.Text);
                int publisherId = selectedPublisher.PublisherId;
                int adminId = ((App)Application.Current).Session.UserId;
                DateTime yearPublished = yearPublishedDatePicker.SelectedDate.Value;
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

                Book books = new Book()
                {
                    BookId = CurrentBookId,
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

                _repository.UpdateBook(books);


                var authorsViewModel = (AuthorsViewModel)AutAddList.DataContext;
                var selectedAuthors = authorsViewModel.Authors.Where(a => a.IsSelected).ToList();
                var authorIds = selectedAuthors.Select(a => a.AuthorId).ToList();
                _repository.UpdateAuthorBook(CurrentBookId , authorIds);

                var categoryViewModel = (CategoryViewModel)CatAddList.DataContext;
                var selectedCategory = categoryViewModel.Category.Where(a => a.IsSelected).ToList();
                var categoryIds = selectedCategory.Select(a => a.CategoryId).ToList();
                _repository.UpdateCategoryBook(CurrentBookId, categoryIds);
                MessageBox.Show("Saccess!");
            }
            else
            {
                MessageBox.Show("Incorrect date!");
            }
            // закрываем окно
            Close();
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
