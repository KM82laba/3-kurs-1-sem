using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Oracle.ManagedDataAccess.Client;
using System.Collections.ObjectModel;
using System.Transactions;
using System.Data.Common;
using System.Windows;
using System.Configuration;
using System.Net;
using System.Data;
using Oracle.ManagedDataAccess.Types;


namespace WPF_Project
{

    public class BooksRepository
    {
        private string _connectionString = ((App)Application.Current).Session.Conn;
        private int GetBookIds;
        public void LoadBooks(ObservableCollection<Book> books)
        {
            using (OracleConnection connection = new OracleConnection(_connectionString))
            {
                connection.Open();

                OracleCommand command = new OracleCommand();
                command.Connection = connection;
                command.CommandText = "LoadBooksProc";
                command.CommandType = CommandType.StoredProcedure;

                // Установка параметра курсора для получения результата
                OracleParameter booksParam = new OracleParameter();
                booksParam.ParameterName = "books";
                booksParam.OracleDbType = OracleDbType.RefCursor;
                booksParam.Direction = ParameterDirection.Output;
                command.Parameters.Add(booksParam);

                OracleDataReader reader = command.ExecuteReader();
                while (reader.Read())
                {
                    Book book = new Book()
                    {
                        BookId = reader.GetInt32(reader.GetOrdinal("book_id")),
                        Title = reader.GetString(reader.GetOrdinal("title")),
                        Description = reader.GetString(reader.GetOrdinal("description")),
                        Price = reader.GetDecimal(reader.GetOrdinal("price")),
                        YearPublished = reader.GetDateTime(reader.GetOrdinal("year_published")),
                        CoverImage = (byte[])reader["cover_image"],
                        PublisherId = reader.GetInt32(reader.GetOrdinal("publisher_id")),
                        AdminId = reader.GetInt32(reader.GetOrdinal("admin_id")),
                        Content = (byte[])reader["content"],
                        Quantity = reader.GetInt32(reader.GetOrdinal("quantity"))
                    };
                    books.Add(book);
                }
            }
        }
        public void SortTitleDesc(ObservableCollection<Book> books)
        {
            using (OracleConnection connection = new OracleConnection(_connectionString))
            {
                connection.Open();

                OracleCommand command = new OracleCommand();
                command.Connection = connection;
                command.CommandText = "LoadBooksProcTitleDesc";
                command.CommandType = CommandType.StoredProcedure;

                // Установка параметра курсора для получения результата
                OracleParameter booksParam = new OracleParameter();
                booksParam.ParameterName = "books";
                booksParam.OracleDbType = OracleDbType.RefCursor;
                booksParam.Direction = ParameterDirection.Output;
                command.Parameters.Add(booksParam);

                OracleDataReader reader = command.ExecuteReader();
                while (reader.Read())
                {
                    Book book = new Book()
                    {
                        BookId = reader.GetInt32(reader.GetOrdinal("book_id")),
                        Title = reader.GetString(reader.GetOrdinal("title")),
                        Description = reader.GetString(reader.GetOrdinal("description")),
                        Price = reader.GetDecimal(reader.GetOrdinal("price")),
                        YearPublished = reader.GetDateTime(reader.GetOrdinal("year_published")),
                        CoverImage = (byte[])reader["cover_image"],
                        PublisherId = reader.GetInt32(reader.GetOrdinal("publisher_id")),
                        AdminId = reader.GetInt32(reader.GetOrdinal("admin_id")),
                        Content = (byte[])reader["content"],
                        Quantity = reader.GetInt32(reader.GetOrdinal("quantity"))
                    };
                    books.Add(book);
                }
            }
        }
        public void SortTitleAsc(ObservableCollection<Book> books)
        {
            using (OracleConnection connection = new OracleConnection(_connectionString))
            {
                connection.Open();

                OracleCommand command = new OracleCommand();
                command.Connection = connection;
                command.CommandText = "LoadBooksProcTitleAsc";
                command.CommandType = CommandType.StoredProcedure;

                // Установка параметра курсора для получения результата
                OracleParameter booksParam = new OracleParameter();
                booksParam.ParameterName = "books";
                booksParam.OracleDbType = OracleDbType.RefCursor;
                booksParam.Direction = ParameterDirection.Output;
                command.Parameters.Add(booksParam);

                OracleDataReader reader = command.ExecuteReader();
                while (reader.Read())
                {
                    Book book = new Book()
                    {
                        BookId = reader.GetInt32(reader.GetOrdinal("book_id")),
                        Title = reader.GetString(reader.GetOrdinal("title")),
                        Description = reader.GetString(reader.GetOrdinal("description")),
                        Price = reader.GetDecimal(reader.GetOrdinal("price")),
                        YearPublished = reader.GetDateTime(reader.GetOrdinal("year_published")),
                        CoverImage = (byte[])reader["cover_image"],
                        PublisherId = reader.GetInt32(reader.GetOrdinal("publisher_id")),
                        AdminId = reader.GetInt32(reader.GetOrdinal("admin_id")),
                        Content = (byte[])reader["content"],
                        Quantity = reader.GetInt32(reader.GetOrdinal("quantity"))
                    };
                    books.Add(book);
                }
            }
        }
        public void SortPriceDesc(ObservableCollection<Book> books)
        {
            using (OracleConnection connection = new OracleConnection(_connectionString))
            {
                connection.Open();

                OracleCommand command = new OracleCommand();
                command.Connection = connection;
                command.CommandText = "LoadBooksProcPriceDesc";
                command.CommandType = CommandType.StoredProcedure;

                // Установка параметра курсора для получения результата
                OracleParameter booksParam = new OracleParameter();
                booksParam.ParameterName = "books";
                booksParam.OracleDbType = OracleDbType.RefCursor;
                booksParam.Direction = ParameterDirection.Output;
                command.Parameters.Add(booksParam);

                OracleDataReader reader = command.ExecuteReader();
                while (reader.Read())
                {
                    Book book = new Book()
                    {
                        BookId = reader.GetInt32(reader.GetOrdinal("book_id")),
                        Title = reader.GetString(reader.GetOrdinal("title")),
                        Description = reader.GetString(reader.GetOrdinal("description")),
                        Price = reader.GetDecimal(reader.GetOrdinal("price")),
                        YearPublished = reader.GetDateTime(reader.GetOrdinal("year_published")),
                        CoverImage = (byte[])reader["cover_image"],
                        PublisherId = reader.GetInt32(reader.GetOrdinal("publisher_id")),
                        AdminId = reader.GetInt32(reader.GetOrdinal("admin_id")),
                        Content = (byte[])reader["content"],
                        Quantity = reader.GetInt32(reader.GetOrdinal("quantity"))
                    };
                    books.Add(book);
                }
            }
        }
        public void SortPriceAsc(ObservableCollection<Book> books)
        {
            using (OracleConnection connection = new OracleConnection(_connectionString))
            {
                connection.Open();

                OracleCommand command = new OracleCommand();
                command.Connection = connection;
                command.CommandText = "LoadBooksProcPriceAsc";
                command.CommandType = CommandType.StoredProcedure;

                // Установка параметра курсора для получения результата
                OracleParameter booksParam = new OracleParameter();
                booksParam.ParameterName = "books";
                booksParam.OracleDbType = OracleDbType.RefCursor;
                booksParam.Direction = ParameterDirection.Output;
                command.Parameters.Add(booksParam);

                OracleDataReader reader = command.ExecuteReader();
                while (reader.Read())
                {
                    Book book = new Book()
                    {
                        BookId = reader.GetInt32(reader.GetOrdinal("book_id")),
                        Title = reader.GetString(reader.GetOrdinal("title")),
                        Description = reader.GetString(reader.GetOrdinal("description")),
                        Price = reader.GetDecimal(reader.GetOrdinal("price")),
                        YearPublished = reader.GetDateTime(reader.GetOrdinal("year_published")),
                        CoverImage = (byte[])reader["cover_image"],
                        PublisherId = reader.GetInt32(reader.GetOrdinal("publisher_id")),
                        AdminId = reader.GetInt32(reader.GetOrdinal("admin_id")),
                        Content = (byte[])reader["content"],
                        Quantity = reader.GetInt32(reader.GetOrdinal("quantity"))
                    };
                    books.Add(book);
                }
            }
        }
        public void SearchBooks(string searchText, ObservableCollection<Book> books)
        {
            using (OracleConnection connection = new OracleConnection(_connectionString))
            {
                connection.Open();

                using (OracleCommand command = connection.CreateCommand())
                {
                    command.CommandType = CommandType.StoredProcedure;
                    command.CommandText = "Search_Books";
                    command.Parameters.Add(new OracleParameter("p_search_text", searchText));
                    command.Parameters.Add(new OracleParameter("p_books", OracleDbType.RefCursor, ParameterDirection.Output));

                    using (OracleDataReader reader = command.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            Book book = new Book()
                            {
                                BookId = reader.GetInt32(reader.GetOrdinal("book_id")),
                                Title = reader.GetString(reader.GetOrdinal("title")),
                                Description = reader.GetString(reader.GetOrdinal("description")),
                                Price = reader.GetDecimal(reader.GetOrdinal("price")),
                                YearPublished = reader.GetDateTime(reader.GetOrdinal("year_published")),
                                CoverImage = (byte[])reader["cover_image"],
                                PublisherId = reader.GetInt32(reader.GetOrdinal("publisher_id")),
                                AdminId = reader.GetInt32(reader.GetOrdinal("admin_id")),
                                Quantity = reader.GetInt32(reader.GetOrdinal("quantity")),
                                Content = (byte[])reader["content"]
                                // Добавьте остальные поля книги, если необходимо
                            };

                            books.Add(book);
                        }
                    }
                }
            }
        }

