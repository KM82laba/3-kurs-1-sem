--создание таблиц
CREATE TABLE Candidates (
    CandidateID INT IDENTITY(1,1) PRIMARY KEY,
    LastName NVARCHAR(255),
    FirstName NVARCHAR(255),
    MiddleName NVARCHAR(255),
    DateOfBirth DATE,
    Gender NVARCHAR(10),
    Experience NVARCHAR(255),
    Source NVARCHAR(255),
    Status NVARCHAR(255)
);

CREATE TABLE Addresses (
    AddressID INT IDENTITY(1,1) PRIMARY KEY,
    Country NVARCHAR(255),
    City NVARCHAR(255),
    Street NVARCHAR(255),
    CandidateID INT,
    FOREIGN KEY (CandidateID) REFERENCES Candidates (CandidateID)
);

CREATE TABLE Education (
    EducationID INT IDENTITY(1,1) PRIMARY KEY,
    EducationalInstitution NVARCHAR(255),
    Specialty NVARCHAR(255)
);

CREATE TABLE CandidatesEducation (
    CandidatesEducationID INT IDENTITY(1,1) PRIMARY KEY,
    YearOfGraduation DATE,
    EducationID INT,
    CandidateID INT,
    FOREIGN KEY (EducationID) REFERENCES Education (EducationID),
    FOREIGN KEY (CandidateID) REFERENCES Candidates (CandidateID)
);

CREATE TABLE CoursesAndTraining (
    CourseID INT IDENTITY(1,1) PRIMARY KEY,
    CourseName NVARCHAR(255),
    CourseDescription NVARCHAR(MAX),
    Organization NVARCHAR(255)
);

CREATE TABLE CandidatesCoursesAndTraining (
    CandidatesCoursesAndTrainingID INT IDENTITY(1,1) PRIMARY KEY,
    TrainingStartDate DATE,
    TrainingEndDate DATE,
    CourseID INT,
    CandidateID INT,
    FOREIGN KEY (CourseID) REFERENCES CoursesAndTraining (CourseID),
    FOREIGN KEY (CandidateID) REFERENCES Candidates (CandidateID)
);

CREATE TABLE Vacancies (
    VacancyID INT IDENTITY(1,1) PRIMARY KEY,
    PositionTitle NVARCHAR(255),
    JobDescription NVARCHAR(MAX),
    CreationDate DATE,
    HiringSchedule DATE
);

CREATE TABLE JobApplications (
    ApplicationID INT IDENTITY(1,1) PRIMARY KEY,
    CandidateID INT,
    VacancyID INT,
    ApplicationDate DATETIME,
    FOREIGN KEY (CandidateID) REFERENCES Candidates (CandidateID),
    FOREIGN KEY (VacancyID) REFERENCES Vacancies (VacancyID)
);

CREATE TABLE Interviews (
    InterviewID INT IDENTITY(1,1) PRIMARY KEY,
    CandidateID INT,
    VacancyID INT,
    InterviewDateTime DATETIME,
    Location NVARCHAR(255),
    InterviewResult NVARCHAR(255),
    Parents INT,
    FOREIGN KEY (CandidateID) REFERENCES Candidates (CandidateID),
    FOREIGN KEY (VacancyID) REFERENCES Vacancies (VacancyID),
    FOREIGN KEY (Parents) REFERENCES Interviews (InterviewID)
);

CREATE TABLE CandidateContactInfo (
    ContactInfoID INT IDENTITY(1,1) PRIMARY KEY,
    CandidateID INT,
    ContactInfo NVARCHAR(255),
    FOREIGN KEY (CandidateID) REFERENCES Candidates (CandidateID)
);

CREATE TABLE Interviewers (
    InterviewerID INT IDENTITY(1,1) PRIMARY KEY,
    LastName NVARCHAR(255),
    FirstName NVARCHAR(255),
    Role NVARCHAR(255)
);

CREATE TABLE VacancyApproval (
    ApprovalID INT IDENTITY(1,1) PRIMARY KEY,
    VacancyID INT,
    ApprovalDate DATETIME,
    InterviewerID INT,
    Status NVARCHAR(255),
    FOREIGN KEY (VacancyID) REFERENCES Vacancies (VacancyID),
    FOREIGN KEY (InterviewerID) REFERENCES Interviewers (InterviewerID)
);

CREATE TABLE InterviewsWithInterviewers (
    InterviewWithInterviewerID INT IDENTITY(1,1) PRIMARY KEY,
    InterviewerID INT,
    InterviewID INT,
    FOREIGN KEY (InterviewerID) REFERENCES Interviewers (InterviewerID),
    FOREIGN KEY (InterviewID) REFERENCES Interviews (InterviewID)
);

CREATE TABLE InterviewerContactInfo (
    ContactInfoID INT IDENTITY(1,1) PRIMARY KEY,
    InterviewerID INT,
    ContactInfo NVARCHAR(255),
    FOREIGN KEY (InterviewerID) REFERENCES Interviewers (InterviewerID)
);

CREATE TABLE CandidateAssessments (
    AssessmentID INT IDENTITY(1,1) PRIMARY KEY,
    InterviewID INT,
    InterviewerID INT,
    AssessmentDate DATETIME,
    Rating INT,
    Comments NVARCHAR(1000),
    FOREIGN KEY (InterviewID) REFERENCES Interviews (InterviewID),
    FOREIGN KEY (InterviewerID) REFERENCES Interviewers (InterviewerID)
);

CREATE TABLE Languages (
    LanguageID INT IDENTITY(1,1) PRIMARY KEY,
    LanguageName NVARCHAR(255)
);

CREATE TABLE CandidateLanguage (
    CandidateLanguageID INT IDENTITY(1,1) PRIMARY KEY,
    LanguageID INT,
    CandidateID INT,
    Level NVARCHAR(255),
    FOREIGN KEY (LanguageID) REFERENCES Languages (LanguageID),
    FOREIGN KEY (CandidateID) REFERENCES Candidates (CandidateID)
);

CREATE TABLE ProgLang (
    ProgLangID INT IDENTITY(1,1) PRIMARY KEY,
    ProgLangName NVARCHAR(255)
);

CREATE TABLE CandidateProgLang (
    CandidateProgLangID INT IDENTITY(1,1) PRIMARY KEY,
    ProgLangID INT,
    CandidateID INT,
    Level NVARCHAR(255),
    FOREIGN KEY (ProgLangID) REFERENCES ProgLang (ProgLangID),
    FOREIGN KEY (CandidateID) REFERENCES Candidates (CandidateID)
);

CREATE TABLE Documents (
    DocumentID INT IDENTITY(1,1) PRIMARY KEY,
    CandidateID INT,
    DocumentName NVARCHAR(255),
    DocumentContent VARBINARY(MAX),
    FOREIGN KEY (CandidateID) REFERENCES Candidates (CandidateID)
);

CREATE TABLE ChangeLog (
    RecordID INT IDENTITY(1,1) PRIMARY KEY,
    TableName NVARCHAR(255),
    OperationType NVARCHAR(10),
    ChangedColumns NVARCHAR(255),
    OldValues NVARCHAR(MAX),
    NewValues NVARCHAR(MAX),
    ChangeDateTime DATETIME
);

--удаление таблиц 
DROP TABLE CandidateAssessments;
DROP TABLE CandidateContactInfo;
DROP TABLE CandidateLanguage;
DROP TABLE CandidateProgLang;
DROP TABLE InterviewsWithInterviewers;
DROP TABLE VacancyApproval;
DROP TABLE InterviewerContactInfo;
DROP TABLE Interviewers;
DROP TABLE CandidatesCoursesAndTraining;
DROP TABLE JobApplications;
DROP TABLE CandidatesEducation;
DROP TABLE Addresses;
DROP TABLE Documents;
DROP TABLE Languages;
DROP TABLE ProgLang;
DROP TABLE ChangeLog;
DROP TABLE Interviews;
DROP TABLE Vacancies;
DROP TABLE CoursesAndTraining;
DROP TABLE Candidates;
DROP TABLE Education;
--Роли:
-- Создание ролей
CREATE ROLE Candidates;
CREATE ROLE HRManagers;
CREATE ROLE DecisionMakers;
CREATE ROLE Interviewers;
CREATE ROLE ITAdmins;

