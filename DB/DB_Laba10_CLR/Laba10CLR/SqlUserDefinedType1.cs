using System;
using System.Data;
using System.Data.SqlClient;
using System.Data.SqlTypes;
using Microsoft.SqlServer.Server;


[Serializable]
[SqlUserDefinedType(Format.UserDefined, IsByteOrdered = true, MaxByteSize = 8000)]
public struct UserData : IBinarySerialize, INullable
{
    public string userName;
    public int password;
    private bool isNull;
    public bool IsNull => isNull;

    public string UserName
    {
        get { return userName; }
        set { userName = value; }
    }

    public int Password
    {
        get { return password; }
        set { password = value; }
    }

    public static UserData Null => new UserData { isNull = true };
    public override string ToString()
    {
        return $"user {UserName},  pass {Password}";
    }
    public void Read(System.IO.BinaryReader r)
    {
        // Чтение данных из потока
        if (r != null)
        {
            userName = r.ReadString();
            password = r.ReadInt32();
        }
    }

    public void Write(System.IO.BinaryWriter w)
    {
        // Запись данных в поток
        if (w != null)
        {
            w.Write(userName);
            w.Write(password);
        }
    }


    public static UserData Parse(SqlString s)
    {
        if (s.IsNull)
            return Null;

        string[] parts = s.Value.Split(',');

        if (parts.Length != 2)
            throw new ArgumentException("Invalid UserData format");

        UserData ud = new UserData();
        ud.UserName = parts[0];
        ud.Password = int.Parse(parts[1]);

        return ud;
    }

}