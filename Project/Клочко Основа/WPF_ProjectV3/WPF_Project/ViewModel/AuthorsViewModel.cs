using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.ComponentModel;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Security.Policy;
using System.Text;
using System.Threading.Tasks;
using System.Windows;

namespace WPF_Project
{
    public class AuthorsViewModel : INotifyPropertyChanged
    {
        private ObservableCollection<Author> authors;
        private readonly AuthorsRepository _repository;
        private string connectionString = ((App)Application.Current).Session.Conn;
        public ObservableCollection<Author> Authors
        {
            get { return authors; }
            set
            {
                authors = value;
                OnPropertyChanged("Authors");
            }
        }

        public bool IsSelected { get; set; }

        public AuthorsViewModel()
        {
            _repository = new AuthorsRepository(connectionString);
            LoadAuthors();
            
        }
        
        private void LoadAuthors()
        {
            DataTable authorsTable = _repository.GetAllAuthors();

            Authors = new ObservableCollection<Author>();

            foreach (DataRow row in authorsTable.Rows)
            {
                Author author = new Author()
                {
                    AuthorId = Convert.ToInt32(row["author_id"]),
                    AuthorName = (string)row["author_name"]
                };

                Authors.Add(author);
            }
        }
        public AuthorsViewModel(int bookId)
        {
            _repository = new AuthorsRepository(connectionString);
            LoadAuthorsForBook(bookId);

        }
        private void LoadAuthorsForBook(int bookId)
        {
            DataTable authorsTable = _repository.GetAllAuthors();
            List<Author> authorsForBookTable = _repository.GetAuthorsForBook(bookId);

            Authors = new ObservableCollection<Author>();

            foreach (DataRow row in authorsTable.Rows)
            {
                Author author = new Author()
                {
                    AuthorId = Convert.ToInt32(row["author_id"]),
                    AuthorName = (string)row["author_name"]
                };

                if (authorsForBookTable.Any(a => a.AuthorId == author.AuthorId))
                {
                    author.IsSelected = true;
                }

                Authors.Add(author);
            }
        }

        public void AddAuthor(Author author)
        {
            int newAuthorId = _repository.GetNextAuthorId() + 1;
            author.AuthorId = newAuthorId;
            _repository.AddAuthor(author);
            Authors.Add(author);
        }

        public void UpdateAuthor(Author author)
        {
            _repository.UpdateAuthor(author);

        }

        public void DeleteAuthor(Author author)
        {
            _repository.DeleteAuthor(author);
            Authors.Remove(author);
             LoadAuthors(); // Загрузить обновленный список авторов
            
        }

        public event PropertyChangedEventHandler PropertyChanged;

        public void OnPropertyChanged(string propertyName)
        {
            PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(propertyName));
        }
    }
    public class Author : INotifyPropertyChanged
    {
        private bool isSelectedForBook;

        public int AuthorId { get; set; }
        public string AuthorName { get; set; }

        public bool IsSelected
        {
            get { return isSelectedForBook; }
            set
            {
                isSelectedForBook = value;
                OnPropertyChanged("IsSelected");
            }
        }

        public event PropertyChangedEventHandler PropertyChanged;

        public void OnPropertyChanged(string propertyName)
        {
            PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(propertyName));
        }
    }

}
