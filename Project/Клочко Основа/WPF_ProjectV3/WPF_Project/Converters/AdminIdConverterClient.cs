using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Data;

namespace WPF_Project
{
    public class AdminIdConverterClient : IValueConverter
    {
        public object Convert(object value, Type targetType, object parameter, CultureInfo culture)
        {
            if (value == null || value == DBNull.Value)
                return "";
            int adminId = (int)value;
            return adminId == 0 ? "Обрабатывается" : (adminId == 1 ? "Архивирован" : "Заказ принят");
        }

        public object ConvertBack(object value, Type targetType, object parameter, CultureInfo culture)
        {
            throw new NotImplementedException();
        }
    }
}
