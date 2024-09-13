
using Oracle.ManagedDataAccess.Client;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Data;
using System.IO;
using System.Linq;
using System.Net;
using System.Text;
using System.Windows;
using WPF_Project.ViewModel;

namespace WPF_Project.Repository
{
    public class ReviewsRepository
    {
        private readonly string _connectionString;
        public ReviewsRepository(string connectionString)
        {
            _connectionString = connectionString;
        }
        public void AddReview(Review review)
        {
            try
            {
                using (var connection = new OracleConnection(_connectionString))
                {
                    connection.Open();
                    var command = new OracleCommand("AddReview", connection);
                    command.CommandType = CommandType.StoredProcedure;

                    command.Parameters.Add("p_user_id", OracleDbType.Int32).Value = review.UserId;
                    command.Parameters.Add("p_book_id", OracleDbType.Int32).Value = review.BookId;
                    command.Parameters.Add("p_rating", OracleDbType.Int32).Value = review.Rating;
                    command.Parameters.Add("p_review", OracleDbType.Varchar2).Value = review.ReviewText;

                    command.ExecuteNonQuery();
                }
            }
            catch (OracleException ex)
            {
                if (ex.Number == 20004)
                {
                    MessageBox.Show(ex.Message);
                }
                else
                {
                    MessageBox.Show("Ошибка при добавлении отзыва: " + ex.Message);
                }
            }
        }

        public void DeleteReview(Review review)
        {
            using (var connection = new OracleConnection(_connectionString))
            {
                connection.Open();
                var command = new OracleCommand("DeleteReviewById", connection);
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.Add("p_review_id", OracleDbType.Int32).Value = review.ReviewId;
                command.ExecuteNonQuery();
            }
        }
        public ObservableCollection<Review> GetAllReviews(int bookId)
        {
            var reviews = new ObservableCollection<Review>();
            using (var connection = new OracleConnection(_connectionString))
            {
                connection.Open();
                var command = new OracleCommand("GetReviewsByBookId", connection);
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.Add("p_book_id", OracleDbType.Int32).Value = bookId;
                command.Parameters.Add("p_reviews", OracleDbType.RefCursor).Direction = ParameterDirection.Output;
                var reader = command.ExecuteReader();
                while (reader.Read())
                {
                    var review = new Review
                    {
                        ReviewId = Convert.ToInt32(reader["review_id"]),
                        UserId = Convert.ToInt32(reader["user_id"]),
                        BookId = bookId,
                        Rating = Convert.ToInt32(reader["rating"]),
                        ReviewText = reader["review"].ToString(),
                        UserName = reader["email"].ToString()
                    };
                    reviews.Add(review);
                }
            }
            return reviews;
        }

    }
}