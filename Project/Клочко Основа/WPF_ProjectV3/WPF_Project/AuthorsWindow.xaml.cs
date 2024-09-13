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
    /// Логика взаимодействия для AuthorsWindow.xaml
    /// </summary>
    public partial class AuthorsWindow : Window
    {
        private AuthorsViewModel _viewModel;
        public AuthorsWindow()
        {
            InitializeComponent();
            _viewModel = new AuthorsViewModel();
            DataContext = _viewModel;
        }

        private void AddAuthorButton_Click(object sender, RoutedEventArgs e)
        {
            if (newAuthorNameTextBox.Text != "")
            {
                Author author = new Author
                {
                    AuthorName = newAuthorNameTextBox.Text
                };

                _viewModel.AddAuthor(author);

                newAuthorNameTextBox.Text = "";
            }
            else
            {
                MessageBox.Show("Введите данные");
            }
        }

        private void DeleteAuthorButton_Click(object sender, RoutedEventArgs e)
        {
            Author author = (Author)dataGrid.SelectedItem;

            if (author != null)
            {
                _viewModel.DeleteAuthor(author);
            }
            else
            {
                MessageBox.Show("Выберите автора для удаления");
            }
        }

        private void EditAuthorButton_Click(object sender, RoutedEventArgs e)
        {
            Author author = (Author)dataGrid.SelectedItem;

            if (author == null)
            {
                MessageBox.Show("Выберите автора для изменения");
                return;
            }
            else
            {
                if (EditAuthorNameTextBox.Text != "")
                {
                    string newAuthorName = EditAuthorNameTextBox.Text;

                    // Обновить имя издателя
                    author.AuthorName = newAuthorName;

                    // Сохранить изменения в базе данных
                    _viewModel.UpdateAuthor(author);
                    EditAuthorNameTextBox.Text = "";
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
