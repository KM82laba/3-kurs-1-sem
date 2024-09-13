using System;
using System.Collections.Generic;
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

namespace WPF_Project
{
    /// <summary>
    /// Логика взаимодействия для PublishersWindow.xaml
    /// </summary>
    public partial class PublishersWindow : Window
    {
        private PublishersViewModel _viewModel;
        public PublishersWindow()
        {
            InitializeComponent();
            _viewModel = new PublishersViewModel();
            DataContext = _viewModel;
        }

        private void AddPublisherButton_Click(object sender, RoutedEventArgs e)
        {
            if(newPublisherNameTextBox.Text != "") { 
                Publisher publisher = new Publisher
                {
                    PublisherName = newPublisherNameTextBox.Text
                };

                _viewModel.AddPublisher(publisher);

                newPublisherNameTextBox.Text = "";
            }
            else
            {
                MessageBox.Show("Введите данные");
            }
        }

        private void DeletePublisherButton_Click(object sender, RoutedEventArgs e)
        {
            Publisher publisher = (Publisher)dataGrid.SelectedItem;

            if (publisher != null)
            {
                _viewModel.DeletePublisher(publisher);
            }
            else
            {
                MessageBox.Show("Выберите издателя  для  удаления");
            }
        }

        private void EditPublisherButton_Click(object sender, RoutedEventArgs e)
        {   Publisher publisher = (Publisher)dataGrid.SelectedItem;
            if (publisher == null)
            {
                MessageBox.Show("Выберите для редактирования");
                return;
            }
            else {
                if (EditPublisherNameTextBox.Text != "")
                {
                    string newPublisherName = EditPublisherNameTextBox.Text;

                    // Обновить имя издателя
                    publisher.PublisherName = newPublisherName;

                    // Сохранить изменения в базе данных
                    _viewModel.UpdatePublisher(publisher);
                    EditPublisherNameTextBox.Text = "";
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