-- Назначение разрешений ролям
-- Роль Candidates может только читать свои статусы и интервью
GRANT SELECT ON Candidates TO Candidates;
GRANT SELECT ON CandidateContactInfo TO Candidates;

-- Роль HRManagers может управлять вакансиями, заявками и интервью
GRANT SELECT, INSERT, UPDATE, DELETE ON Vacancies TO HRManagers;
GRANT SELECT, INSERT, UPDATE, DELETE ON JobApplications TO HRManagers;
GRANT SELECT, INSERT, UPDATE, DELETE ON Interviews TO HRManagers;
GRANT SELECT, INSERT, UPDATE, DELETE ON VacancyApproval TO HRManagers;
GRANT SELECT, INSERT, UPDATE, DELETE ON InterviewerContactInfo TO HRManagers;

-- Роль DecisionMakers может просматривать информацию о кандидатах и результатах интервью
GRANT SELECT ON Candidates TO DecisionMakers;
GRANT SELECT ON CandidateContactInfo TO DecisionMakers;
GRANT SELECT ON Interviews TO DecisionMakers;
GRANT SELECT ON CandidateAssessments TO DecisionMakers;

-- Роль Interviewers может просматривать информацию о кандидатах и вакансиях
GRANT SELECT ON Candidates TO Interviewers;
GRANT SELECT ON CandidateContactInfo TO Interviewers;
GRANT SELECT ON Vacancies TO Interviewers;
GRANT SELECT ON Languages TO Interviewers;
GRANT SELECT ON CandidateLanguage TO Interviewers;
GRANT SELECT ON ProgLang TO Interviewers;
GRANT SELECT ON CandidateProgLang TO Interviewers;
GRANT SELECT ON Interviews TO Interviewers;

-- Роль ITAdmins имеет полный доступ для управления базой данных и таблицами
GRANT CONTROL ON Candidates TO ITAdmins;
GRANT CONTROL ON Addresses TO ITAdmins;
GRANT CONTROL ON Education TO ITAdmins;
GRANT CONTROL ON CandidatesEducation TO ITAdmins;
GRANT CONTROL ON CoursesAndTraining TO ITAdmins;
GRANT CONTROL ON CandidatesCoursesAndTraining TO ITAdmins;
GRANT CONTROL ON Vacancies TO ITAdmins;
GRANT CONTROL ON JobApplications TO ITAdmins;
GRANT CONTROL ON Interviews TO ITAdmins;
GRANT CONTROL ON CandidateContactInfo TO ITAdmins;
GRANT CONTROL ON Interviewers TO ITAdmins;
GRANT CONTROL ON VacancyApproval TO ITAdmins;
GRANT CONTROL ON InterviewsWithInterviewers TO ITAdmins;
GRANT CONTROL ON InterviewerContactInfo TO ITAdmins;
GRANT CONTROL ON CandidateAssessments TO ITAdmins;
GRANT CONTROL ON Languages TO ITAdmins;
GRANT CONTROL ON CandidateLanguage TO ITAdmins;
GRANT CONTROL ON ProgLang TO ITAdmins;
GRANT CONTROL ON CandidateProgLang TO ITAdmins;
GRANT CONTROL ON Documents TO ITAdmins;
GRANT CONTROL ON ChangeLog TO ITAdmins;

--Процедуры:
-- Процедура для добавления кандидата
CREATE PROCEDURE InsertCandidate
    @LastName NVARCHAR(255),
    @FirstName NVARCHAR(255),
    @MiddleName NVARCHAR(255),
    @DateOfBirth DATE,
    @Gender NVARCHAR(10),
    @Experience NVARCHAR(255),
    @Source NVARCHAR(255),
    @Status NVARCHAR(255)
AS
BEGIN
    BEGIN TRY
        INSERT INTO Candidates (LastName, FirstName, MiddleName, DateOfBirth, Gender, Experience, Source, Status)
        VALUES (@LastName, @FirstName, @MiddleName, @DateOfBirth, @Gender, @Experience, @Source, @Status);
    END TRY
    BEGIN CATCH
        -- Обработка ошибок
        SELECT ERROR_MESSAGE() AS ErrorMessage;
    END CATCH
END;
-- Процедура для обновления данных о кандидатах
CREATE PROCEDURE UpdateCandidate
    @CandidateID INT,
    @LastName NVARCHAR(255),
    @FirstName NVARCHAR(255),
    @MiddleName NVARCHAR(255),
    @DateOfBirth DATE,
    @Gender NVARCHAR(10),
    @Experience NVARCHAR(255),
    @Source NVARCHAR(255),
    @Status NVARCHAR(255)
AS
BEGIN
    BEGIN TRY
        UPDATE Candidates
        SET
            LastName = @LastName,
            FirstName = @FirstName,
            MiddleName = @MiddleName,
            DateOfBirth = @DateOfBirth,
            Gender = @Gender,
            Experience = @Experience,
            Source = @Source,
            Status = @Status
        WHERE CandidateID = @CandidateID;
    END TRY
    BEGIN CATCH
        SELECT ERROR_MESSAGE() AS ErrorMessage;
    END CATCH
END;
-- Процедура для удаления данных о кандидатах
CREATE PROCEDURE DeleteCandidate
    @CandidateID INT
AS
BEGIN
    BEGIN TRY
        DELETE FROM Candidates
        WHERE CandidateID = @CandidateID;
    END TRY
    BEGIN CATCH
        SELECT ERROR_MESSAGE() AS ErrorMessage;
    END CATCH
END;
-- Процедура для добавления адреса
CREATE PROCEDURE InsertAddress
    @Country NVARCHAR(255),
    @City NVARCHAR(255),
    @Street NVARCHAR(255),
    @CandidateID INT
AS
BEGIN
    BEGIN TRY
        INSERT INTO Addresses (Country, City, Street, CandidateID)
        VALUES (@Country, @City, @Street, @CandidateID);
    END TRY
    BEGIN CATCH
        -- Обработка ошибок
        SELECT ERROR_MESSAGE() AS ErrorMessage;
    END CATCH
END;
-- Процедура для обновления данных об адресах
CREATE PROCEDURE UpdateAddress
    @AddressID INT,
    @Country NVARCHAR(255),
    @City NVARCHAR(255),
    @Street NVARCHAR(255)
AS
BEGIN
    BEGIN TRY
        UPDATE Addresses
        SET
            Country = @Country,
            City = @City,
            Street = @Street
        WHERE AddressID = @AddressID;
    END TRY
    BEGIN CATCH
        SELECT ERROR_MESSAGE() AS ErrorMessage;
    END CATCH
END;

-- Процедура для удаления данных об адресах
CREATE PROCEDURE DeleteAddress
    @AddressID INT
AS
BEGIN
    BEGIN TRY
        DELETE FROM Addresses
        WHERE AddressID = @AddressID;
    END TRY
    BEGIN CATCH
        SELECT ERROR_MESSAGE() AS ErrorMessage;
    END CATCH
END;

-- Процедура для добавления образования
CREATE PROCEDURE InsertEducation
    @EducationalInstitution NVARCHAR(255),
    @Specialty NVARCHAR(255)
AS
BEGIN
    BEGIN TRY
        INSERT INTO Education (EducationalInstitution, Specialty)
        VALUES (@EducationalInstitution, @Specialty);
    END TRY
    BEGIN CATCH
        -- Обработка ошибок
        SELECT ERROR_MESSAGE() AS ErrorMessage;
    END CATCH
END;
-- Процедура для обновления данных об образовании
CREATE PROCEDURE UpdateEducation
    @EducationID INT,
    @EducationalInstitution NVARCHAR(255),
    @Specialty NVARCHAR(255)
AS
BEGIN
    BEGIN TRY
        UPDATE Education
        SET
            EducationalInstitution = @EducationalInstitution,
            Specialty = @Specialty
        WHERE EducationID = @EducationID;
    END TRY
    BEGIN CATCH
        SELECT ERROR_MESSAGE() AS ErrorMessage;
    END CATCH
END;

-- Процедура для удаления данных об образовании
CREATE PROCEDURE DeleteEducation
    @EducationID INT
AS
BEGIN
    BEGIN TRY
        DELETE FROM Education
        WHERE EducationID = @EducationID;
    END TRY
    BEGIN CATCH
        SELECT ERROR_MESSAGE() AS ErrorMessage;
    END CATCH
