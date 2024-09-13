using Oracle.ManagedDataAccess.Client;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Net;
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
    /// Логика взаимодействия для UserInfo.xaml
    /// </summary>
    public partial class UserInfo : Window
    {   private string connectionString = ((App)Application.Current).Session.Conn;
        int userId = ((App)Application.Current).Session.UserId;
        public UserInfo()
        {
            InitializeComponent();
            

            using (OracleConnection connection = new OracleConnection(connectionString))
            {
                connection.Open();

                OracleCommand command = new OracleCommand("GetUser", connection);
                command.CommandType = CommandType.StoredProcedure;

                command.Parameters.Add("p_user_id", OracleDbType.Int32).Value = userId;
                command.Parameters.Add("o_first_name", OracleDbType.Varchar2, 255).Direction = ParameterDirection.Output;
                command.Parameters.Add("o_last_name", OracleDbType.Varchar2, 255).Direction = ParameterDirection.Output;
                command.Parameters.Add("o_address", OracleDbType.Varchar2, 255).Direction = ParameterDirection.Output;
                command.Parameters.Add("o_phone_number", OracleDbType.Varchar2, 255).Direction = ParameterDirection.Output;

                command.ExecuteNonQuery();

                
                firstNameTextBox.Text = command.Parameters["o_first_name"].Value.ToString();
                lastNameTextBox.Text = command.Parameters["o_last_name"].Value.ToString();
                addressTextBox.Text = command.Parameters["o_address"].Value.ToString();
                phoneNumberTextBox.Text = command.Parameters["o_phone_number"].Value.ToString();
            }
        }

        
        private void UpdateUserButton_Click(object sender, RoutedEventArgs e)
        {
            string firstName = firstNameTextBox.Text;
            string lastName = lastNameTextBox.Text;
            string address = addressTextBox.Text;
            string phoneNumber = phoneNumberTextBox.Text;
            using (OracleConnection connection = new OracleConnection(connectionString))
            {
                connection.Open();

                using (OracleCommand command = new OracleCommand("UpdateUser", connection))
                {
                    command.CommandType = CommandType.StoredProcedure;

                    command.Parameters.Add("p_user_id", OracleDbType.Int32).Value = userId;
                    command.Parameters.Add("p_first_name", OracleDbType.Varchar2).Value = firstName;
                    command.Parameters.Add("p_last_name", OracleDbType.Varchar2).Value = lastName;
                    command.Parameters.Add("p_address", OracleDbType.Varchar2).Value = address;
                    command.Parameters.Add("p_phone_number", OracleDbType.Varchar2).Value = phoneNumber;

                    command.ExecuteNonQuery();
                }
            }
            this.Close();
        }
    }
}