        public void AddBook(Book book)
        {
            using (var connection = new OracleConnection(_connectionString))
            {
                connection.Open();

                using (var command = connection.CreateCommand())
                {
                    command.CommandType = CommandType.StoredProcedure;
                    command.CommandText = "Add_Book";
                    command.Parameters.Add(new OracleParameter("p_title", book.Title));
                    command.Parameters.Add(new OracleParameter("p_description", book.Description));
                    command.Parameters.Add(new OracleParameter("p_price", book.Price));
                    command.Parameters.Add(new OracleParameter("p_year_published", book.YearPublished));
                    command.Parameters.Add("p_cover_image", OracleDbType.Blob).Value = book.CoverImage;
                    command.Parameters.Add(new OracleParameter("p_publisher_id", book.PublisherId));
                    command.Parameters.Add(new OracleParameter("p_admin_id", book.AdminId));
                    command.Parameters.Add("p_content", OracleDbType.Blob).Value = book.Content;
                    command.Parameters.Add(new OracleParameter("p_quantity", book.Quantity));  // Добавлен новый параметр для quantity
                    var bookIdParameter = new OracleParameter("p_book_id", OracleDbType.Int32);
                    bookIdParameter.Direction = ParameterDirection.Output;
                    command.Parameters.Add(bookIdParameter);

                    command.ExecuteNonQuery();

                    // Retrieve the value of the output parameter
                    GetBookIds = bookIdParameter.Value == DBNull.Value ? 0 : ((OracleDecimal)bookIdParameter.Value).ToInt32();
                }
            }
        }
        public void UpdateBook(Book book)
        {
            using (var connection = new OracleConnection(_connectionString))
            {
                connection.Open();

                using (var command = connection.CreateCommand())
                {
                    command.CommandType = CommandType.StoredProcedure;
                    command.CommandText = "Update_Book";
                    command.Parameters.Add("p_book_id", OracleDbType.Int32).Value = book.BookId;
                    command.Parameters.Add("p_title", OracleDbType.Varchar2).Value = book.Title;
                    command.Parameters.Add("p_description", OracleDbType.Varchar2).Value = book.Description;
                    command.Parameters.Add("p_price", OracleDbType.Decimal).Value = book.Price;
                    command.Parameters.Add("p_year_published", OracleDbType.Date).Value = book.YearPublished;
                    command.Parameters.Add("p_cover_image", OracleDbType.Blob).Value = book.CoverImage;
                    command.Parameters.Add("p_publisher_id", OracleDbType.Int32).Value = book.PublisherId;
                    command.Parameters.Add("p_admin_id", OracleDbType.Int32).Value = book.AdminId;
                    command.Parameters.Add("p_content", OracleDbType.Blob).Value = book.Content;
                    command.Parameters.Add("p_quantity", OracleDbType.Int32).Value = book.Quantity;  // Добавлен новый параметр для quantity
                    command.ExecuteNonQuery();
                }
            }
        }