END;

-- Процедура для добавления курсов и тренингов
CREATE PROCEDURE InsertCoursesAndTraining
    @CourseName NVARCHAR(255),
    @CourseDescription NVARCHAR(MAX),
    @Organization NVARCHAR(255)
AS
BEGIN
    BEGIN TRY
        INSERT INTO CoursesAndTraining (CourseName, CourseDescription, Organization)
        VALUES (@CourseName, @CourseDescription, @Organization);
    END TRY
    BEGIN CATCH
        -- Обработка ошибок
        SELECT ERROR_MESSAGE() AS ErrorMessage;
    END CATCH
END;
-- Процедура для обновления данных о курсах и тренингах кандидатов
CREATE PROCEDURE UpdateCandidateCoursesAndTraining
    @CandidatesCoursesAndTrainingID INT,
    @TrainingStartDate DATE,
    @TrainingEndDate DATE,
    @CourseID INT,
    @CandidateID INT
AS
BEGIN
    BEGIN TRY
        UPDATE CandidatesCoursesAndTraining
        SET
            TrainingStartDate = @TrainingStartDate,
            TrainingEndDate = @TrainingEndDate,
            CourseID = @CourseID,
            CandidateID = @CandidateID
        WHERE CandidatesCoursesAndTrainingID = @CandidatesCoursesAndTrainingID;
    END TRY
    BEGIN CATCH
        SELECT ERROR_MESSAGE() AS ErrorMessage;
    END CATCH
END;

-- Процедура для удаления данных о курсах и тренингах кандидатов
CREATE PROCEDURE DeleteCandidateCoursesAndTraining
    @CandidatesCoursesAndTrainingID INT
AS
BEGIN
    BEGIN TRY
        DELETE FROM CandidatesCoursesAndTraining
        WHERE CandidatesCoursesAndTrainingID = @CandidatesCoursesAndTrainingID;
    END TRY
    BEGIN CATCH
        SELECT ERROR_MESSAGE() AS ErrorMessage;
    END CATCH
END;
-- Процедура для добавления обучения для кандитатов 
CREATE PROCEDURE InsertCandidatesEducation
    @YearOfGraduation DATE,
    @EducationID INT,
    @CandidateID INT
AS
BEGIN
    BEGIN TRY
        INSERT INTO CandidatesEducation (YearOfGraduation, EducationID, CandidateID)
        VALUES (@YearOfGraduation, @EducationID, @CandidateID);
    END TRY
    BEGIN CATCH
        SELECT ERROR_MESSAGE() AS ErrorMessage;
    END CATCH
END;

-- Процедура для обновления данных об образовании кандидатов
CREATE PROCEDURE UpdateCandidateEducation
    @CandidatesEducationID INT,
    @YearOfGraduation DATE,
    @EducationID INT,
    @CandidateID INT
AS
BEGIN
    BEGIN TRY
        UPDATE CandidatesEducation
        SET
            YearOfGraduation = @YearOfGraduation,
            EducationID = @EducationID,
            CandidateID = @CandidateID
        WHERE CandidatesEducationID = @CandidatesEducationID;
    END TRY
    BEGIN CATCH
        SELECT ERROR_MESSAGE() AS ErrorMessage;
    END CATCH
END;

-- Процедура для удаления данных об образовании кандидатов
CREATE PROCEDURE DeleteCandidateEducation
    @CandidatesEducationID INT
AS
BEGIN
    BEGIN TRY
        DELETE FROM CandidatesEducation
        WHERE CandidatesEducationID = @CandidatesEducationID;
    END TRY
    BEGIN CATCH
        SELECT ERROR_MESSAGE() AS ErrorMessage;
    END CATCH
END;

-- Процедура для добавления вакансии
CREATE PROCEDURE InsertVacancy
    @PositionTitle NVARCHAR(255),
    @JobDescription NVARCHAR(MAX),
    @CreationDate DATE,
    @HiringSchedule DATE
AS
BEGIN
    BEGIN TRY
        INSERT INTO Vacancies (PositionTitle, JobDescription, CreationDate, HiringSchedule)
        VALUES (@PositionTitle, @JobDescription, @CreationDate, @HiringSchedule);
    END TRY
    BEGIN CATCH
        -- Обработка ошибок
        SELECT ERROR_MESSAGE() AS ErrorMessage;
    END CATCH
END;
-- Процедура для обновления данных о вакансиях
CREATE PROCEDURE UpdateVacancy
    @VacancyID INT,
    @PositionTitle NVARCHAR(255),
    @JobDescription NVARCHAR(MAX),
    @CreationDate DATE,
    @HiringSchedule DATE
AS
BEGIN
    BEGIN TRY
        UPDATE Vacancies
        SET
            PositionTitle = @PositionTitle,
            JobDescription = @JobDescription,
            CreationDate = @CreationDate,
            HiringSchedule = @HiringSchedule
        WHERE VacancyID = @VacancyID;
    END TRY
    BEGIN CATCH
        SELECT ERROR_MESSAGE() AS ErrorMessage;
    END CATCH
END;

-- Процедура для удаления данных о вакансиях
CREATE PROCEDURE DeleteVacancy
    @VacancyID INT
AS
BEGIN
    BEGIN TRY
        DELETE FROM Vacancies
        WHERE VacancyID = @VacancyID;
    END TRY
    BEGIN CATCH
        SELECT ERROR_MESSAGE() AS ErrorMessage;
    END CATCH
END;

-- Процедура для добавления собеседования
CREATE PROCEDURE InsertInterview
    @CandidateID INT,
    @VacancyID INT,
    @InterviewDateTime DATETIME,
    @Location NVARCHAR(255),
    @InterviewResult NVARCHAR(255),
    @Parents INT
AS
BEGIN
    BEGIN TRY
        INSERT INTO Interviews (CandidateID, VacancyID, InterviewDateTime, Location, InterviewResult, Parents)
        VALUES (@CandidateID, @VacancyID, @InterviewDateTime, @Location, @InterviewResult, @Parents);
    END TRY
    BEGIN CATCH
        -- Обработка ошибок
        SELECT ERROR_MESSAGE() AS ErrorMessage;
    END CATCH
END;
-- Процедура для обновления данных о собеседованиях
CREATE PROCEDURE UpdateInterview
    @InterviewID INT,
    @CandidateID INT,
    @VacancyID INT,
    @InterviewDateTime DATETIME,
    @Location NVARCHAR(255),
    @InterviewResult NVARCHAR(255),
    @Parents INT
AS
BEGIN
    BEGIN TRY
        UPDATE Interviews
        SET
            CandidateID = @CandidateID,
            VacancyID = @VacancyID,
            InterviewDateTime = @InterviewDateTime,
            Location = @Location,
            InterviewResult = @InterviewResult,
            Parents = @Parents
        WHERE InterviewID = @InterviewID;
    END TRY
    BEGIN CATCH
        SELECT ERROR_MESSAGE() AS ErrorMessage;
    END CATCH
END;
-- Процедура для удаления данных о собеседованиях
CREATE PROCEDURE DeleteInterview
    @InterviewID INT
AS
BEGIN
    BEGIN TRY
        DELETE FROM Interviews
        WHERE InterviewID = @InterviewID;
    END TRY
    BEGIN CATCH
        SELECT ERROR_MESSAGE() AS ErrorMessage;
    END CATCH
END;

-- Процедура для добавления заявки на работу
CREATE PROCEDURE InsertJobApplication
    @CandidateID INT,
    @VacancyID INT,
    @ApplicationDate DATETIME
AS
BEGIN
    BEGIN TRY
        INSERT INTO JobApplications (CandidateID, VacancyID, ApplicationDate)
        VALUES (@CandidateID, @VacancyID, @ApplicationDate);
    END TRY
    BEGIN CATCH
        SELECT ERROR_MESSAGE() AS ErrorMessage;
    END CATCH
END;
-- Процедура для добавления информации о контакте кандидата
CREATE PROCEDURE InsertCandidateContactInfo
    @CandidateID INT,
    @ContactInfo NVARCHAR(255)
