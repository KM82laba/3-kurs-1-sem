using Oracle.ManagedDataAccess.Client;
using System;
using System.Collections.Generic;
using System.Data;
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
using Oracle.ManagedDataAccess.Types;
using Syncfusion.SfSkinManager;

namespace WPF_Project
{
    /// <summary>
    /// Логика взаимодействия для LoginWindow.xaml
    /// </summary>
    public partial class LoginWindow : Window
    {

        
        public LoginWindow()
        {
            
            InitializeComponent();
           
        }
        private void LanguageComboBox_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            
        }

        
        private void btnLogin_Click(object sender, RoutedEventArgs e)
        {

            string login = usernameTextBox.Text;
            string password = passwordTextBox.Password;

            OracleConnection conn = new OracleConnection();
            conn.ConnectionString = ConfigurationManager.ConnectionStrings["OracleConnectionAdmin"].ConnectionString;

            OracleCommand cmd = new OracleCommand("check_login", conn);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.Add("p_login", OracleDbType.Varchar2).Value = login;
            cmd.Parameters.Add("p_password", OracleDbType.Varchar2).Value = password;

            cmd.Parameters.Add("p_role", OracleDbType.Varchar2, 10).Direction = ParameterDirection.Output;
            cmd.Parameters.Add("p_id", OracleDbType.Int32).Direction = ParameterDirection.Output;
            cmd.Parameters.Add("p_email", OracleDbType.Varchar2, 100).Direction = ParameterDirection.Output;

            conn.Open();
            cmd.ExecuteNonQuery();

            string role = cmd.Parameters["p_role"].Value.ToString();

            if (role == "user")
            {
                
                int id = ((OracleDecimal)cmd.Parameters["p_id"].Value).ToInt32();
                string email = cmd.Parameters["p_email"].Value.ToString();
                string connstr = "Data Source=(DESCRIPTION=(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)(HOST=localhost)(PORT=1521)))(CONNECT_DATA=(SERVICE_NAME=PDB_Project)));User Id=limited_user;Password=user_password;";
                var session = new Session(id, email, role, connstr);
                ((App)Application.Current).Session = session;
                // Создание нового окна WPF для пользователя
                ClientWindow clientForm = new ClientWindow();
                clientForm.Show();
                this.Close();
            }
            else if (role == "admin")
            {
                
                int id = ((OracleDecimal)cmd.Parameters["p_id"].Value).ToInt32();
                string email = cmd.Parameters["p_email"].Value.ToString();
                string connstr = "Data Source=(DESCRIPTION=(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)(HOST=localhost)(PORT=1521)))(CONNECT_DATA=(SERVICE_NAME=PDB_Project)));User Id=admin_user;Password=admin_password;";
                var session = new Session(id, email, role , connstr);
                ((App)Application.Current).Session = session;
                // Создание нового окна WPF для администратора
                ChooseAdminWindow chooseAdminWindow = new ChooseAdminWindow();
                chooseAdminWindow.Show();
                this.Close();
            }
            else
            {
                MessageBox.Show("Неверный логин или пароль");
            }

            conn.Close();
        }
        /* var adminForm = new AdminWindow();
                adminForm.Show();
                this.Close();*/
        /*var clientForm = new ClientWindow();
                clientForm.Show();
                this.Close();*/
        private void btnRegistration_Click(object sender, RoutedEventArgs e)
        {
            // Создание и открытие нового окна регистрации
            RegisterWindow registerWindow = new RegisterWindow();
            registerWindow.Show();
            this.Close();
        }
        
    }
}
