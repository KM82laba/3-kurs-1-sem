using Oracle.ManagedDataAccess.Client;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.ComponentModel;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using WPF_Project.Repository;

namespace WPF_Project.ViewModel
{
    public class BooksViewModel : INotifyPropertyChanged
    {
        private ObservableCollection<Book> books;
        private BooksRepository _repository;

        public ObservableCollection<Book> Books
        {
            get { return books; }
            set
            {
                books = value;
                OnPropertyChanged("Books");
            }
        }

        public BooksViewModel()
        {
            _repository = new BooksRepository();
            Books = new ObservableCollection<Book>();
            _repository.LoadBooks(Books);

        }

        public event PropertyChangedEventHandler PropertyChanged;

        protected void OnPropertyChanged(string propertyName)
        {
            PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(propertyName));
        }
    }

    public class Book
    {
        public int BookId { get; set; }
        public string Title { get; set; }
        public string Description { get; set; }
        public decimal Price { get; set; }
        public DateTime YearPublished { get; set; }
        public byte[] CoverImage { get; set; }
        public byte[] Content { get; set; }
        public int PublisherId { get; set; }
        public int AdminId { get; set; }
        public int Quantity { get; set; }
    }
    public class AuthorBook
    {
        public int AuthorId { get; set; }
    }
    public class CategoryBook
    {
        public int CategoryId { get; set; }
    }
}