AS
BEGIN
    BEGIN TRY
        INSERT INTO CandidateContactInfo (CandidateID, ContactInfo)
        VALUES (@CandidateID, @ContactInfo);
    END TRY
    BEGIN CATCH
        SELECT ERROR_MESSAGE() AS ErrorMessage;
    END CATCH
END;
-- Процедура для обновления контактной информации кандидатов
CREATE PROCEDURE UpdateCandidateContactInfo
    @ContactInfoID INT,
    @CandidateID INT,
    @ContactInfo NVARCHAR(255)
AS
BEGIN
    BEGIN TRY
        UPDATE CandidateContactInfo
        SET
            CandidateID = @CandidateID,
            ContactInfo = @ContactInfo
        WHERE ContactInfoID = @ContactInfoID;
    END TRY
    BEGIN CATCH
        SELECT ERROR_MESSAGE() AS ErrorMessage;
    END CATCH
END;
-- Процедура для удаления контактной информации кандидатов
CREATE PROCEDURE DeleteCandidateContactInfo
    @ContactInfoID INT
AS
BEGIN
    BEGIN TRY
        DELETE FROM CandidateContactInfo
        WHERE ContactInfoID = @ContactInfoID;
    END TRY
    BEGIN CATCH
        SELECT ERROR_MESSAGE() AS ErrorMessage;
    END CATCH
END;

-- Процедура для добавления информации о собеседователе
CREATE PROCEDURE InsertInterviewer
    @LastName NVARCHAR(255),
    @FirstName NVARCHAR(255),
    @Role NVARCHAR(255)
AS
BEGIN
    BEGIN TRY
        INSERT INTO Interviewers (LastName, FirstName, Role)
        VALUES (@LastName, @FirstName, @Role);
    END TRY
    BEGIN CATCH
        SELECT ERROR_MESSAGE() AS ErrorMessage;
    END CATCH
END;
-- Процедура для обновления информации о собеседователях
CREATE PROCEDURE UpdateInterviewer
    @InterviewerID INT,
    @LastName NVARCHAR(255),
    @FirstName NVARCHAR(255),
    @Role NVARCHAR(255)
AS
BEGIN
    BEGIN TRY
        UPDATE Interviewers
        SET
            LastName = @LastName,
            FirstName = @FirstName,
            Role = @Role
        WHERE InterviewerID = @InterviewerID;
    END TRY
    BEGIN CATCH
        SELECT ERROR_MESSAGE() AS ErrorMessage;
    END CATCH
END;

-- Процедура для удаления информации о собеседователях
CREATE PROCEDURE DeleteInterviewer
    @InterviewerID INT
AS
BEGIN
    BEGIN TRY
        DELETE FROM Interviewers
        WHERE InterviewerID = @InterviewerID;
    END TRY
    BEGIN CATCH
        SELECT ERROR_MESSAGE() AS ErrorMessage;
    END CATCH
END;

-- Процедура для добавления информации о решении по вакансии
CREATE PROCEDURE InsertVacancyApproval
    @VacancyID INT,
    @ApprovalDate DATETIME,
    @InterviewerID INT,
    @Status NVARCHAR(255)
AS
BEGIN
    BEGIN TRY
        INSERT INTO VacancyApproval (VacancyID, ApprovalDate, InterviewerID, Status)
        VALUES (@VacancyID, @ApprovalDate, @InterviewerID, @Status);
    END TRY
    BEGIN CATCH
        SELECT ERROR_MESSAGE() AS ErrorMessage;
    END CATCH
END;
-- Процедура для обновления информации о подтверждении вакансии
CREATE PROCEDURE UpdateVacancyApproval
    @ApprovalID INT,
    @VacancyID INT,
    @ApprovalDate DATETIME,
    @InterviewerID INT,
    @Status NVARCHAR(255)
AS
BEGIN
    BEGIN TRY
        UPDATE VacancyApproval
        SET
            VacancyID = @VacancyID,
            ApprovalDate = @ApprovalDate,
            InterviewerID = @InterviewerID,
            Status = @Status
        WHERE ApprovalID = @ApprovalID;
    END TRY
    BEGIN CATCH
        SELECT ERROR_MESSAGE() AS ErrorMessage;
    END CATCH
END;

-- Процедура для удаления информации о подтверждении вакансии
CREATE PROCEDURE DeleteVacancyApproval
    @ApprovalID INT
AS
BEGIN
    BEGIN TRY
        DELETE FROM VacancyApproval
        WHERE ApprovalID = @ApprovalID;
    END TRY
    BEGIN CATCH
        SELECT ERROR_MESSAGE() AS ErrorMessage;
    END CATCH
END;

-- Процедура для добавления информации о собеседовании с собеседователями
CREATE PROCEDURE InsertInterviewWithInterviewer
    @InterviewerID INT,
    @InterviewID INT
AS
BEGIN
    BEGIN TRY
        INSERT INTO InterviewsWithInterviewers (InterviewerID, InterviewID)
        VALUES (@InterviewerID, @InterviewID);
    END TRY
    BEGIN CATCH
        SELECT ERROR_MESSAGE() AS ErrorMessage;
    END CATCH
END;
-- Процедура для обновления информации о собеседованиях с участием собеседователей
CREATE PROCEDURE UpdateInterviewWithInterviewer
    @InterviewWithInterviewerID INT,
    @InterviewerID INT,
    @InterviewID INT
AS
BEGIN
    BEGIN TRY
        UPDATE InterviewsWithInterviewers
        SET
            InterviewerID = @InterviewerID,
            InterviewID = @InterviewID
        WHERE InterviewWithInterviewerID = @InterviewWithInterviewerID;
    END TRY
    BEGIN CATCH
        SELECT ERROR_MESSAGE() AS ErrorMessage;
    END CATCH
END;

-- Процедура для удаления информации о собеседованиях с участием собеседователей
CREATE PROCEDURE DeleteInterviewWithInterviewer
    @InterviewWithInterviewerID INT
AS
BEGIN
    BEGIN TRY
        DELETE FROM InterviewsWithInterviewers
        WHERE InterviewWithInterviewerID = @InterviewWithInterviewerID;
    END TRY
    BEGIN CATCH
        SELECT ERROR_MESSAGE() AS ErrorMessage;
    END CATCH
END;
-- Процедура для добавления оценок собеседования
CREATE PROCEDURE InsertCandidateAssessment
    @InterviewID INT,
    @InterviewerID INT,
    @AssessmentDate DATETIME,
    @Rating INT,
    @Comments NVARCHAR(1000)
AS
BEGIN
    BEGIN TRY
        INSERT INTO CandidateAssessments (InterviewID, InterviewerID, AssessmentDate, Rating, Comments)
        VALUES (@InterviewID, @InterviewerID, @AssessmentDate, @Rating, @Comments);
    END TRY
    BEGIN CATCH
        SELECT ERROR_MESSAGE() AS ErrorMessage;
    END CATCH
END;
-- Процедура для обновления оценок кандидатов после собеседования
CREATE PROCEDURE UpdateCandidateAssessment
    @AssessmentID INT,
    @InterviewID INT,
    @InterviewerID INT,
    @AssessmentDate DATETIME,
    @Rating INT,
    @Comments NVARCHAR(1000)
AS
BEGIN
    BEGIN TRY
        UPDATE CandidateAssessments
        SET
            InterviewID = @InterviewID,
            InterviewerID = @InterviewerID,
            AssessmentDate = @AssessmentDate,
            Rating = @Rating,
            Comments = @Comments
        WHERE AssessmentID = @AssessmentID;
    END TRY
    BEGIN CATCH
        SELECT ERROR_MESSAGE() AS ErrorMessage;
    END CATCH
END;

-- Процедура для удаления оценок кандидатов после собеседования
CREATE PROCEDURE DeleteCandidateAssessment
    @AssessmentID INT
AS
BEGIN
    BEGIN TRY
        DELETE FROM CandidateAssessments
        WHERE AssessmentID = @AssessmentID;
    END TRY
    BEGIN CATCH
        SELECT ERROR_MESSAGE() AS ErrorMessage;
    END CATCH
END;
--Процедура добавления контанктных данных для интервьюеров
CREATE PROCEDURE InsertInterviewerContactInfo
    @InterviewerID INT,
    @ContactInfo NVARCHAR(255)
