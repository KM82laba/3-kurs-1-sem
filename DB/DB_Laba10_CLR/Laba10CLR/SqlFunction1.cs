using System;
using System.Data;
using System.Data.SqlClient;
using System.Data.SqlTypes;
using System.IO;
using Microsoft.SqlServer.Server;

public partial class UserDefinedFunctions
{
    [SqlFunction]
    public static SqlBoolean WriteTextFile(SqlString text,
                                        SqlString path,
                                        SqlBoolean append)
    {
        // Parameters
        // text: Contains information to be written.
        // path: The complete file path to write to.
        // append: Determines whether data is to be appended to the file.
        // if the file exists and append is false, the file is overwritten.
        // If the file exists and append is true, the data is appended to the file.
        // Otherwise, a new file is created.
        try
        {
            // Check for null input.
            if (!text.IsNull &&
                !path.IsNull &&
                !append.IsNull)
            {
                // Get the directory information for the specified path.
                var dir = Path.GetDirectoryName(path.Value);
                // Determine whether the specified path refers to an existing directory.
                if (!Directory.Exists(dir))
                    // Create all the directories in the specified path.
                    Directory.CreateDirectory(dir);
                // Initialize a new instance of the StreamWriter class
                // for the specified file on the specified path.
                // If the file exists, it can be either overwritten or appended to.
                // If the file does not exist, create a new file.
                using (var sw = new StreamWriter(path.Value, append.Value))
                {
                    // Write specified text followed by a line terminator.
                    sw.WriteLine(text);
                }
                // Return true on success.
                return SqlBoolean.True;
            }
            else
                // Return null if any input is null.
                return SqlBoolean.Null;
        }
        catch (Exception ex)
        {
            // Return null on error.
            return SqlBoolean.Null;
        }
    }
    [SqlProcedure]
    public static void WriteTextFileP(SqlString text, SqlString path, SqlBoolean append)
    {
        try
        {
            if (!text.IsNull && !path.IsNull && !append.IsNull)
            {
                var dir = Path.GetDirectoryName(path.Value);

                if (!Directory.Exists(dir))
                    Directory.CreateDirectory(dir);

                using (var sw = new StreamWriter(path.Value, append.Value))
                {
                    sw.WriteLine(text);
                }
            }
            else
            {
                SqlContext.Pipe.Send("One or more input parameters are null.\n");
                return;
            }
        }
        catch (Exception ex)
        {
            SqlContext.Pipe.Send("Error: " + ex.Message + "\n");
            return;
        }

        SqlContext.Pipe.Send("Data successfully written to file: " + path.Value + "\n");
    }
}
