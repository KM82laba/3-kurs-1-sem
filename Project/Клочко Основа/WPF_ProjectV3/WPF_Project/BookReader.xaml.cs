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
using static System.Net.Mime.MediaTypeNames;

namespace WPF_Project
{
    /// <summary>
    /// Логика взаимодействия для BookReader.xaml
    /// </summary>
    public partial class BookReader : Window
    {
        private string[] chunks;
        private int increase, decrease;
        private int chunkInex = 0;
        public BookReader(string BookContent)
        {
            InitializeComponent();
            
/*
            bookText.Document.Blocks.Clear();
            bookText.Document.Blocks.Add(new Paragraph(new Run(BookContent)));
*/
            chunks = SplitText(BookContent, 1734);

            // Добавляем каждый чанк в блоки документа
            bookText.Document.Blocks.Clear();
            bookText.Document.Blocks.Add(new Paragraph(new Run(chunks[chunkInex].ToString())));
            NumberOf.Text = (chunkInex + 1).ToString();

            this.ResizeMode = ResizeMode.NoResize;
            this.WindowState = WindowState.Normal;
            this.WindowStartupLocation = WindowStartupLocation.CenterScreen;
        }
        private string[] SplitText(string text, int chunkSize)
        {
            int chunkCount = (int)Math.Ceiling((double)text.Length / chunkSize);
            string[] chunks = new string[chunkCount];

            // Разбиваем текст на чанки
            for (int i = 0; i < chunkCount; i++)
            {
                int startIndex = i * chunkSize;
                int length = Math.Min(chunkSize, text.Length - startIndex);
                chunks[i] = text.Substring(startIndex, length);
            }

            return chunks;
        }
        private void IncreaseFontSize(object sender, RoutedEventArgs e)
        {
            
            if (chunkInex < chunks.Length - 1)
            {
                chunkInex += 1;
                NumberOf.Text = (chunkInex + 1).ToString();
                bookText.Document.Blocks.Clear();
                bookText.Document.Blocks.Add(new Paragraph(new Run(chunks[chunkInex].ToString())));
            }
        }

        private void DecreaseFontSize(object sender, RoutedEventArgs e)
        {
            if (chunkInex > 0)
            {
                chunkInex -= 1;
                NumberOf.Text = (chunkInex + 1).ToString();
                bookText.Document.Blocks.Clear();
                bookText.Document.Blocks.Add(new Paragraph(new Run(chunks[chunkInex].ToString())));
            }
        }

    }
}