AS
BEGIN
    BEGIN TRY
        INSERT INTO InterviewerContactInfo (InterviewerID, ContactInfo)
        VALUES (@InterviewerID, @ContactInfo);
    END TRY
    BEGIN CATCH
        SELECT ERROR_MESSAGE() AS ErrorMessage;
    END CATCH
END;
-- Процедура для обновления контактной информации собеседователей
CREATE PROCEDURE UpdateInterviewerContactInfo
    @ContactInfoID INT,
    @InterviewerID INT,
    @ContactInfo NVARCHAR(255)
AS
BEGIN
    BEGIN TRY
        UPDATE InterviewerContactInfo
        SET
            InterviewerID = @InterviewerID,
            ContactInfo = @ContactInfo
        WHERE ContactInfoID = @ContactInfoID;
    END TRY
    BEGIN CATCH
        SELECT ERROR_MESSAGE() AS ErrorMessage;
    END CATCH
END;

-- Процедура для удаления контактной информации собеседователей
CREATE PROCEDURE DeleteInterviewerContactInfo
    @ContactInfoID INT
AS
BEGIN
    BEGIN TRY
        DELETE FROM InterviewerContactInfo
        WHERE ContactInfoID = @ContactInfoID;
    END TRY
    BEGIN CATCH
        SELECT ERROR_MESSAGE() AS ErrorMessage;
    END CATCH
END;

-- Процедура для добавления информации о языках
CREATE PROCEDURE InsertLanguage
    @LanguageName NVARCHAR(255)
AS
BEGIN
    BEGIN TRY
        INSERT INTO Languages (LanguageName)
        VALUES (@LanguageName);
    END TRY
    BEGIN CATCH
        SELECT ERROR_MESSAGE() AS ErrorMessage;
    END CATCH
END;
--Обновление языка 
CREATE PROCEDURE UpdateLanguage
    @LanguageID INT,
    @LanguageName NVARCHAR(255)
AS
BEGIN
    BEGIN TRY
        UPDATE Languages
        SET LanguageName = @LanguageName
        WHERE LanguageID = @LanguageID;
    END TRY
    BEGIN CATCH
        SELECT ERROR_MESSAGE() AS ErrorMessage;
    END CATCH
END;
--Удаление языка
CREATE PROCEDURE DeleteLanguage
    @LanguageID INT
AS
BEGIN
    BEGIN TRY
        DELETE FROM Languages
        WHERE LanguageID = @LanguageID;
    END TRY
    BEGIN CATCH
        SELECT ERROR_MESSAGE() AS ErrorMessage;
    END CATCH
END;
-- Процедура для добавления информации о владении языками кандидатом
CREATE PROCEDURE InsertCandidateLanguage
    @LanguageID INT,
    @CandidateID INT,
    @Level NVARCHAR(255)
AS
BEGIN
    BEGIN TRY
        INSERT INTO CandidateLanguage (LanguageID, CandidateID, Level)
        VALUES (@LanguageID, @CandidateID, @Level);
    END TRY
    BEGIN CATCH
        SELECT ERROR_MESSAGE() AS ErrorMessage;
    END CATCH
END;
-- Процедура для обновления информации о языковых навыках кандидатов
CREATE PROCEDURE UpdateCandidateLanguage
    @CandidateLanguageID INT,
    @LanguageID INT,
    @CandidateID INT,
    @Level NVARCHAR(255)
AS
BEGIN
    BEGIN TRY
        UPDATE CandidateLanguage
        SET
            LanguageID = @LanguageID,
            CandidateID = @CandidateID,
            Level = @Level
        WHERE CandidateLanguageID = @CandidateLanguageID;
    END TRY
    BEGIN CATCH
        SELECT ERROR_MESSAGE() AS ErrorMessage;
    END CATCH
END;

-- Процедура для удаления информации о языковых навыках кандидатов
CREATE PROCEDURE DeleteCandidateLanguage
    @CandidateLanguageID INT
AS
BEGIN
    BEGIN TRY
        DELETE FROM CandidateLanguage
        WHERE CandidateLanguageID = @CandidateLanguageID;
    END TRY
    BEGIN CATCH
        SELECT ERROR_MESSAGE() AS ErrorMessage;
    END CATCH
END;

-- Процедура для добавления информации о программных языках
CREATE PROCEDURE InsertProgLang
    @ProgLangName NVARCHAR(255)
AS
BEGIN
    BEGIN TRY
        INSERT INTO ProgLang (ProgLangName)
        VALUES (@ProgLangName);
    END TRY
    BEGIN CATCH
        SELECT ERROR_MESSAGE() AS ErrorMessage;
    END CATCH
END;
--Обновление языка программирования
CREATE PROCEDURE UpdateProgLang
    @ProgLangID INT,
    @ProgLangName NVARCHAR(255)
AS
BEGIN
    BEGIN TRY
        UPDATE ProgLang
        SET ProgLangName = @ProgLangName
        WHERE ProgLangID = @ProgLangID;
    END TRY
    BEGIN CATCH
        SELECT ERROR_MESSAGE() AS ErrorMessage;
    END CATCH
END;
--Удаление языка программирования
CREATE PROCEDURE DeleteProgLang
    @ProgLangID INT
AS
BEGIN
    BEGIN TRY
        DELETE FROM ProgLang
        WHERE ProgLangID = @ProgLangID;
    END TRY
    BEGIN CATCH
        SELECT ERROR_MESSAGE() AS ErrorMessage;
    END CATCH
END;

-- Процедура для добавления информации о владении программными языками кандидатом
CREATE PROCEDURE InsertCandidateProgLang
    @ProgLangID INT,
    @CandidateID INT,
    @Level NVARCHAR(255)
AS
BEGIN
    BEGIN TRY
        INSERT INTO CandidateProgLang (ProgLangID, CandidateID, Level)
        VALUES (@ProgLangID, @CandidateID, @Level);
    END TRY
    BEGIN CATCH
        SELECT ERROR_MESSAGE() AS ErrorMessage;
    END CATCH
END;
-- Процедура для обновления информации о навыках программирования кандидатов
CREATE PROCEDURE UpdateCandidateProgLang
    @CandidateProgLangID INT,
    @ProgLangID INT,
    @CandidateID INT,
    @Level NVARCHAR(255)
AS
BEGIN
    BEGIN TRY
        UPDATE CandidateProgLang
        SET
            ProgLangID = @ProgLangID,
            CandidateID = @CandidateID,
            Level = @Level
        WHERE CandidateProgLangID = @CandidateProgLangID;
    END TRY
    BEGIN CATCH
        SELECT ERROR_MESSAGE() AS ErrorMessage;
    END CATCH
END;

-- Процедура для удаления информации о навыках программирования кандидатов
CREATE PROCEDURE DeleteCandidateProgLang
    @CandidateProgLangID INT
AS
BEGIN
    BEGIN TRY
        DELETE FROM CandidateProgLang
        WHERE CandidateProgLangID = @CandidateProgLangID;
    END TRY
    BEGIN CATCH
        SELECT ERROR_MESSAGE() AS ErrorMessage;
    END CATCH
END;

-- Процедура для добавления документов
CREATE PROCEDURE InsertDocument
    @CandidateID INT,
    @DocumentName NVARCHAR(255),
    @DocumentContent VARBINARY(MAX)
AS
BEGIN
    BEGIN TRY
        INSERT INTO Documents (CandidateID, DocumentName, DocumentContent)
        VALUES (@CandidateID, @DocumentName, @DocumentContent);
    END TRY
    BEGIN CATCH
        SELECT ERROR_MESSAGE() AS ErrorMessage;
    END CATCH
END;
-- Процедура для обновления информации о документах кандидатов
CREATE PROCEDURE UpdateDocument
    @DocumentID INT,
    @CandidateID INT,
    @DocumentName NVARCHAR(255),
    @DocumentContent VARBINARY(MAX)
AS
BEGIN
    BEGIN TRY
        UPDATE Documents
        SET
            CandidateID = @CandidateID,
            DocumentName = @DocumentName,
            DocumentContent = @DocumentContent
        WHERE DocumentID = @DocumentID;
    END TRY
    BEGIN CATCH
        SELECT ERROR_MESSAGE() AS ErrorMessage;
    END CATCH
END;

-- Процедура для удаления информации о документах кандидатов
CREATE PROCEDURE DeleteDocument
    @DocumentID INT
