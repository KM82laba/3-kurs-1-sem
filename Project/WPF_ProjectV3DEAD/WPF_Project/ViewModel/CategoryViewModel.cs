using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.ComponentModel;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Configuration;
using WPF_Project.Repository;

namespace WPF_Project.ViewModel
{
    public class CategoryViewModel : INotifyPropertyChanged
    {
        private ObservableCollection<Category> category;
        private readonly CategoryRepository _repository;
        private string connectionString = ((App)Application.Current).Session.Conn;
        public ObservableCollection<Category> Category
        {
            get { return category; }
            set
            {
                category = value;
                OnPropertyChanged("Category");
            }
        }

        public CategoryViewModel()
        {
            _repository = new CategoryRepository(connectionString);
            LoadCategory();
        }

        private void LoadCategory()
        {
            DataTable categoryTable = _repository.GetAllCategories();

            Category = new ObservableCollection<Category>();

            foreach (DataRow row in categoryTable.Rows)
            {
                Category category = new Category()
                {
                    CategoryId = Convert.ToInt32(row["category_id"]),
                    CategoryName = (string)row["category_name"]
                };

                Category.Add(category);
            }
        }
        public CategoryViewModel(int bookId)
        {
            _repository = new CategoryRepository(connectionString);
            LoadAuthorsForBook(bookId);
        }
        private void LoadAuthorsForBook(int bookId)
        {
            DataTable categoryTable = _repository.GetAllCategories();
            List<Category> authorsForBookTable = _repository.GetCategoryForBook(bookId);

            Category = new ObservableCollection<Category>();

            foreach (DataRow row in categoryTable.Rows)
            {
                Category category = new Category()
                {
                    CategoryId = Convert.ToInt32(row["category_id"]),
                    CategoryName = (string)row["category_name"]
                };

                if (authorsForBookTable.Any(a => a.CategoryId == category.CategoryId))
                {
                    category.IsSelected = true;
                }

                Category.Add(category);
            }
        }
        public void AddCategory(Category category)
        {
            int newCategoryId = _repository.GetNextCategoryId() + 1;
            category.CategoryId = newCategoryId;
            _repository.AddCategory(category);
            Category.Add(category);
        }

        public void UpdateCategory(Category category)
        {
            _repository.UpdateCategory(category);


        }

        public void DeleteCategory(Category category)
        {
            _repository.DeleteCategory(category);
            Category.Remove(category);
            LoadCategory(); // Загрузить обновленный список авторов

        }

        public event PropertyChangedEventHandler PropertyChanged;

        public void OnPropertyChanged(string propertyName)
        {
            PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(propertyName));
        }
    }
    public class Category : INotifyPropertyChanged
    {
        private bool isSelectedForBook;
        public int CategoryId { get; set; }
        public string CategoryName { get; set; }

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

