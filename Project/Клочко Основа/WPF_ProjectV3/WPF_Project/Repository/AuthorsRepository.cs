using Oracle.ManagedDataAccess.Client;
using Oracle.ManagedDataAccess.Types;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;

namespace WPF_Project
{
    class AuthorsRepository
    {
        private readonly string _connectionString;
        public AuthorsRepository(string connectionString)
        {
            _connectionString = connectionString;
        }

        public DataTable GetAllAuthors()
        {
            DataTable dt = new DataTable();

            using (OracleConnection connection = new OracleConnection(_connectionString))
            {
                connection.Open();

                using (OracleCommand command = connection.CreateCommand())
                {
                    command.CommandType = CommandType.StoredProcedure;
                    command.CommandText = "GET_ALL_AUTHORS";
                    command.Parameters.Add("p_cursor", OracleDbType.RefCursor, ParameterDirection.Output);

                    using (OracleDataReader reader = command.ExecuteReader())
                    {
                        dt.Load(reader);
                    }
                }
            }

            return dt;
        }
        public List<Author> GetAuthorsForBook(int bookId)
        {
            List<Author> authors = new List<Author>();

            using (var connection = new OracleConnection(_connectionString))
            {
                connection.Open();
                using (var command = connection.CreateCommand())
                {
                    command.CommandType = CommandType.StoredProcedure;
                    command.CommandText = "Get_Authors_For_Book";
                    command.Parameters.Add(new OracleParameter("p_bookId", bookId));
                    var p_authors = new OracleParameter("p_authors", OracleDbType.RefCursor);
                    p_authors.Direction = ParameterDirection.Output;
                    command.Parameters.Add(p_authors);
                    using (var reader = command.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            Author author = new Author()
                            {
                                AuthorId = reader.GetInt32(0),
                                AuthorName = reader.GetString(1)
                            };
                            authors.Add(author);
                        }
                    }
                }
            }
            return authors;
        }
        public void AddAuthor(Author author)
        {
            using (OracleConnection connection = new OracleConnection(_connectionString))
            {
                using (OracleCommand command = new OracleCommand("ADD_AUTHOR", connection))
                {
                    command.CommandType = CommandType.StoredProcedure;

                    command.Parameters.Add("p_author_name", OracleDbType.Varchar2).Value = author.AuthorName;

                    connection.Open();
                    command.ExecuteNonQuery();
                }
            }
        }
        public int GetNextAuthorId()
        {
            int authorId = 0;
            using (OracleConnection connection = new OracleConnection(_connectionString))
            {
                using (OracleCommand command = new OracleCommand("Get_Next_Author_Id", connection))
                {
                    connection.Open();
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.Add("p_author_id", OracleDbType.Int32).Direction = ParameterDirection.Output;
                    command.ExecuteNonQuery();
                    OracleDecimal authorIdDecimal = (OracleDecimal)command.Parameters["p_author_id"].Value;
                    authorId = authorIdDecimal.ToInt32();
                }
            }
            return authorId;
        }
        public bool UpdateAuthor(Author author)
        {
            using (OracleConnection connection = new OracleConnection(_connectionString))
            {
                using (OracleCommand command = new OracleCommand("UPDATE_AUTHOR_PROCEDURE", connection))
                {
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.Add("p_author_name", OracleDbType.Varchar2).Value = author.AuthorName;
                    command.Parameters.Add("p_author_id", OracleDbType.Int32).Value = author.AuthorId;

                    connection.Open();
                    int rowsAffected = command.ExecuteNonQuery();
                    if (rowsAffected > 0)
                    {
                        return true;
                    }
                    else
                    {
                        return false;
                    }
                }
            }
        }

        public void DeleteAuthor(Author author)
        {
            using (OracleConnection connection = new OracleConnection(_connectionString))
            {
                using (OracleCommand command = new OracleCommand("DELETE_AUTHOR", connection))
                {
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.Add("p_author_id", OracleDbType.Int32).Value = author.AuthorId;

                    connection.Open();
                    command.ExecuteNonQuery();
                }
            }
        }

    }
}
