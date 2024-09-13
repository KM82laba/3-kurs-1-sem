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
    /// Логика взаимодействия для ChooseAdminWindow.xaml
    /// </summary>
    public partial class ChooseAdminWindow : Window
    {
        public ChooseAdminWindow()
        {
            InitializeComponent();
        }

        private void ButtonOrders_Click(object sender, RoutedEventArgs e)
        {
            OrdersAdminWindow ordersAdminWindow = new OrdersAdminWindow();
            ordersAdminWindow.Show();
            this.Close();
        }

        private void ButtonCategories_Click(object sender, RoutedEventArgs e)
        {
            CategoriesWindow categoriesWindow = new CategoriesWindow();
            categoriesWindow.Show();
            this.Close();
        }

        private void ButtonAutors_Click(object sender, RoutedEventArgs e)
        {
            AuthorsWindow authorsWindow = new AuthorsWindow();
            authorsWindow.Show();
            this.Close();
        }

        private void ButtonPublishers_Click(object sender, RoutedEventArgs e)
        {
            PublishersWindow publishersWindow= new PublishersWindow();
            publishersWindow.Show();
            this.Close();
        }

        private void ButtonBooks_Click(object sender, RoutedEventArgs e)
        {
            BookWindow bookWindow = new BookWindow();
            bookWindow.Show();
            this.Close();
        }

        private void btnOut_Click(object sender, RoutedEventArgs e)
        {
            LoginWindow loginWindow = new LoginWindow();
            loginWindow.Show();
            this.Close();
        }
    }
}
