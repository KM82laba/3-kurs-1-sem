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
    /// Логика взаимодействия для OrdersClientWindow.xaml
    /// </summary>
    public partial class OrdersClientWindow : Window
    {
        private OrdersViewModel ordersViewModel;
        private OrdersRepository ordersRepository;
        int userid = ((App)Application.Current).Session.UserId;
        public OrdersClientWindow()
        {
            InitializeComponent();
            ordersViewModel = new OrdersViewModel(userid);
            DataContext = ordersViewModel;
        }

        private void Button_Click(object sender, RoutedEventArgs e)
        {
            Order selectedOrder = (Order)dataGrid.SelectedItem;
            if (selectedOrder != null)
            {
                ordersViewModel.DeleteOrder(selectedOrder.OrderId);
                ordersViewModel = new OrdersViewModel(userid);
                DataContext = ordersViewModel;
            }
            else
            {
                MessageBox.Show("Выберите заказ для удаления!");
            }
        }
    }
}
