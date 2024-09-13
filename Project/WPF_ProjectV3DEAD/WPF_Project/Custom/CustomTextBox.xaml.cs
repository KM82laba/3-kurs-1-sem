using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Globalization;
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
using System.Windows.Navigation;
using System.Windows.Shapes;

namespace WPF_Project
{
    /// <summary>
    /// Логика взаимодействия для CustomTextBox.xaml
    /// </summary>
    public partial class CustomTextBox : UserControl, INotifyPropertyChanged
    {
        public CustomTextBox()
        {
            InitializeComponent();
            DataContext = this;
        }

        public static readonly DependencyProperty TextValueProperty =
            DependencyProperty.Register("TextValue", typeof(string), typeof(CustomTextBox),
                new PropertyMetadata(string.Empty));

        public string TextValue
        {
            get { return (string)GetValue(TextValueProperty); }
            set { SetValue(TextValueProperty, value); }
        }

        public static readonly DependencyProperty ShowHintProperty =
            DependencyProperty.Register("ShowHint", typeof(bool), typeof(CustomTextBox),
                new PropertyMetadata(false));

        public bool ShowHint
        {
            get { return (bool)GetValue(ShowHintProperty); }
            set { SetValue(ShowHintProperty, value); }
        }

        public event PropertyChangedEventHandler PropertyChanged;

        private void NumberValidationTextBox(object sender, TextCompositionEventArgs e)
        {
            int result;
            if (!int.TryParse(e.Text, out result))
            {
                e.Handled = true;
                ShowHint = true;
            }
            else
            {
                ShowHint = false;
            }
        }

        private void OnPropertyChanged(string propertyName)
        {
            PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(propertyName));
        }
    }

    public class BoolToVisConverter : IValueConverter
    {
        public object Convert(object value, Type targetType, object parameter, CultureInfo culture)
        {
            bool isVisible = (bool)value;
            return isVisible ? Visibility.Visible : Visibility.Collapsed;
        }

        public object ConvertBack(object value, Type targetType, object parameter, CultureInfo culture)
        {
            throw new NotImplementedException();
        }
    }
}
