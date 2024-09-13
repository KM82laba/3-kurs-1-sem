using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.ComponentModel;
using System.Configuration;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;

namespace WPF_Project.ViewModel
{
    public class UserBooksViewModel : INotifyPropertyChanged
    {
        private UserBook _selectedUserBook;
        private ObservableCollection<string> _possibleStatuses;
        private string _connectionString = ((App)Application.Current).Session.Conn;
        private ObservableCollection<BookWithStatus> _books;
        public string SelectedStatus { get; set; }
        public ObservableCollection<UserBook> UserBooks { get; set; }
        public ObservableCollection<string> PossibleStatuses
        {
            get { return _possibleStatuses; }
            set
            {
                _possibleStatuses = value;
                OnPropertyChanged(nameof(PossibleStatuses));
            }
        }

        public ObservableCollection<BookWithStatus> Books
        {
            get { return _books; }
            set
            {
                _books = value;
                OnPropertyChanged(nameof(Books));
            }
        }
        public UserBooksViewModel(int userId, bool cur)
        {
            var repository = new UserBooksRepository(_connectionString);
            Books = new ObservableCollection<BookWithStatus>(repository.GetUserBooksWithStatus(userId));
        }

        public UserBooksViewModel(int bookId)
        {
            var repository = new UserBooksRepository(_connectionString);
            UserBooks = new ObservableCollection<UserBook>();
            repository.LoadUserBooks(UserBooks, bookId);

            // Заполнение списка возможных статусов
            PossibleStatuses = new ObservableCollection<string>
        {
            "Прочитана",
            "Не прочитана",
            "Читаю",
            "Брошена"
        };
            SelectedStatus = UserBooks.FirstOrDefault()?.Status;
        }

        public void UpdateUserBookStatus(string selectedStatus, int bookid)
        {
            var repository = new UserBooksRepository(_connectionString);
            repository.UpdateUserBookStatus(selectedStatus, bookid);
        }

        public event PropertyChangedEventHandler PropertyChanged;

        protected void OnPropertyChanged(string propertyName)
        {
            PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(propertyName));
        }
    }

    public class UserBook
    {
        public int UserId { get; set; }
        public int BookId { get; set; }
        public string Status { get; set; }
    }
    public class BookWithStatus
    {
        public int BookId { get; set; }
        public string BookName { get; set; }
        public string Status { get; set; }
    }
}