        public void AddAuthorBook(AuthorBook authorBook)
        {
            using (var connection = new OracleConnection(_connectionString))
            {
                connection.Open();


                using (var command = connection.CreateCommand())
                {
                    
                    // Добавляем автора к книге в таблицу Authors_Books
                    command.CommandType = CommandType.StoredProcedure;
                    command.CommandText = "ADD_AUTHOR_BOOK";
                    command.Parameters.Clear();
                    command.Parameters.Add(new OracleParameter("p_book_id", GetBookIds));
                    command.Parameters.Add(new OracleParameter("p_author_id", authorBook.AuthorId));
                    command.ExecuteNonQuery();
                }


            }

        }
        public void UpdateAuthorBook(int bookId, List<int> authorIds)
        {
            using (var connection = new OracleConnection(_connectionString))
            {
                connection.Open();

                using (var transaction = connection.BeginTransaction())
                {
                    try
                    {
                        // Удаляем всех авторов, связанных с книгой
                        using (var command = connection.CreateCommand())
                        {
                            command.CommandType = CommandType.StoredProcedure;
                            command.CommandText = "DeleteAuthorsForBook";
                            
                            command.Parameters.Add("p_bookId", OracleDbType.Int32).Value = bookId;
                            command.ExecuteNonQuery();
                        }

                        // Добавляем новых авторов
                        using (var command = connection.CreateCommand())
                        {
                            command.CommandType = CommandType.StoredProcedure;
                            command.CommandText = "ADD_AUTHOR_BOOK";
                            foreach (int authorId in authorIds)
                            {
                                command.Parameters.Clear();
                                command.Parameters.Add("p_book_id", OracleDbType.Int32).Value = bookId;
                                command.Parameters.Add("p_author_id", OracleDbType.Int32).Value = authorId;
                                
                                command.ExecuteNonQuery();
                            }
                        }

                        transaction.Commit();
                    }
                    catch (Exception ex)
                    {
                        transaction.Rollback();
                        throw ex;
                    }
                }
            }
        }
       


