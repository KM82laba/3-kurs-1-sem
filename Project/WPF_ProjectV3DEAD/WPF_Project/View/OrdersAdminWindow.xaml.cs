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
using WPF_Project.ViewModel;

namespace WPF_Project
{
    /// <summary>
    /// Логика взаимодействия для OrdersAdminWindow.xaml
    /// </summary>
    public partial class OrdersAdminWindow : Window
    {
        private OrdersViewModel ordersViewModel;
        public OrdersAdminWindow()
        {
            InitializeComponent();
            ordersViewModel = new OrdersViewModel();
            DataContext = ordersViewModel;
        }

        private void btnBackToChooseAdminWindow_Click(object sender, RoutedEventArgs e)
        {
            ChooseAdminWindow chooseAdminWindow = new ChooseAdminWindow();
            chooseAdminWindow.Show();
            this.Close();
        }
        private void Button_Click(object sender, RoutedEventArgs e)
        {
            Order selectedOrder = (Order)dataGrid.SelectedItem;
            if (selectedOrder != null)
            {
                ordersViewModel.DeleteOrder(selectedOrder.OrderId);
                ordersViewModel = new OrdersViewModel();
                DataContext = ordersViewModel;
            }
            else
            {
                MessageBox.Show("Выберите заказа для удаления!");
            }
        }
        private void ButtonAdminAdd_Click(object sender, RoutedEventArgs e)
        {
            Order selectedOrder = (Order)dataGrid.SelectedItem;
            int userid = ((App)Application.Current).Session.UserId;
            if (selectedOrder != null)
            {
                ordersViewModel.EditAdminId(selectedOrder.OrderId , userid);
                ordersViewModel = new OrdersViewModel();
                DataContext = ordersViewModel;
            }
            else
            {
                MessageBox.Show("Выберите заказа для изменения!");
            }
        }

    }
}