AS
BEGIN
    BEGIN TRY
        DELETE FROM Documents
        WHERE DocumentID = @DocumentID;
    END TRY
    BEGIN CATCH
        SELECT ERROR_MESSAGE() AS ErrorMessage;
    END CATCH
END;

--Отоброжение подробной информации для итервью
CREATE PROCEDURE GetInterviewDetails
    @InterviewID INT
AS
BEGIN
    -- Получить информацию о интервью
    SELECT
        I.InterviewID,
        I.InterviewDateTime,
        I.Location,
        I.InterviewResult,
        I.Parents,
        C.LastName AS CandidateLastName,
        C.FirstName AS CandidateFirstName,
        C.MiddleName AS CandidateMiddleName,
        C.DateOfBirth AS CandidateDateOfBirth,
        C.Gender AS CandidateGender,
        C.Experience AS CandidateExperience,
        C.Source AS CandidateSource,
        C.Status AS CandidateStatus,
        IC.ContactInfo AS CandidateContactInfo,
        IR.InterviewerID AS InterviewerID,
        IR.LastName AS InterviewerLastName,
        IR.FirstName AS InterviewerFirstName
    FROM Interviews I
    INNER JOIN Candidates C ON I.CandidateID = C.CandidateID
    LEFT JOIN CandidateContactInfo IC ON C.CandidateID = IC.CandidateID
    LEFT JOIN InterviewsWithInterviewers IWI ON I.InterviewID = IWI.InterviewID
    LEFT JOIN Interviewers IR ON IWI.InterviewerID = IR.InterviewerID
    WHERE I.InterviewID = @InterviewID;
END;
EXEC GetInterviewDetails @InterviewID = 6;
--Заполнение данными 
EXEC InsertCandidate
    @LastName = 'Smith1',
    @FirstName = 'John1',
    @MiddleName = 'Doe1',
    @DateOfBirth = '1990-01-01',
    @Gender = 'Male',
    @Experience = '5 years',
    @Source = 'LinkedIn',
    @Status = 'Active';
EXEC UpdateCandidate @CandidateID = 3, 
	@LastName = 'Max' ,
	@FirstName = 'John1',
    @MiddleName = 'Doe1',
    @DateOfBirth = '1990-01-01',
    @Gender = 'Male',
    @Experience = '5 years',
    @Source = 'LinkedIn',
    @Status = 'Active';
EXEC InsertCandidate
    @LastName = 'Smith2',
    @FirstName = 'John2',
    @MiddleName = 'Doe2',
    @DateOfBirth = '1990-02-02',
    @Gender = 'Female',
    @Experience = '4 years',
    @Source = 'Referral',
    @Status = 'Active';

EXEC InsertCandidate
    @LastName = 'Smith3',
    @FirstName = 'John3',
    @MiddleName = 'Doe3',
    @DateOfBirth = '1990-03-03',
    @Gender = 'Male',
    @Experience = '6 years',
    @Source = 'LinkedIn',
    @Status = 'Inactive';

EXEC InsertCandidate
    @LastName = 'Smith4',
    @FirstName = 'John4',
    @MiddleName = 'Doe4',
    @DateOfBirth = '1990-04-04',
    @Gender = 'Female',
    @Experience = '7 years',
    @Source = 'Referral',
    @Status = 'Active';

EXEC InsertCandidate
    @LastName = 'Smith5',
    @FirstName = 'John5',
    @MiddleName = 'Doe5',
    @DateOfBirth = '1990-05-05',
    @Gender = 'Male',
    @Experience = '3 years',
    @Source = 'LinkedIn',
    @Status = 'Active';

Select * from Candidates

-- Добавление интервьюеров
EXEC InsertInterviewer
    @LastName = 'Smith1',
    @FirstName = 'John1',
    @Role = 'Senior Interviewer';

EXEC InsertInterviewer
    @LastName = 'Johnson2',
    @FirstName = 'Jane2',
    @Role = 'Junior Interviewer';

EXEC InsertInterviewer
    @LastName = 'Brown3',
    @FirstName = 'David3',
    @Role = 'HR Specialist';

EXEC InsertInterviewer
    @LastName = 'Williams4',
    @FirstName = 'Emma4',
    @Role = 'Technical Interviewer';

EXEC InsertInterviewer
    @LastName = 'Davis5',
    @FirstName = 'Michael5',
    @Role = 'Senior Interviewer';

Select * from Interviewers
-- Добавление вакансий
EXEC InsertVacancy
    @PositionTitle = 'Software Engineer',
    @JobDescription = 'We are looking for a skilled software engineer to join our team.',
    @CreationDate = '2023-01-10',
    @HiringSchedule = '2023-02-15';

EXEC InsertVacancy
    @PositionTitle = 'Data Analyst',
    @JobDescription = 'Seeking a data analyst to analyze and interpret complex data.',
    @CreationDate = '2023-01-12',
    @HiringSchedule = '2023-03-01';

EXEC InsertVacancy
    @PositionTitle = 'Project Manager',
    @JobDescription = 'Looking for an experienced project manager to lead our projects.',
    @CreationDate = '2023-01-14',
    @HiringSchedule = '2023-02-28';

EXEC InsertVacancy
    @PositionTitle = 'Sales Representative',
    @JobDescription = 'Hiring a sales representative to promote and sell our products.',
    @CreationDate = '2023-01-16',
    @HiringSchedule = '2023-03-10';

EXEC InsertVacancy
    @PositionTitle = 'Graphic Designer',
    @JobDescription = 'We need a creative graphic designer to create visual content.',
    @CreationDate = '2023-01-18',
    @HiringSchedule = '2023-02-20';
Select * from Vacancies

-- Добавление интервью
EXEC InsertInterview
    @CandidateID = 3,
    @VacancyID = 1,
    @InterviewDateTime = '2023-01-15 09:00:00',
    @Location = 'Meeting Room 1',
    @InterviewResult = 'Passed',
	@Parents = null;

EXEC InsertInterview
    @CandidateID = 4,
    @VacancyID = 1,
    @InterviewDateTime = '2023-01-16 10:30:00',
    @Location = 'Meeting Room 2',
    @InterviewResult = 'Passed',
	@Parents = null;

EXEC InsertInterview
    @CandidateID = 5,
    @VacancyID = 2,
    @InterviewDateTime = '2023-01-17 14:00:00',
    @Location = 'Meeting Room 3',
    @InterviewResult = 'Pending',
	@Parents = null;

EXEC InsertInterview
    @CandidateID = 6,
    @VacancyID = 2,
    @InterviewDateTime = '2023-01-18 11:15:00',
    @Location = 'Meeting Room 2',
    @InterviewResult = 'Failed',
	@Parents = null;

EXEC InsertInterview
    @CandidateID = 5,
    @VacancyID = 3,
    @InterviewDateTime = '2023-01-19 16:30:00',
    @Location = 'Meeting Room 4',
    @InterviewResult = 'Passed',
	@Parents = null;
Select * from Interviews
-- Создание триггера для таблицы Candidates
CREATE TRIGGER trg_Candidates_Audit
ON Candidates
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    DECLARE @TableName NVARCHAR(255) = 'Candidates';
    DECLARE @OperationType NVARCHAR(10);
    DECLARE @ChangedColumns NVARCHAR(255);
    DECLARE @OldValues NVARCHAR(MAX);
    DECLARE @NewValues NVARCHAR(MAX);
    DECLARE @ChangeDateTime DATETIME = GETDATE();

    IF EXISTS (SELECT * FROM inserted)
    BEGIN
        SET @OperationType = 'INSERT/UPDATE';
        SET @ChangedColumns = (SELECT COLUMN_NAME + ',' FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'Candidates' FOR XML PATH(''));
        SET @OldValues = NULL;
        SET @NewValues = (SELECT * FROM inserted FOR XML RAW, ELEMENTS);
    END
    ELSE
    BEGIN
        SET @OperationType = 'DELETE';
        SET @ChangedColumns = NULL;
        SET @OldValues = (SELECT * FROM deleted FOR XML RAW, ELEMENTS);
        SET @NewValues = NULL;
    END
    INSERT INTO ChangeLog (TableName, OperationType, ChangedColumns, OldValues, NewValues, ChangeDateTime)
    VALUES (@TableName, @OperationType, @ChangedColumns, @OldValues, @NewValues, @ChangeDateTime);