        public void AddCategoryBook(CategoryBook categoryBook)
        {
            using (var connection = new OracleConnection(_connectionString))
            {
                connection.Open();


                using (var command = connection.CreateCommand())
                {
                    

                    // Добавляем автора к книге в таблицу Authors_Books
                    command.CommandType = CommandType.StoredProcedure;
                    command.CommandText = "Add_Category_Book";
                    command.Parameters.Clear();              
                    command.Parameters.Add(new OracleParameter("p_book_id", GetBookIds));
                    command.Parameters.Add(new OracleParameter("p_category_id", categoryBook.CategoryId));
                    command.ExecuteNonQuery();
                }


            }

        }
        public void UpdateCategoryBook(int bookId, List<int> categoryIds)
        {
            using (var connection = new OracleConnection(_connectionString))
            {
                connection.Open();

                using (var transaction = connection.BeginTransaction())
                {
                    try
                    {
                        // Удаляем всех категорий, связанных с книгой
                        using (var command = connection.CreateCommand())
                        {
                            command.CommandText = "DeleteCategoriesForBook";
                            command.CommandType = CommandType.StoredProcedure;

                            command.Parameters.Add("p_bookId", OracleDbType.Int32).Value = bookId;
                            command.ExecuteNonQuery();
                        }

                        // Добавляем новых категорий
                        using (var command = connection.CreateCommand())
                        {
                            command.CommandType = CommandType.StoredProcedure;
                            command.CommandText = "Add_Category_Book"; 
                            foreach (int categoryId in categoryIds)
                            {
                                command.Parameters.Clear();
                                command.Parameters.Add("p_bookId", OracleDbType.Int32).Value = bookId;
                                command.Parameters.Add("p_category_id", OracleDbType.Int32).Value = categoryId;

                                command.ExecuteNonQuery();
                            }
                        }

                        transaction.Commit();
                    }
                    catch (Exception ex)
                    {
                        transaction.Rollback();
                        throw ex;
                    }
                }
            }
        }
        public void DeleteBook(Book book)
        {
            using (var connection = new OracleConnection(_connectionString))
            {
                connection.Open();
                using (var command = connection.CreateCommand())
                {
                    command.CommandType = CommandType.StoredProcedure;
                    command.CommandText = "Delete_Book";
                    command.Parameters.Add(new OracleParameter("p_book_id", book.BookId));
                    command.ExecuteNonQuery();
                }
            }
        }

    }
}




