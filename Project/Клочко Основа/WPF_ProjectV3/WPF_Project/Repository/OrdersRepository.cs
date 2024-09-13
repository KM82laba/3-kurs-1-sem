using Oracle.ManagedDataAccess.Client;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace WPF_Project
{
    public class OrdersRepository
    {
        private readonly string _connectionString;
        public OrdersRepository(string connectionString)
        {
            _connectionString = connectionString;
        }
        public List<Order> GetOrders()
        {
            List<Order> orders = new List<Order>();

            using (OracleConnection connection = new OracleConnection(_connectionString))
            {
                connection.Open();

                using (OracleCommand command = new OracleCommand("GetOrdersAndUserData", connection))
                {
                    command.CommandType = CommandType.StoredProcedure;

                    // Создание выходного параметра курсора
                    OracleParameter ordersParameter = new OracleParameter
                    {
                        ParameterName = "orders_and_user_data",
                        Direction = ParameterDirection.Output,
                        OracleDbType = OracleDbType.RefCursor
                    };

                    // Добавление выходного параметра курсора в коллекцию параметров команды
                    command.Parameters.Add(ordersParameter);

                    using (OracleDataReader reader = command.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            // Создание объекта заказа на основе данных из строки выборки
                            Order order = new Order
                            {
                                OrderId = reader.GetInt32(reader.GetOrdinal("order_id")),
                                UserId = reader.GetInt32(reader.GetOrdinal("user_id")),
                                OrderDate = reader.GetDateTime(reader.GetOrdinal("order_date")),
                                DeliveryDate = reader.GetDateTime(reader.GetOrdinal("delivery_date")),
                                BookId = reader.GetInt32(reader.GetOrdinal("book_id")),
                                Quantity = reader.GetInt32(reader.GetOrdinal("quantity")),
                                Price = reader.GetDecimal(reader.GetOrdinal("price")),
                                AdminId = reader.GetInt32(reader.GetOrdinal("admin_id")),
                                UserFirstName = reader.GetString(reader.GetOrdinal("first_name")),
                                UserLastName = reader.GetString(reader.GetOrdinal("last_name")),
                                UserAdress = reader.GetString(reader.GetOrdinal("address")),
                                UserPhoneNumber = reader.GetString(reader.GetOrdinal("phone_number"))
                            };

                            orders.Add(order);
                        }
                    }
                }
            }

            return orders;
        }
        public List<Order> GetUserOrders(int userId)
        {
            List<Order> orders = new List<Order>();

            using (OracleConnection connection = new OracleConnection(_connectionString))
            {
                connection.Open();

                using (OracleCommand command = new OracleCommand("GetOrdersAndBookTitlesByUserId", connection))
                {
                    command.CommandType = CommandType.StoredProcedure;

                    command.Parameters.Add("p_user_id", OracleDbType.Int32).Value = userId;
                    command.Parameters.Add("p_orders", OracleDbType.RefCursor).Direction = ParameterDirection.Output;

                    using (OracleDataReader reader = command.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            Order order = new Order
                            {
                                OrderId = reader.GetInt32(0),
                                UserId = reader.GetInt32(1),
                                OrderDate = reader.GetDateTime(2),
                                DeliveryDate = reader.GetDateTime(3),
                                BookId = reader.GetInt32(4),
                                Quantity = reader.GetInt32(5),
                                Price = reader.GetDecimal(6),
                                AdminId = reader.GetInt32(7),
                                BookTitle = reader.GetString(8)
                            };

                            orders.Add(order);
                        }
                    }
                }
            }

            return orders;
        }
        public void DeleteOrder(int orderId)
        {
            using (OracleConnection connection = new OracleConnection(_connectionString))
            {
                connection.Open();

                using (OracleCommand command = new OracleCommand("DeleteOrderById", connection))
                {
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.Add("p_order_id", OracleDbType.Int32).Value = orderId;
                    command.ExecuteNonQuery();
                }
            }
        }
        public void EditAdminId(int orderId, int adminId)
        {
            using (OracleConnection connection = new OracleConnection(_connectionString))
            {
                connection.Open();

                using (OracleCommand command = new OracleCommand("EditAdminId", connection))
                {
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.Add("p_order_id", OracleDbType.Int32).Value = orderId;
                    command.Parameters.Add("p_admin_id", OracleDbType.Int32).Value = adminId;
                    command.ExecuteNonQuery();
                }
            }
        }
        public void AddOrder(Order order)
        {
            using (OracleConnection connection = new OracleConnection(_connectionString))
            {
                connection.Open();

                using (OracleCommand command = new OracleCommand("AddOrder", connection))
                {
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.Add("p_user_id", OracleDbType.Int32).Value = order.UserId;
                    command.Parameters.Add("p_order_date", OracleDbType.Date).Value = order.OrderDate;
                    command.Parameters.Add("p_delivery_date", OracleDbType.Date).Value = order.DeliveryDate;
                    command.Parameters.Add("p_book_id", OracleDbType.Int32).Value = order.BookId;
                    command.Parameters.Add("p_quantity", OracleDbType.Int32).Value = order.Quantity;
                    command.Parameters.Add("p_price", OracleDbType.Decimal).Value = order.Price;
                    command.Parameters.Add("p_admin_id", OracleDbType.Int32).Value = order.AdminId;

                    command.ExecuteNonQuery();
                }
            }
        }
    }

}
