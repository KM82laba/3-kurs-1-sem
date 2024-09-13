using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.ComponentModel;
using System.Data;
using System.Linq;
using System.Security.Policy;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Configuration;
namespace WPF_Project
{
    public class PublishersViewModel : INotifyPropertyChanged
    {
        private ObservableCollection<Publisher> publishers;
        private readonly PublishersRepository _repository;
        private string connectionString = ((App)Application.Current).Session.Conn;

        public ObservableCollection<Publisher> Publishers
        {
            get { return publishers; }
            set
            {
                publishers = value;
                OnPropertyChanged("Publishers");
            }
        }

        public PublishersViewModel()
        {
            _repository = new PublishersRepository(connectionString);
            LoadPublishers();
        }

        private void LoadPublishers()
        {
            DataTable publishersTable = _repository.GetAllPublishers();

            Publishers = new ObservableCollection<Publisher>();

            foreach (DataRow row in publishersTable.Rows)
            {
                Publisher publisher = new Publisher()
                {
                    PublisherId = Convert.ToInt32(row["publisher_id"]),
                    PublisherName = (string)row["publisher_name"]
                };

                Publishers.Add(publisher);
            }
        }

        public void AddPublisher(Publisher publisher)
        {
            int newPublisherId = _repository.GetNextPublisherId() + 1;
            publisher.PublisherId = newPublisherId;
            _repository.AddPublisher(publisher);
            Publishers.Add(publisher);
        }
        

        public void UpdatePublisher(Publisher publisher)
        {   _repository.UpdatePublisher(publisher);
            
            
        }

        public void DeletePublisher(Publisher publisher)
        {
           _repository.DeletePublisher(publisher);

        }

        public event PropertyChangedEventHandler PropertyChanged;

        public void OnPropertyChanged(string propertyName)
        {
            PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(propertyName));
        }
    }
    public class Publisher
    {
        public int PublisherId { get; set; }
        public string PublisherName { get; set; }

        
    }
}
