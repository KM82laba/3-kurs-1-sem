using Oracle.ManagedDataAccess.Client;
using Oracle.ManagedDataAccess.Types;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using WPF_Project.ViewModel;

namespace WPF_Project.Repository
{
    internal class PublishersRepository
    {
        private readonly string _connectionString;
        public PublishersRepository(string connectionString)
        {
            _connectionString = connectionString;
        }

        public DataTable GetAllPublishers()
        {
            using (OracleConnection connection = new OracleConnection(_connectionString))
            {
                connection.Open();

                OracleCommand command = connection.CreateCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = "GET_ALL_PUBLISHERS";

                OracleParameter cursorParameter = command.Parameters.Add("p_cursor", OracleDbType.RefCursor);
                cursorParameter.Direction = ParameterDirection.Output;

                using (var adapter = new OracleDataAdapter(command))
                {
                    var dataTable = new DataTable();
                    adapter.Fill(dataTable);
                    return dataTable;
                }
            }
        }

        public void AddPublisher(Publisher publisher)
        {
            using (OracleConnection connection = new OracleConnection(_connectionString))
            {
                using (OracleCommand command = new OracleCommand("ADD_PUBLISHER", connection))
                {
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.Add(new OracleParameter("p_publisher_name", publisher.PublisherName));

                    connection.Open();
                    command.ExecuteNonQuery();
                }
            }
        }
        public int GetNextPublisherId()
        {
            int PublishenextId = 0;
            using (OracleConnection connection = new OracleConnection(_connectionString))
            {
                connection.Open();
                using (OracleCommand command = new OracleCommand("GET_NEXT_PUBLISHER_ID", connection))
                {
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.Add("p_next_id", OracleDbType.Int32, ParameterDirection.Output);
                    command.ExecuteNonQuery();
                    OracleDecimal PublishenextIdDecimal = (OracleDecimal)command.Parameters["p_next_id"].Value;
                    PublishenextId = PublishenextIdDecimal.ToInt32();
                }
            }
            return PublishenextId;
        }
        public void UpdatePublisher(Publisher publisher)
        {
            string query = "UPDATE Publishers SET publisher_name = :publisher_name WHERE publisher_id = :publisher_id";

            using (OracleConnection connection = new OracleConnection(_connectionString))
            {
                using (OracleCommand command = new OracleCommand(query, connection))
                {
                    command.Parameters.Add(":publisher_name", OracleDbType.Varchar2).Value = publisher.PublisherName;
                    command.Parameters.Add(":publisher_id", OracleDbType.Int32).Value = publisher.PublisherId;

                    connection.Open();
                    command.ExecuteNonQuery();
                }
            }
        }

        public void DeletePublisher(Publisher publisher)
        {
            try
            {
                using (OracleConnection connection = new OracleConnection(_connectionString))
                {
                    using (OracleCommand command = new OracleCommand("DELETE_PUBLISHER", connection))
                    {
                        command.CommandType = CommandType.StoredProcedure;
                        command.Parameters.Add("p_publisher_id", OracleDbType.Int32).Value = publisher.PublisherId;

                        connection.Open();
                        command.ExecuteNonQuery();
                    }
                }
            }
            catch (OracleException ex)
            {
                if (ex.Number == 20003)
                {
                    MessageBox.Show(ex.Message);
                }
                else
                {
                    MessageBox.Show("Ошибка при удалении издателя: " + ex.Message);
                }
            }
        }

    }
}
