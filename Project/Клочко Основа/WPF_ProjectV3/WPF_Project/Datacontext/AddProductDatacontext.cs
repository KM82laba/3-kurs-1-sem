using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace WPF_Project
{
    public class AddProductDatacontext
    {
        
        public PublishersViewModel PublishersViewModel { get; set; }
        public AuthorsViewModel AuthorsViewModel { get; set; }
        public CategoryViewModel CategoryViewModel { get; set; }

        public AddProductDatacontext()
        {
            
            PublishersViewModel = new PublishersViewModel();
            AuthorsViewModel = new AuthorsViewModel();
            CategoryViewModel = new CategoryViewModel();
        }
    }
}
