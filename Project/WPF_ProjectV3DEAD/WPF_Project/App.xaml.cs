using Oracle.ManagedDataAccess.Client;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Media;

namespace WPF_Project
{
    /// <summary>
    /// Interaction logic for App.xaml
    /// </summary>
    public partial class App : Application
    {
        public Session Session { get; set; }
        protected override void OnStartup(StartupEventArgs e)
        {
            base.OnStartup(e);

            // Строка подключения к базе данных Oracle
            string connectionString = "Data Source=(DESCRIPTION=(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)(HOST=localhost)(PORT=1521)))(CONNECT_DATA=(SERVICE_NAME=PDB_Project)));User Id=admin_user;Password=admin_password;";
            string connectionStringUser = "Data Source=(DESCRIPTION=(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)(HOST=localhost)(PORT=1521)))(CONNECT_DATA=(SERVICE_NAME=PDB_Project)));User Id=limited_user;Password=user_password;";
            // Устанавливаем соединение с базой данных
            using (OracleConnection connection = new OracleConnection(connectionString))
            {
                // Открываем соединение
                connection.Open();

                // Выполняем команду ALTER SESSION для установки схемы "admin" как основной
                string alterSchemaCommand = "ALTER SESSION SET CURRENT_SCHEMA = admin";
                using (OracleCommand command = new OracleCommand(alterSchemaCommand, connection))
                {
                    command.ExecuteNonQuery();
                }

                // Закрываем соединение
                connection.Close();
            }
            using (OracleConnection connection = new OracleConnection(connectionStringUser))
            {
                // Открываем соединение
                connection.Open();

                // Выполняем команду ALTER SESSION для установки схемы "admin" как основной
                string alterSchemaCommand = "ALTER SESSION SET CURRENT_SCHEMA = admin";
                using (OracleCommand command = new OracleCommand(alterSchemaCommand, connection))
                {
                    command.ExecuteNonQuery();
                }

                // Закрываем соединение
                connection.Close();
            }

        }
    }
}