END;

Select * from ChangeLog;

--Представления
--Отображение полной информации о кандидатах
CREATE VIEW CandidateFullInfo AS
SELECT
    C.CandidateID,
    C.LastName,
    C.FirstName,
    C.MiddleName,
    C.DateOfBirth,
    C.Gender,
    C.Experience,
    A.Country,
    A.City,
    A.Street,
    CE.YearOfGraduation AS EducationYearOfGraduation,
    CT.TrainingStartDate,
    CT.TrainingEndDate,
    IA.ApplicationDate,
    CI.ContactInfo AS CandidateContactInfo,
    CL.Level AS LanguageLevel,
    PL.ProgLangName AS ProgrammingLanguage
FROM Candidates AS C
LEFT JOIN Addresses AS A ON C.CandidateID = A.CandidateID
LEFT JOIN CandidatesEducation AS CE ON C.CandidateID = CE.CandidateID
LEFT JOIN CandidatesCoursesAndTraining AS CT ON C.CandidateID = CT.CandidateID
LEFT JOIN JobApplications AS IA ON C.CandidateID = IA.CandidateID
LEFT JOIN CandidateContactInfo AS CI ON C.CandidateID = CI.CandidateID
LEFT JOIN CandidateLanguage AS CL ON C.CandidateID = CL.CandidateID
LEFT JOIN ProgLang AS PL ON CL.LanguageID = PL.ProgLangID;

Select * from CandidateFullInfo;

--Представление для вывода информации об интервью
CREATE VIEW InterviewInfo AS
SELECT
    C.CandidateID,
    C.LastName AS CandidateLastName,
    C.FirstName AS CandidateFirstName,
    I.InterviewID,
    I.InterviewDateTime,
    I.Location AS InterviewLocation,
    I.InterviewResult,
    V.VacancyID,
    V.PositionTitle AS VacancyPositionTitle,
    IWI.InterviewerID,
    IL.LastName AS InterviewerLastName,
    IL.FirstName AS InterviewerFirstName,
    IL.Role AS InterviewerRole
FROM Candidates AS C
INNER JOIN Interviews AS I ON C.CandidateID = I.CandidateID
INNER JOIN Vacancies AS V ON I.VacancyID = V.VacancyID
INNER JOIN InterviewsWithInterviewers AS IWI ON I.InterviewID = IWI.InterviewID
INNER JOIN Interviewers AS IL ON IWI.InterviewerID = IL.InterviewerID;

Select * from InterviewInfo

exec InsertInterviewWithInterviewer @InterviewerID = 5,
    @InterviewID = 9;
Select *  from InterviewsWithInterviewers
Select * from Interviews

-- Представление для информации о согласовании вакансий
CREATE VIEW VacancyApprovalInfo AS
SELECT
    VA.ApprovalID,
    VA.VacancyID,
    VA.ApprovalDate,
    VA.InterviewerID,
    VA.Status,
    V.PositionTitle AS VacancyPositionTitle,
    I.LastName AS InterviewerLastName,
    I.FirstName AS InterviewerFirstName,
    I.Role AS InterviewerRole
FROM VacancyApproval VA
INNER JOIN Vacancies V ON VA.VacancyID = V.VacancyID
INNER JOIN Interviewers I ON VA.InterviewerID = I.InterviewerID;

-- Представление для информации об образовании кандидатов
CREATE VIEW CandidateEducationInfo AS
SELECT
    C.CandidateID,
    C.LastName AS CandidateLastName,
    C.FirstName AS CandidateFirstName,
    CE.YearOfGraduation,
    E.EducationalInstitution,
    E.Specialty
FROM Candidates C
INNER JOIN CandidatesEducation CE ON C.CandidateID = CE.CandidateID
INNER JOIN Education E ON CE.EducationID = E.EducationID;

-- Представление для информации о заявках на вакансии
CREATE VIEW JobApplicationInfo AS
SELECT
    C.CandidateID,
    C.LastName AS CandidateLastName,
    C.FirstName AS CandidateFirstName,
    V.PositionTitle AS VacancyPosition,
    JA.ApplicationDate
FROM Candidates C
INNER JOIN JobApplications JA ON C.CandidateID = JA.CandidateID
INNER JOIN Vacancies V ON JA.VacancyID = V.VacancyID;

-- Представление для информации о языках и уровне кандидатов
CREATE VIEW CandidateLanguageInfo AS
SELECT
    C.CandidateID,
    C.LastName AS CandidateLastName,
    C.FirstName AS CandidateFirstName,
    CL.Level AS LanguageLevel,
    L.LanguageName
FROM Candidates C
INNER JOIN CandidateLanguage CL ON C.CandidateID = CL.CandidateID
INNER JOIN Languages L ON CL.LanguageID = L.LanguageID;

-- Представление для информации о знании программных языков кандидатов
CREATE VIEW CandidateProgrammingLanguageInfo AS
SELECT
    C.CandidateID,
    C.LastName AS CandidateLastName,
    C.FirstName AS CandidateFirstName,
    CPL.Level AS ProgrammingLanguageLevel,
    PL.ProgLangName
FROM Candidates C
INNER JOIN CandidateProgLang CPL ON C.CandidateID = CPL.CandidateID
INNER JOIN ProgLang PL ON CPL.ProgLangID = PL.ProgLangID;


--Индексы 

CREATE NONCLUSTERED INDEX IDX_FK_Addresses_CandidateID
ON Addresses (CandidateID);

CREATE NONCLUSTERED INDEX IDX_FK_CandidatesEducation_CandidateID
ON CandidatesEducation (CandidateID);

CREATE NONCLUSTERED INDEX IDX_FK_CandidatesCoursesAndTraining_CandidateID
ON CandidatesCoursesAndTraining (CandidateID);

CREATE NONCLUSTERED INDEX IDX_FK_JobApplications_CandidateID
ON JobApplications (CandidateID);

CREATE NONCLUSTERED INDEX IDX_FK_CandidateContactInfo_CandidateID
ON CandidateContactInfo (CandidateID);

CREATE NONCLUSTERED INDEX IDX_FK_CandidateLanguage_CandidateID
ON CandidateLanguage (CandidateID);

CREATE NONCLUSTERED INDEX IDX_FK_CandidateProgLang_CandidateID
ON CandidateProgLang (CandidateID);

CREATE NONCLUSTERED INDEX IDX_FK_InterviewInfo_CandidateID
ON Interviews (CandidateID);

CREATE NONCLUSTERED INDEX IDX_FK_InterviewInfo_VacancyID
ON Interviews (VacancyID);


--3 laba 

Select * from Interviews

EXEC InsertInterview
    @CandidateID = 3,
    @VacancyID = 1,
    @InterviewDateTime = '2023-01-15 09:00:00',
    @Location = 'Meeting Room 1',
    @InterviewResult = 'Passed',
	@Parents = 11;

EXEC InsertInterview
    @CandidateID = 4,
    @VacancyID = 1,
    @InterviewDateTime = '2023-01-16 10:30:00',
    @Location = 'Meeting Room 2',
    @InterviewResult = 'Passed',
	@Parents = 12;

EXEC InsertInterview
    @CandidateID = 5,
    @VacancyID = 2,
    @InterviewDateTime = '2023-01-17 14:00:00',
    @Location = 'Meeting Room 3',
    @InterviewResult = 'Pending',
	@Parents = 13;

EXEC InsertInterview
    @CandidateID = 6,
    @VacancyID = 2,
    @InterviewDateTime = '2023-01-18 11:15:00',
    @Location = 'Meeting Room 2',
    @InterviewResult = 'Failed',
	@Parents = 10;

EXEC InsertInterview
    @CandidateID = 5,
    @VacancyID = 3,
    @InterviewDateTime = '2023-01-19 16:30:00',
    @Location = 'Meeting Room 4',
    @InterviewResult = 'Passed',
	@Parents = 8;

CREATE OR ALTER PROCEDURE ParentsInterview
    @p_ParentInterviewID INT
