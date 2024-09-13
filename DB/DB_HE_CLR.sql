USE master
exec sp_configure 'show advanced options', 1;
go 
reconfigure
go 
exec sp_configure 'clr enabled',1;
exec sp_configure 'clr strict security', 0
RECONFIGURE

USE DB_HE
GO
ALTER DATABASE DB_HE SET TRUSTWORTHY ON
GO

CREATE ASSEMBLY TextFileTips
FROM 'C:\Education\3 kurs 1 sem\DB\DB_Laba10_CLR\Laba10CLR\bin\Debug\Laba10CLR.dll'
WITH PERMISSION_SET = EXTERNAL_ACCESS

CREATE FUNCTION [dbo].[WriteTextFile](
@text [nvarchar](4000), 
@path [nvarchar](4000), 
@append [bit])
RETURNS [bit] WITH EXECUTE AS CALLER
AS 
EXTERNAL NAME [TextFileTips].[UserDefinedFunctions].[WriteTextFile]
GO

CREATE PROCEDURE dbo.WriteTextFileP
    @text NVARCHAR(MAX),
    @path NVARCHAR(MAX),
    @append BIT
	WITH EXECUTE AS CALLER
AS
EXTERNAL NAME [TextFileTips].[UserDefinedFunctions].[WriteTextFileP];

"C:\Education\3 kurs 1 sem\DB\DB_Laba10_CLR\Laba10CLR\bin\Debug\Data.txt"

SELECT dbo.WriteTextFile(
'text2', 'C:\Education\3 kurs 1 sem\DB\DB_Laba10_CLR\Laba10CLR\bin\Debug\Data.txt', 0)
GO

EXEC dbo.WriteTextFile
    @text = N'Hello World',
    @path = N'C:\Education\3 kurs 1 sem\DB\DB_Laba10_CLR\Laba10CLR\bin\Debug\Data.txt',
    @append = 0;

CREATE TYPE dbo.UserData
EXTERNAL NAME [TextFileTips].[UserData];

CREATE TABLE UserDataTable
(
    ID INT PRIMARY KEY,
    userdata_c UserData
);

INSERT INTO UserDataTable (ID, userdata_c)
VALUES (1, 'AB,123456');

SELECT * FROM UserDataTable;