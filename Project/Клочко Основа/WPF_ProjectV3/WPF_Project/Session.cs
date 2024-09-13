using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace WPF_Project
{
    public class Session
    {
        public int UserId { get; set; }
        public string Email { get; set; }
        public string Role { get; set; }
        public string Conn { get; set; }
        public Session(int userId, string email, string role, string conn)
        {
            UserId = userId;
            Email = email;
            Role = role;
            Conn = conn;
        }
    }
}