AS
BEGIN
    WITH RecursiveCTE AS (
        SELECT
            InterviewID, CandidateID, VacancyID, InterviewDateTime, Location, InterviewResult, Parents, 1 AS Hierarchy_Level,
            CAST(CONVERT(NVARCHAR(255), InterviewID) AS NVARCHAR(4000)) AS Path
        FROM Interviews
        WHERE InterviewID = @p_ParentInterviewID
        UNION ALL
        SELECT
            I.InterviewID, I.CandidateID, I.VacancyID, I.InterviewDateTime, I.Location, I.InterviewResult, I.Parents, C.Hierarchy_Level + 1,
            CAST(C.Path + N'-' + CONVERT(NVARCHAR(255), I.InterviewID) AS NVARCHAR(4000))
        FROM Interviews AS I
        INNER JOIN RecursiveCTE AS C ON I.Parents = C.InterviewID
    )
    SELECT
        InterviewID, CandidateID, VacancyID, InterviewDateTime, Location, InterviewResult, Parents, Hierarchy_Level, Path
    FROM RecursiveCTE;
END;

Select * from Interviews

EXEC ParentsInterview @p_ParentInterviewID = 1;

CREATE OR ALTER PROCEDURE AddSubParentInterview
    @p_ParentInterviewID INT,
    @p_CandidateID INT,
    @p_VacancyID INT,
    @p_InterviewDateTime DATETIME,
    @p_Location NVARCHAR(255),
    @p_InterviewResult NVARCHAR(255)
AS
BEGIN
    INSERT INTO Interviews (CandidateID, VacancyID, InterviewDateTime, Location, InterviewResult, Parents)
    VALUES (@p_CandidateID, @p_VacancyID, @p_InterviewDateTime, @p_Location, @p_InterviewResult, @p_ParentInterviewID);
END;

EXEC AddSubParentInterview @p_ParentInterviewID = 9, @p_CandidateID = 6, @p_VacancyID = 2, @p_InterviewDateTime = '2023-11-02 15:00:00', @p_Location = 'Meeting Room 5', @p_InterviewResult = 'Pending';

Select * from Interviews

CREATE OR ALTER PROCEDURE MoveInterviewBranch
    @p_SourceInterviewID INT,
    @p_TargetParentInterviewID INT
AS
BEGIN
    -- Обновляем поле Parents для верхнего перемещаемого узла
    UPDATE Interviews
    SET Parents = @p_TargetParentInterviewID
    WHERE InterviewID = @p_SourceInterviewID;

    -- Обновляем поле Parents для всех дочерних интервью
    ;WITH CTE AS (
        SELECT InterviewID
        FROM Interviews
        WHERE InterviewID = @p_SourceInterviewID
        UNION ALL
        SELECT I.InterviewID
        FROM Interviews AS I
        INNER JOIN CTE AS C ON I.Parents = C.InterviewID
    )
    UPDATE I
    SET Parents = @p_TargetParentInterviewID
    FROM Interviews AS I
    INNER JOIN CTE AS C ON I.InterviewID = C.InterviewID;
END;

EXEC MoveInterviewBranch @p_SourceInterviewID = 6, @p_TargetParentInterviewID = 7;

Select * from Interviews

Alter Table Interviews add HierarchyPath hierarchyid;

CREATE PROCEDURE InsertInterview
    @CandidateID INT,
    @VacancyID INT,
    @InterviewDateTime DATETIME,
    @Location NVARCHAR(255),
    @InterviewResult NVARCHAR(255)
AS
BEGIN
    INSERT INTO Interviews (CandidateID, VacancyID, InterviewDateTime, Location, InterviewResult)
    VALUES (@CandidateID, @VacancyID, @InterviewDateTime, @Location, @InterviewResult);
END;
EXEC InsertInterview
    @CandidateID = 3,
    @VacancyID = 1,
    @InterviewDateTime = '2023-01-15 09:00:00',
    @Location = 'Meeting Room 1',
    @InterviewResult = 'Passed';

EXEC InsertInterview
    @CandidateID = 4,
    @VacancyID = 1,
    @InterviewDateTime = '2023-01-16 10:30:00',
    @Location = 'Meeting Room 2',
    @InterviewResult = 'Passed';

EXEC InsertInterview
    @CandidateID = 5,
    @VacancyID = 2,
    @InterviewDateTime = '2023-01-17 14:00:00',
    @Location = 'Meeting Room 3',
    @InterviewResult = 'Pending';

EXEC InsertInterview
    @CandidateID = 6,
    @VacancyID = 2,
    @InterviewDateTime = '2023-01-18 11:15:00',
    @Location = 'Meeting Room 2',
    @InterviewResult = 'Failed';

EXEC InsertInterview
    @CandidateID = 5,
    @VacancyID = 3,
    @InterviewDateTime = '2023-01-19 16:30:00',
    @Location = 'Meeting Room 4',
    @InterviewResult = 'Passed';





CREATE OR ALTER PROCEDURE GetInterviewSubnodes
    @ParentNode hierarchyid
AS
BEGIN
    WITH RecursiveInterviews AS (
        SELECT
            I.CandidateID,
            I.VacancyID,
            I.InterviewDateTime,
            I.Location,
            I.InterviewResult,
            I.HierarchyPath,
            I.HierarchyPath.GetLevel() - @ParentNode.GetLevel() AS Level
        FROM
            Interviews I
        WHERE
            I.HierarchyPath.IsDescendantOf(@ParentNode) = 1
    )
    SELECT
        CandidateID,
        VacancyID,
        InterviewDateTime,
        Location,
        InterviewResult,
        HierarchyPath.ToString() AS HierarchyPath,
        Level
    FROM
        RecursiveInterviews;
END;



DECLARE @Node hierarchyid = '/2/1/1/1/';
EXEC GetInterviewSubnodes @Node;

CREATE OR ALTER PROCEDURE AddInterviewSubnode
    @ParentNode hierarchyid,
    @CandidateID INT,
    @VacancyID INT,
    @InterviewDateTime DATETIME,
    @Location NVARCHAR(255),
    @InterviewResult NVARCHAR(255)
AS
BEGIN
    DECLARE @NewNode hierarchyid;

    -- Получаем новый узел как потомок @ParentNode
    SET @NewNode = @ParentNode.GetDescendant(NULL, NULL);

    -- Вставляем новую запись в таблицу с использованием полученного узла
    INSERT INTO Interviews (CandidateID, VacancyID, InterviewDateTime, Location, InterviewResult, HierarchyPath)
    VALUES (@CandidateID, @VacancyID, @InterviewDateTime, @Location, @InterviewResult, @NewNode);
END;

-- Пример вызова процедуры для добавления подчиненного узла интервью
DECLARE @ParentNode hierarchyid = '/2/1/1/2/';
EXEC AddInterviewSubnode
    @ParentNode,
    @CandidateID = 6,
    @VacancyID = 1,
    @InterviewDateTime = '2023-11-16 10:00:00',
    @Location = 'Conference Room',
    @InterviewResult = 'Passed';

Select * from Interviews

CREATE OR ALTER PROCEDURE MoveInterviewSubtree
    @OldParentNode hierarchyid,
    @NewParentNode hierarchyid
AS
BEGIN
    DECLARE @SubtreeRootNode hierarchyid;

    -- Находим корень перемещаемой подчиненной ветки
    SET @SubtreeRootNode = @OldParentNode.GetAncestor(1);

    -- Получаем иерархическую длину (глубину) подчиненной ветки
    DECLARE @SubtreeDepth INT;
    SET @SubtreeDepth = @SubtreeRootNode.GetLevel();

    -- Вычисляем новый путь для подчиненной ветки
    DECLARE @NewSubtreeRootNode hierarchyid;
    SET @NewSubtreeRootNode = @NewParentNode.GetDescendant(NULL, NULL);

    -- Обновляем записи в таблице, чтобы переместить всю подчиненную ветку
    UPDATE Interviews
    SET HierarchyPath = @NewSubtreeRootNode.ToString() +
                      SUBSTRING(HierarchyPath.ToString(), LEN(@SubtreeRootNode.ToString()) + 1, LEN(HierarchyPath.ToString()))
    WHERE HierarchyPath.IsDescendantOf(@SubtreeRootNode) = 1;

END;



EXEC MoveInterviewSubtree @OldParentNode = '/3/1/1/', @NewParentNode = '/2/1/1/';

Select * from Interviews

--4 laba
