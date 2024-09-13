using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Configuration;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using WPF_Project.Repository;

namespace WPF_Project.ViewModel
{
    public class OrdersViewModel
    {
        public ObservableCollection<Order> Orders { get; set; }
        private string connectionString = ((App)Application.Current).Session.Conn;
        private OrdersRepository repository;
        public OrdersViewModel()
        {
            // Создание объекта репозитория
            repository = new OrdersRepository(connectionString);

            // Получение списка заказов из базы данных и добавление их в коллекцию
            Orders = new ObservableCollection<Order>(repository.GetOrders());
        }
        public OrdersViewModel(int userId)
        {
            // Создание объекта репозитория
            repository = new OrdersRepository(connectionString);

            // Получение списка заказов из базы данных и добавление их в коллекцию
            Orders = new ObservableCollection<Order>(repository.GetUserOrders(userId));
        }
        public void AddOrders(Order order)
        {
            repository.AddOrder(order);
            Orders.Add(order);
        }
        public void DeleteOrder(int OrderId)
        {
            repository.DeleteOrder(OrderId);
        }
        public void EditAdminId(int OrderId, int adminId)
        {
            repository.EditAdminId(OrderId, adminId);
        }
    }
    public class Order
    {
        public int OrderId { get; set; }
        public int UserId { get; set; }
        public DateTime OrderDate { get; set; }
        public DateTime DeliveryDate { get; set; }
        public int BookId { get; set; }
        public int Quantity { get; set; }
        public decimal Price { get; set; }
        public int AdminId { get; set; }
        public string BookTitle { get; set; }
        public string UserFirstName { get; set; }
        public string UserLastName { get; set; }
        public string UserAdress { get; set; }
        public string UserPhoneNumber { get; set; }
    }
}
