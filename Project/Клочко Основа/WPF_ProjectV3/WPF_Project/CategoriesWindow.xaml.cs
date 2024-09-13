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
    /// Логика взаимодействия для CategoriesWindow.xaml
    /// </summary>
    public partial class CategoriesWindow : Window
    {
        CategoryViewModel _viewModel;
        public CategoriesWindow()
        {
            InitializeComponent();
            _viewModel = new CategoryViewModel();
            DataContext = _viewModel;
        }

        private void AddCategoryButton_Click(object sender, RoutedEventArgs e)
        {
            if (newCategoryNameTextBox.Text != "")
            {
                Category category = new Category
                {
                    CategoryName = newCategoryNameTextBox.Text
                };

                _viewModel.AddCategory(category);

                newCategoryNameTextBox.Text = "";
            }
            else
            {
                MessageBox.Show("Введите данные");
            }
        }

        private void DeleteCategoryButton_Click(object sender, RoutedEventArgs e)
        {
            Category category = (Category)dataGrid.SelectedItem;

            if (category != null)
            {
                _viewModel.DeleteCategory(category);
            }
            else
            {
                MessageBox.Show("Выберите категорию для удаления");
            }
        }

        private void EditCategoryButton_Click(object sender, RoutedEventArgs e)
        {
            Category category = (Category)dataGrid.SelectedItem;

            if (category == null)
            {
                MessageBox.Show("Выберите категорию для изменения");
                return;
            }
            else
            {
                if (EditCategoryNameTextBox.Text != "")
                {
                    string newCategoryName = EditCategoryNameTextBox.Text;

                    // Обновить имя издателя
                    category.CategoryName = newCategoryName;

                    // Сохранить изменения в базе данных
                    _viewModel.UpdateCategory(category);
                    EditCategoryNameTextBox.Text = "";
                    dataGrid.Items.Refresh();
                }
                else
                {
                    MessageBox.Show("Введите данные");
                }
            }
        }

        private void btnBackToChooseAdminWindow_Click(object sender, RoutedEventArgs e)
        {
            ChooseAdminWindow chooseAdminWindow = new ChooseAdminWindow();
            chooseAdminWindow.Show();
            this.Close();
        }


    }
}
