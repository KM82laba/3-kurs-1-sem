using Oracle.ManagedDataAccess.Client;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Net;
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
using static System.Net.Mime.MediaTypeNames;

namespace WPF_Project
{
    /// <summary>
    /// Логика взаимодействия для ProductDetailsWindow.xaml
    /// </summary>
    public partial class ProductDetailsWindow : Window
    {
        private string BookContent;
        private int BookID;
        private decimal PriceBook;
        private ReviewsViewModel _reviewsView;
        private OrdersViewModel _ordersViewModel;
        private UserBooksViewModel _userBooksVewModel;
        public ProductDetailsWindow(Book book)
        {
            InitializeComponent();
            
            BookID = book.BookId;
            PriceBook = book.Price;
            _reviewsView = new ReviewsViewModel(BookID);
            _ordersViewModel = new OrdersViewModel();
            titleTextBlock.Text = book.Title;
            priceTextBlock.Text = book.Price.ToString("C", CultureInfo.GetCultureInfo("be-BY"));
            descriptionTextBlock.Text = book.Description;
            yearPublishedTextBlock.Text = book.YearPublished.ToString("yyyy");
            quantityTextBox.Text = book.Quantity.ToString();

            quantityTextBlock.PreviewTextInput += Quantity_PreviewTextInput;
            quantityTextBlock.PreviewKeyDown += Quantity_PreviewKeyDown;

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
            coverImageBlock.Source = image;

            var publishersViewModel = new PublishersViewModel();
            var selectedPublisherId = book.PublisherId;
            var selectedPublisher = publishersViewModel.Publishers.FirstOrDefault(p => p.PublisherId == selectedPublisherId);
            publisherTextBlock.Text = selectedPublisher.PublisherName;

            int bookId = book.BookId;
            AuthorsViewModel authorsViewModel = new AuthorsViewModel(bookId);
            var authors = authorsViewModel.Authors;
            string authorNames = string.Join(", ", authors.Where(a => a.IsSelected).Select(a => a.AuthorName));
            authorsTextBlock.Text = authorNames;

            CategoryViewModel categoriesViewModel= new CategoryViewModel(bookId);
            var categories = categoriesViewModel.Category;
            string categoryNames = string.Join(", ", categories.Where(a => a.IsSelected).Select(a => a.CategoryName));
            categoryTextBlock.Text = categoryNames;

            ReviewsViewModel _reviewsViewModel = new ReviewsViewModel(bookId);
            _userBooksVewModel = new UserBooksViewModel(bookId);


            UserBooksAndReviewsViewModels _userBooksAndReviewsViewModels = new UserBooksAndReviewsViewModels();
            _userBooksAndReviewsViewModels.ReviewsViewModel = new ReviewsViewModel(bookId);
            _userBooksAndReviewsViewModels.UserBooksViewModel = new UserBooksViewModel(bookId);
            DataContext = _userBooksAndReviewsViewModels;

            string userRole = ((App)System.Windows.Application.Current).Session.Role;
            if (userRole == "admin")
            {
                ReviewStackPanel.Visibility = Visibility.Collapsed;
                SendReview.Visibility = Visibility.Collapsed;
                OrderBook.Visibility = Visibility.Collapsed;
                StatusBook.Visibility = Visibility.Collapsed;
            }
            else
            {
                DeleteReview.Visibility = Visibility.Collapsed;
                ReviewsListView.IsEnabled = true;
            }
            byte[] bookBytes = book.Content;

            // Преобразуем массив байтов в текстовую строку с помощью кодировки UTF8
            string bookContent = Encoding.UTF8.GetString(bookBytes);
            BookContent = bookContent;
        }
        private void Quantity_PreviewKeyDown(object sender, KeyEventArgs e)
        {
            // Предотвращаем вставку из буфера обмена и ввод пробела
            if (e.Key == Key.Space || (e.Key == Key.V && (Keyboard.Modifiers & ModifierKeys.Control) == ModifierKeys.Control))
            {
                e.Handled = true;
            }
        }
        private void Quantity_PreviewTextInput(object sender, TextCompositionEventArgs e)
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
        private void SendReview_Click(object sender, RoutedEventArgs e)
        {
            string reviewtext = ReviewRichTextBox.Text;
            
            int rating =  (int)RatingControl.Value;
            int userId = ((App)System.Windows.Application.Current).Session.UserId;
            if (rating <= 0 || RatingControl.Value <= 0 || ReviewRichTextBox.Text == "")
            {

                MessageBox.Show("Оцените книгу");
            }
            else
            {
                Review review = new Review()
                {
                    Rating = rating,
                    ReviewText = reviewtext,
                    UserId = userId,
                    BookId = BookID,
                };
                _reviewsView.AddReview(review);

                UserBooksAndReviewsViewModels _userBooksAndReviewsViewModels = new UserBooksAndReviewsViewModels();
                _userBooksAndReviewsViewModels.ReviewsViewModel = new ReviewsViewModel(BookID);
                _userBooksAndReviewsViewModels.UserBooksViewModel = new UserBooksViewModel(BookID);
                DataContext = _userBooksAndReviewsViewModels;

            }
        }
        private void Order_btn_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                if (quantityTextBlock.Text != "")
                {
                    int quantity = int.Parse(quantityTextBlock.Text);
                    int userId = ((App)System.Windows.Application.Current).Session.UserId;

                    Order order = new Order()
                    {
                        UserId = userId,
                        Quantity = quantity,
                        OrderDate = DateTime.Now,
                        DeliveryDate = DateTime.Now.AddDays(3),
                        BookId = BookID,
                        Price = PriceBook,
                        AdminId = 0,
                    };
                    _ordersViewModel.AddOrders(order);
                    MessageBox.Show("Заказ в обработке");
                    quantityTextBlock.Text = "";
                }
                else
                {
                    MessageBox.Show("Введите количество книг");
                }
            }
            catch 
            {
              MessageBox.Show("Недостаточное количество книг");
            }
        }

        private void StatusComboBox_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            var comboBox = sender as ComboBox;
            var selectedStatus = comboBox.SelectedItem as string;
            if (selectedStatus != null)
            {
                // Выполните необходимые операции для обновления значения в базе данных
                _userBooksVewModel.UpdateUserBookStatus(selectedStatus , BookID);
            }

        }

        private void Button_Click(object sender, RoutedEventArgs e)
        {
            Review selectedBook = ReviewsListView.SelectedItem as Review;
            if (selectedBook != null)
            {
                _reviewsView.DeleteReview(selectedBook);
                UserBooksAndReviewsViewModels _userBooksAndReviewsViewModels = new UserBooksAndReviewsViewModels();
                _userBooksAndReviewsViewModels.ReviewsViewModel = new ReviewsViewModel(BookID);
                _userBooksAndReviewsViewModels.UserBooksViewModel = new UserBooksViewModel(BookID);
                DataContext = _userBooksAndReviewsViewModels;
            }
            else
            {
                MessageBox.Show("Выберите комментарий для удаления.");
            }
        }

        private void OpenReader_Click(object sender, RoutedEventArgs e)
        {
            BookReader bookReader = new BookReader(BookContent);
            bookReader.Show();
            
        }
    }
}
