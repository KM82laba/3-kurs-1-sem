using System;
using System.Data;
using System.Data.SqlClient;
using System.Data.SqlTypes;
using System.IO;
using Microsoft.SqlServer.Server;

public partial class StoredProcedures
{
    [SqlProcedure]
    public static void WriteToFile(SqlString filePath, SqlString content)
    {
        try
        {
            if (filePath.IsNull || content.IsNull)
            {
                SqlContext.Pipe.Send("File path and content cannot be null.\n");
                return;
            }

            // Получение пути к временному каталогу пользователя
            string tempPath = Path.GetTempPath();

            // Создание полного пути к файлу во временном каталоге
            string filePathString = Path.Combine(tempPath, filePath.Value);

            // Запись в файл
            File.WriteAllText(filePathString, content.Value);

            SqlContext.Pipe.Send("Data successfully written to file: " + filePathString + "\n");
        }
        catch (Exception ex)
        {
            SqlContext.Pipe.Send("Error: " + ex.Message + "\n");
        }
    }
}
