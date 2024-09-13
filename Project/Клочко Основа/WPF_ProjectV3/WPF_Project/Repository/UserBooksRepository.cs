using Oracle.ManagedDataAccess.Client;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Data.Common;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;

namespace WPF_Project
{
    class UserBooksRepository
    {
        private readonly string _connectionString;
        public UserBooksRepository(string connectionString)
        {
            _connectionString = connectionString;
        }
        public void LoadUserBooks(ObservableCollection<UserBook> userBooks, int book_id)
        {
            int userId = ((App)Application.Current).Session.UserId;
            string query = "SELECT * FROM UserBooks WHERE user_id = :userId AND book_id = :book_id";
            using (OracleConnection connection = new OracleConnection(_connectionString))
            {
                connection.Open();
                OracleCommand cmd = new OracleCommand(query, connection);

                cmd.Parameters.Add(new OracleParameter("userId", userId));
                cmd.Parameters.Add(new OracleParameter("book_id", book_id));
                OracleDataReader reader = cmd.ExecuteReader();

                // Проверяем количество строк в запросе
                if (reader.HasRows)
                {
                    while (reader.Read())
                    {
                        UserBook userBook = new UserBook()
                        {
                            UserId = userId,
                            BookId = book_id,
                            Status = (string)reader["status"]
                        };
                        userBooks.Add(userBook);
                    }
                }
                else
                {
                    // Если запрос не вернул ни одной строки, добавляем новый объект UserBook
                    string Status = "Выбрать статус книги";
                    UserBook userBook = new UserBook()
                    {
                        UserId = userId,
                        BookId = book_id,
                        Status = Status
                    };
                    userBooks.Add(userBook);

                    // Выполняем INSERT в базу данных
                    
                    string insertQuery = "INSERT INTO UserBooks(user_id, book_id, status) VALUES (:userId, :book_id, :status)";
                    OracleCommand insertCmd = new OracleCommand(insertQuery, connection);
                    insertCmd.Parameters.Add(new OracleParameter("userId", userId));
                    insertCmd.Parameters.Add(new OracleParameter("book_id", book_id));
                    insertCmd.Parameters.Add(new OracleParameter("status", Status));
                    insertCmd.ExecuteNonQuery();
                }
            }
        }

        public void UpdateUserBookStatus(string Status , int BookId)
        {
            int userId = ((App)Application.Current).Session.UserId;
            using (OracleConnection connection = new OracleConnection(_connectionString))
            {
                connection.Open();
                string query = "UPDATE UserBooks SET status = :status WHERE user_id = :userId AND book_id = :bookId";
                OracleCommand cmd = new OracleCommand(query, connection);
                cmd.Parameters.Add(new OracleParameter(":status", Status));
                cmd.Parameters.Add(new OracleParameter(":userId", userId));
                cmd.Parameters.Add(new OracleParameter(":bookId", BookId));
                int rowsUpdated = cmd.ExecuteNonQuery();
            }
        }
        public List<BookWithStatus> GetUserBooksWithStatus(int userId)
        {
            List<BookWithStatus> userBooks = new List<BookWithStatus>();

            using (OracleConnection connection = new OracleConnection(_connectionString))
            {
                connection.Open();

                // Запрос на выборку книг и статусов, которые относятся к заданному пользователю
                string query = "SELECT Books.book_id, Books.title, UserBooks.Status " +
                               "FROM Books " +
                               "INNER JOIN UserBooks ON Books.book_id = UserBooks.book_id " +
                               "WHERE UserBooks.user_id = :user_id";

                using (OracleCommand command = new OracleCommand(query, connection))
                {
                    command.Parameters.Add("user_id", OracleDbType.Int32).Value = userId;
                    using (OracleDataReader reader = command.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            // Создание объекта UserBookWithBook на основе данных из строки выборки
                            BookWithStatus userBook = new BookWithStatus
                            {
                                BookId = reader.GetInt32(0),
                                BookName = reader.GetString(1),
                                Status = reader.GetString(2)
                            };

                            userBooks.Add(userBook);
                        }
                    }
                }
            }

            return userBooks;
        }
    }
}
