
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.ComponentModel;
using System.Configuration;
using System.IO;
using System.Linq;
using System.Text;
using System.Windows;
using WPF_Project.Repository;
using static System.Reflection.Metadata.BlobBuilder;

namespace WPF_Project.ViewModel
{
    public class ReviewsViewModel : INotifyPropertyChanged
    {
        private readonly ReviewsRepository _repository;
        private ObservableCollection<Review> _reviews;
        private string connectionString = ((App)Application.Current).Session.Conn;
        public ObservableCollection<Review> Reviews
        {
            get { return _reviews; }
            set
            {
                _reviews = value;
                OnPropertyChanged(nameof(Reviews));
            }
        }
        public ReviewsViewModel(int bookId)
        {
            _repository = new ReviewsRepository(connectionString);
            Reviews = _repository.GetAllReviews(bookId);

        }
        public void AddReview(Review review)
        {
            _repository.AddReview(review);
            Reviews.Add(review);
        }
        public void DeleteReview(Review review)
        {
            _repository.DeleteReview(review);
            Reviews.Remove(review);
        }
        public event PropertyChangedEventHandler PropertyChanged;

        protected virtual void OnPropertyChanged(string propertyName)
        {
            PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(propertyName));
        }
    }
    public class Review
    {
        public int ReviewId { get; set; }
        public int UserId { get; set; }
        public string UserName { get; set; }
        public int BookId { get; set; }
        public int Rating { get; set; }
        public string ReviewText { get; set; }
    }

}