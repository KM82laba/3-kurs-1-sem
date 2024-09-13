using System;
using System.Collections.Generic;
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

namespace WPF_Project
{
    /// <summary>
    /// Логика взаимодействия для UserBooksWindow.xaml
    /// </summary>
    public partial class UserBooksWindow : Window
    {
        private UserBooksViewModel viewModel;
        int userid = ((App)Application.Current).Session.UserId;
        public UserBooksWindow()
        {
            InitializeComponent();
            viewModel = new UserBooksViewModel(userid, true);
            DataContext = viewModel;
        }

        
    }
}
