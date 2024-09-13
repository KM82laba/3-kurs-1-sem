using Oracle.ManagedDataAccess.Client;
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
using System.Configuration;
using System.Data;
using Oracle.ManagedDataAccess.Types;

namespace WPF_Project
{
    /// <summary>
    /// Логика взаимодействия для RegisterWindow.xaml
    /// </summary>
    public partial class RegisterWindow : Window
    {
        
        public RegisterWindow()
        {
            InitializeComponent();
        }


        private void addUserButton_Click(object sender, RoutedEventArgs e)
        {
            // Получение значений полей ввода из текстовых полей
            string email = emailTextBox.Text;
            string password = passwordTextBox.Password;
            string firstName = firstNameTextBox.Text;
            string lastName = lastNameTextBox.Text;
            string address = addressTextBox.Text;
            string phoneNumber = phoneNumberTextBox.Text;
            if (passwordTextBox.Password != confirmpasswordTextBox.Password)
            {
                MessageBox.Show("Пароли должни совпадать!");
            }
            else if (email != "" && password != "" && firstName != "" && lastName != "" && address != "" && phoneNumber != "")
            {
                // Создание подключения к базе данных Oracle
                OracleConnection conn = new OracleConnection();
                conn.ConnectionString = ConfigurationManager.ConnectionStrings["OracleConnectionAdmin"].ConnectionString;

                try
                {
                    // Открытие соединения с базой данных Oracle
                    conn.Open();

                    // Создание команды для вызова процедуры ADD_USER_PROC
                    OracleCommand cmd = new OracleCommand();
                    cmd.Connection = conn;
                    cmd.CommandText = "ADD_USER_PROC";
                    cmd.CommandType = CommandType.StoredProcedure;

                    // Заполнение параметров команды значениями полей ввода
                    cmd.Parameters.Add("p_email", OracleDbType.Varchar2).Value = email;
                    cmd.Parameters.Add("p_password", OracleDbType.Varchar2).Value = password;
                    cmd.Parameters.Add("p_first_name", OracleDbType.Varchar2).Value = firstName;
                    cmd.Parameters.Add("p_last_name", OracleDbType.Varchar2).Value = lastName;
                    cmd.Parameters.Add("p_address", OracleDbType.Varchar2).Value = address;
                    cmd.Parameters.Add("p_phone_number", OracleDbType.Varchar2).Value = phoneNumber;

                    // Установка выходного параметра для получения идентификатора пользователя
                    OracleParameter resultParam = new OracleParameter("p_result", OracleDbType.Int32);
                    resultParam.Direction = ParameterDirection.Output;
                    cmd.Parameters.Add(resultParam);

                    // Выполнение команды вызова процедуры ADD_USER_PROC
                    cmd.ExecuteNonQuery();

                    // Получение идентификатора пользователя из выходного параметра
                    int userId = resultParam.Value == null ? 0 : ((OracleDecimal)resultParam.Value).ToInt32();
                    // Если идентификатор пользователя равен нулю, значит пользователь уже существует
                    if (userId == 0)
                    {
                        MessageBox.Show("Пользователь с таким email уже существует в базе данных!");
                    }
                    else
                    {
                        MessageBox.Show("Пользователь успешно добавлен в базу данных!");
                    }
                }
                catch (Exception ex)
                {
                    MessageBox.Show("Ошибка: " + ex.Message);
                }
                finally
                {
                    // Закрытие соединения с базой данных Oracle
                    conn.Close();
                    LoginWindow loginWindow = new LoginWindow();
                    loginWindow.Show();
                    this.Close();
                }
            }
            else
            {
                MessageBox.Show("Все данные должны быть введены!");
            }
        }
        private void btnOut_Click(object sender, RoutedEventArgs e)
        {
            LoginWindow loginWindow = new LoginWindow();
            loginWindow.Show();
            this.Close();
        }
        private int GetNextUserId()
        {
            // Создание подключения к базе данных Oracle
            OracleConnection conn = new OracleConnection();
            conn.ConnectionString = ConfigurationManager.ConnectionStrings["OracleConnectionAdmin"].ConnectionString;

            
            // Открытие соединения с базой данных Oracle
            conn.Open();

            // Создание команды для получения максимального значения user_id
            OracleCommand cmd = new OracleCommand();
            cmd.Connection = conn;
            cmd.CommandText = "SELECT MAX(user_id) FROM Users";

            // Выполнение запроса к базе данных Oracle и получение результата
            int maxUserId = Convert.ToInt32(cmd.ExecuteScalar());

            // Закрытие соединения с базой данных Oracle
            conn.Close();

            // Генерация уникального идентификатора пользователя
            return maxUserId + 1;
        }
    }
}
