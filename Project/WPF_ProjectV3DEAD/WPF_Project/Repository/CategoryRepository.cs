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
    class CategoryRepository
    {
        private readonly string _connectionString;
        public CategoryRepository(string connectionString)
        {
            _connectionString = connectionString;
        }

        public DataTable GetAllCategories()
        {
            using (var connection = new OracleConnection(_connectionString))
            {
                connection.Open();
                using (var command = connection.CreateCommand())
                {
                    command.CommandType = CommandType.StoredProcedure;
                    command.CommandText = "GET_ALL_CATEGORIES";
                    command.Parameters.Add(new OracleParameter("p_categories", OracleDbType.RefCursor, ParameterDirection.Output));

                    using (var adapter = new OracleDataAdapter(command))
                    {
                        var dataTable = new DataTable();
                        adapter.Fill(dataTable);
                        return dataTable;
                    }
                }
            }
        }

        public List<Category> GetCategoryForBook(int bookId)
        {
            List<Category> categories = new List<Category>();

            using (var connection = new OracleConnection(_connectionString))
            {
                connection.Open();

                using (var command = connection.CreateCommand())
                {
                    command.CommandType = CommandType.StoredProcedure;
                    command.CommandText = "Get_Category_For_Book";

                    command.Parameters.Add(new OracleParameter("p_book_id", OracleDbType.Int32)).Value = bookId;
                    command.Parameters.Add(new OracleParameter("p_categories", OracleDbType.RefCursor)).Direction = ParameterDirection.Output;

                    using (var reader = command.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            Category category = new Category()
                            {
                                CategoryId = reader.GetInt32(0),
                                CategoryName = reader.GetString(1)
                            };
                            categories.Add(category);
                        }
                    }
                }
            }

            return categories;
        }
        public void AddCategory(Category category)
        {
            using (OracleConnection connection = new OracleConnection(_connectionString))
            {
                using (OracleCommand command = new OracleCommand("ADD_CATEGORY", connection))
                {
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.Add("p_category_name", OracleDbType.Varchar2).Value = category.CategoryName;
                    connection.Open();
                    command.ExecuteNonQuery();
                }
            }
        }
        public int GetNextCategoryId()
        {
            using (OracleConnection connection = new OracleConnection(_connectionString))
            {
                using (OracleCommand command = new OracleCommand("GET_NEXT_CATEGORY_ID", connection))
                {
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.Add("p_category_id", OracleDbType.Int32).Direction = ParameterDirection.Output;

                    connection.Open();
                    command.ExecuteNonQuery();

                    OracleDecimal categoryIdDecimal = (OracleDecimal)command.Parameters["p_category_id"].Value;
                    return categoryIdDecimal.ToInt32();
                }
            }
        }
        public void UpdateCategory(Category category)
        {
            using (OracleConnection connection = new OracleConnection(_connectionString))
            {
                using (OracleCommand command = new OracleCommand("Update_Category", connection))
                {
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.Add("p_category_id", OracleDbType.Int32).Value = category.CategoryId;
                    command.Parameters.Add("p_category_name", OracleDbType.Varchar2).Value = category.CategoryName;

                    connection.Open();
                    command.ExecuteNonQuery();

                }
            }
        }

        public void DeleteCategory(Category category)
        {

            using (OracleConnection connection = new OracleConnection(_connectionString))
            {
                using (OracleCommand command = new OracleCommand("Delete_Category", connection))
                {
                    command.CommandType = CommandType.StoredProcedure;

                    command.Parameters.Add("p_category_id", OracleDbType.Int32).Value = category.CategoryId;

                    connection.Open();
                    command.ExecuteNonQuery();

                }
            }

        }


    }
}

