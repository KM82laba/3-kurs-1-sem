Alter database open;
--Главный администратор
GRANT DBA TO ITAdmin;
--Пользователи
CREATE ROLE Candidates;
CREATE ROLE HRManagers;
CREATE ROLE DecisionMakers;
CREATE ROLE Interviewers;s

GRANT CREATE SESSION TO HRManagers, DecisionMakers, Interviewers , Candidates;

-- Роль Candidates может только читать свои статусы и интервью
GRANT SELECT ON Candidates_Data TO Candidates;
GRANT SELECT ON Interviews_Data TO Candidates;

-- Роль HRManagers может управлять вакансиями, заявками и интервью
GRANT SELECT, INSERT, UPDATE, DELETE ON Vacancies_Data TO HRManagers;
GRANT SELECT, INSERT, UPDATE, DELETE ON JobApplications_Data TO HRManagers;
GRANT SELECT, INSERT, UPDATE, DELETE ON Interviews_Data TO HRManagers;
GRANT SELECT, INSERT, UPDATE, DELETE ON VacancyApproval_Data TO HRManagers;
GRANT SELECT, INSERT, UPDATE, DELETE ON InterviewerContactInfo_Data TO HRManagers;

-- Роль DecisionMakers может просматривать информацию о кандидатах и результатах интервью
GRANT SELECT ON Candidates_Data TO DecisionMakers;
GRANT SELECT ON CandidateContactInfo_Data TO DecisionMakers;
GRANT SELECT ON Interviews_Data TO DecisionMakers;
GRANT SELECT ON CandidateAssessments_Data TO DecisionMakers;

-- Роль Interviewers может просматривать информацию о кандидатах и вакансиях
GRANT SELECT ON Candidates_Data TO Interviewers;
GRANT SELECT ON CandidateContactInfo_Data TO Interviewers;
GRANT SELECT ON Vacancies_Data TO Interviewers;
GRANT SELECT ON Languages_Data TO Interviewers;
GRANT SELECT ON CandidateLanguage_Data TO Interviewers;
GRANT SELECT ON ProgLang_Data TO Interviewers;
GRANT SELECT ON CandidateProgLang_Data TO Interviewers;
GRANT SELECT ON Interviews_Data TO Interviewers;

-- Создание пользователей на основе ролей и установка паролей
CREATE USER candidate_user IDENTIFIED BY "1851";
CREATE USER hr_manager_user IDENTIFIED BY "1851";
CREATE USER decision_maker_user IDENTIFIED BY "1851";
CREATE USER interviewer_user IDENTIFIED BY "1851";

-- Назначение ролей соответствующим пользователям
GRANT Candidates TO candidate_user;
GRANT HRManagers TO hr_manager_user;
GRANT DecisionMakers TO decision_maker_user;
GRANT Interviewers TO interviewer_user;

-- Создание последовательностей: 
-- Создание последовательности для Candidates
CREATE SEQUENCE CandidateID_Seq START WITH 1 INCREMENT BY 1;
-- Создание последовательности для Addresses
CREATE SEQUENCE AddressID_Seq START WITH 1 INCREMENT BY 1;

-- Создание последовательности для Education
CREATE SEQUENCE EducationID_Seq START WITH 1 INCREMENT BY 1;

-- Создание последовательности для CoursesAndTraining
CREATE SEQUENCE CourseID_Seq START WITH 1 INCREMENT BY 1;

-- Создание последовательности для Vacancies
CREATE SEQUENCE VacancyID_Seq START WITH 1 INCREMENT BY 1;

-- Создание последовательности для JobApplications
CREATE SEQUENCE ApplicationID_Seq START WITH 1 INCREMENT BY 1;

-- Создание последовательности для Interviews
CREATE SEQUENCE InterviewID_Seq START WITH 1 INCREMENT BY 1;

-- Создание последовательности для CandidateContactInfo
CREATE SEQUENCE ContactInfoID_Seq START WITH 1 INCREMENT BY 1;

-- Создание последовательности для Interviewers
CREATE SEQUENCE InterviewerID_Seq START WITH 1 INCREMENT BY 1;

-- Создание последовательности для VacancyApproval
CREATE SEQUENCE ApprovalID_Seq START WITH 1 INCREMENT BY 1;

-- Создание последовательности для InterviewsWithInterviewers
CREATE SEQUENCE InterviewWithInterviewerID_Seq START WITH 1 INCREMENT BY 1;

-- Создание последовательности для InterviewerContactInfo
CREATE SEQUENCE InterviewerContactInfoID_Seq START WITH 1 INCREMENT BY 1;

-- Создание последовательности для CandidateAssessments
CREATE SEQUENCE AssessmentID_Seq START WITH 1 INCREMENT BY 1;

-- Создание последовательности для Languages
CREATE SEQUENCE LanguageID_Seq START WITH 1 INCREMENT BY 1;

-- Создание последовательности для ProgLang
CREATE SEQUENCE ProgLangID_Seq START WITH 1 INCREMENT BY 1;

-- Создание последовательности для Documents
CREATE SEQUENCE DocumentID_Seq START WITH 1 INCREMENT BY 1;

-- Создание последовательности для ChangeLog
CREATE SEQUENCE RecordID_Seq START WITH 1 INCREMENT BY 1;

-- Создание последовательности для CandidatesEducation
CREATE SEQUENCE CandidatesEducationID_Seq START WITH 1 INCREMENT BY 1;

-- Создание последовательности для CandidatesCoursesAndTraining
CREATE SEQUENCE CandidatesCoursesAndTrainingID_Seq START WITH 1 INCREMENT BY 1;

-- Создание последовательности для CandidateLanguage
CREATE SEQUENCE CandidateLanguageID_Seq START WITH 1 INCREMENT BY 1;

-- Создание последовательности для CandidateProgLang
CREATE SEQUENCE CandidateProgLangID_Seq START WITH 1 INCREMENT BY 1;
--создание таблиц
CREATE TABLE Candidates (
    CandidateID NUMBER DEFAULT CandidateID_Seq.NEXTVAL PRIMARY KEY,
    LastName NVARCHAR2(255),
    FirstName NVARCHAR2(255),
    MiddleName NVARCHAR2(255),
    DateOfBirth DATE,
    Gender NVARCHAR2(10),
    Experience NVARCHAR2(255),
    Source NVARCHAR2(255),
    Status NVARCHAR2(255)
);

CREATE TABLE Addresses (
    AddressID NUMBER DEFAULT AddressID_Seq.NEXTVAL PRIMARY KEY,
    Country NVARCHAR2(255),
    City NVARCHAR2(255),
    Street NVARCHAR2(255),
    CandidateID NUMBER,
    FOREIGN KEY (CandidateID) REFERENCES Candidates (CandidateID)
);

CREATE TABLE Education (
    EducationID NUMBER DEFAULT EducationID_Seq.NEXTVAL PRIMARY KEY,
    EducationalInstitution NVARCHAR2(255),
    Specialty NVARCHAR2(255)
);

CREATE TABLE CandidatesEducation (
    CandidatesEducationID NUMBER DEFAULT CandidatesEducationID_Seq.NEXTVAL PRIMARY KEY,
    YearOfGraduation DATE,
    EducationID NUMBER,
    CandidateID NUMBER,
    FOREIGN KEY (EducationID) REFERENCES Education (EducationID),
    FOREIGN KEY (CandidateID) REFERENCES Candidates (CandidateID)
);

CREATE TABLE CoursesAndTraining (
    CourseID NUMBER DEFAULT CourseID_Seq.NEXTVAL PRIMARY KEY,
    CourseName NVARCHAR2(255),
    CourseDescription NVARCHAR2(400),
    Organization NVARCHAR2(255)
);

CREATE TABLE CandidatesCoursesAndTraining (
    CandidatesCoursesAndTrainingID NUMBER DEFAULT CandidatesCoursesAndTrainingID_Seq.NEXTVAL PRIMARY KEY,
    TrainingStartDate DATE,
    TrainingEndDate DATE,
    CourseID NUMBER,
    CandidateID NUMBER,
    FOREIGN KEY (CourseID) REFERENCES CoursesAndTraining (CourseID),
    FOREIGN KEY (CandidateID) REFERENCES Candidates (CandidateID)
);

CREATE TABLE Vacancies (
    VacancyID NUMBER DEFAULT VacancyID_Seq.NEXTVAL PRIMARY KEY,
    PositionTitle NVARCHAR2(255),
    JobDescription NVARCHAR2(400),
    CreationDate DATE,
    HiringSchedule DATE
);

CREATE TABLE JobApplications (
    ApplicationID NUMBER DEFAULT ApplicationID_Seq.NEXTVAL PRIMARY KEY,
    CandidateID NUMBER,
    VacancyID NUMBER,
    ApplicationDate DATE,
    FOREIGN KEY (CandidateID) REFERENCES Candidates (CandidateID),
    FOREIGN KEY (VacancyID) REFERENCES Vacancies (VacancyID)
);

CREATE TABLE Interviews (
    InterviewID NUMBER DEFAULT InterviewID_Seq.NEXTVAL PRIMARY KEY,
    CandidateID NUMBER,
    VacancyID NUMBER,
    InterviewDateTime DATE,
    Location NVARCHAR2(255),
    InterviewResult NVARCHAR2(255),
    Parents NUMBER,
    FOREIGN KEY (CandidateID) REFERENCES Candidates (CandidateID),
    FOREIGN KEY (VacancyID) REFERENCES Vacancies (VacancyID),
    FOREIGN KEY (Parents) REFERENCES Interviews (InterviewID)
);

CREATE TABLE CandidateContactInfo (
    ContactInfoID NUMBER DEFAULT ContactInfoID_Seq.NEXTVAL PRIMARY KEY,
    CandidateID NUMBER,
    ContactInfo NVARCHAR2(255),
    FOREIGN KEY (CandidateID) REFERENCES Candidates (CandidateID)
);

CREATE TABLE Interviewers (
    InterviewerID NUMBER DEFAULT InterviewerID_Seq.NEXTVAL PRIMARY KEY,
    LastName NVARCHAR2(255),
    FirstName NVARCHAR2(255),
    Role NVARCHAR2(255)
);

CREATE TABLE VacancyApproval (
    ApprovalID NUMBER DEFAULT ApprovalID_Seq.NEXTVAL PRIMARY KEY,
    VacancyID NUMBER,
    ApprovalDate DATE,
    InterviewerID NUMBER,
    Status NVARCHAR2(255),
    FOREIGN KEY (VacancyID) REFERENCES Vacancies (VacancyID),
    FOREIGN KEY (InterviewerID) REFERENCES Interviewers (InterviewerID)
);

CREATE TABLE InterviewsWithInterviewers (
    InterviewWithInterviewerID NUMBER DEFAULT InterviewWithInterviewerID_Seq.NEXTVAL PRIMARY KEY,
    InterviewerID NUMBER,
    InterviewID NUMBER,
    FOREIGN KEY (InterviewerID) REFERENCES Interviewers (InterviewerID),
    FOREIGN KEY (InterviewID) REFERENCES Interviews (InterviewID)
);

CREATE TABLE InterviewerContactInfo (
    ContactInfoID NUMBER DEFAULT ContactInfoID_Seq.NEXTVAL PRIMARY KEY,
    InterviewerID NUMBER,
    ContactInfo NVARCHAR2(255),
    FOREIGN KEY (InterviewerID) REFERENCES Interviewers (InterviewerID)
);

CREATE TABLE CandidateAssessments (
    AssessmentID NUMBER DEFAULT AssessmentID_Seq.NEXTVAL PRIMARY KEY,
    InterviewID NUMBER,
    InterviewerID NUMBER,
    AssessmentDate DATE,
    Rating NUMBER,
    Comments NVARCHAR2(1000),
    FOREIGN KEY (InterviewID) REFERENCES Interviews (InterviewID),
    FOREIGN KEY (InterviewerID) REFERENCES Interviewers (InterviewerID)
);

CREATE TABLE Languages (
    LanguageID NUMBER DEFAULT LanguageID_Seq.NEXTVAL PRIMARY KEY,
    LanguageName NVARCHAR2(255)
);

CREATE TABLE CandidateLanguage (
    CandidateLanguageID NUMBER DEFAULT CandidateLanguageID_Seq.NEXTVAL PRIMARY KEY,
    LanguageID NUMBER,
    CandidateID NUMBER,
    Level_ NVARCHAR2(255),
    FOREIGN KEY (LanguageID) REFERENCES Languages (LanguageID),
    FOREIGN KEY (CandidateID) REFERENCES Candidates (CandidateID)
);

CREATE TABLE ProgLang (
    ProgLangID NUMBER DEFAULT ProgLangID_Seq.NEXTVAL PRIMARY KEY,
    ProgLangName NVARCHAR2(255)
);

CREATE TABLE CandidateProgLang (
    CandidateProgLangID NUMBER DEFAULT CandidateProgLangID_Seq.NEXTVAL PRIMARY KEY,
    ProgLangID NUMBER,
    CandidateID NUMBER,
    Level_ NVARCHAR2(255),
    FOREIGN KEY (ProgLangID) REFERENCES ProgLang (ProgLangID),
    FOREIGN KEY (CandidateID) REFERENCES Candidates (CandidateID)
);

CREATE TABLE Documents (
    DocumentID NUMBER DEFAULT DocumentID_Seq.NEXTVAL PRIMARY KEY,
    CandidateID NUMBER,
    DocumentName NVARCHAR2(255),
    DocumentContent BLOB,
    FOREIGN KEY (CandidateID) REFERENCES Candidates (CandidateID)
);

CREATE TABLE ChangeLog (
    RecordID NUMBER DEFAULT RecordID_Seq.NEXTVAL PRIMARY KEY,
    TableName NVARCHAR2(255),
    OperationType NVARCHAR2(10),
    ChangedColumns NVARCHAR2(255),
    OldValues NVARCHAR2(401),
    NewValues NVARCHAR2(401),
    ChangeDateTime DATE
);
-- Синонимы 
CREATE SYNONYM Candidates_Data FOR ITAdmin.Candidates;
CREATE SYNONYM Addresses_Data FOR ITAdmin.Addresses;
CREATE SYNONYM Education_Data FOR ITAdmin.Education;
CREATE SYNONYM CandidatesEducation_Data FOR ITAdmin.CandidatesEducation;
CREATE SYNONYM CoursesAndTraining_Data FOR ITAdmin.CoursesAndTraining;
CREATE SYNONYM CandidatesCoursesAndTraining_Data FOR ITAdmin.CandidatesCoursesAndTraining;
CREATE SYNONYM Vacancies_Data FOR ITAdmin.Vacancies;
CREATE SYNONYM JobApplications_Data FOR ITAdmin.JobApplications;
CREATE SYNONYM Interviews_Data FOR ITAdmin.Interviews;
CREATE SYNONYM CandidateContactInfo_Data FOR ITAdmin.CandidateContactInfo;
CREATE SYNONYM Interviewers_Data FOR ITAdmin.Interviewers;
CREATE SYNONYM VacancyApproval_Data FOR ITAdmin.VacancyApproval;
CREATE SYNONYM InterviewsWithInterviewers_Data FOR ITAdmin.InterviewsWithInterviewers;
CREATE SYNONYM InterviewerContactInfo_Data FOR ITAdmin.InterviewerContactInfo;
CREATE SYNONYM CandidateAssessments_Data FOR ITAdmin.CandidateAssessments;
CREATE SYNONYM Languages_Data FOR ITAdmin.Languages;
CREATE SYNONYM CandidateLanguage_Data FOR ITAdmin.CandidateLanguage;
CREATE SYNONYM ProgLang_Data FOR ITAdmin.ProgLang;
CREATE SYNONYM CandidateProgLang_Data FOR ITAdmin.CandidateProgLang;
CREATE SYNONYM Documents_Data FOR ITAdmin.Documents;
CREATE SYNONYM ChangeLog_Data FOR ITAdmin.ChangeLog;

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
--Процедуры:
-- Процедура для добавления данных о кандидатах
CREATE OR REPLACE PROCEDURE InsertCandidate(
    p_LastName NVARCHAR2,
    p_FirstName NVARCHAR2,
    p_MiddleName NVARCHAR2,
    p_DateOfBirth DATE,
    p_Gender NVARCHAR2,
    p_Experience NVARCHAR2,
    p_Source NVARCHAR2,
    p_Status NVARCHAR2
) AS
BEGIN
    BEGIN
        INSERT INTO Candidates (LastName, FirstName, MiddleName, DateOfBirth, Gender, Experience, Source, Status)
        VALUES (p_LastName, p_FirstName, p_MiddleName, p_DateOfBirth, p_Gender, p_Experience, p_Source, p_Status);
    EXCEPTION
        WHEN OTHERS THEN
            -- Обработка ошибок
            DBMS_OUTPUT.PUT_LINE(SQLERRM);
    END;
END InsertCandidate;

-- Процедура для обновления данных о кандидатах
CREATE OR REPLACE PROCEDURE UpdateCandidate(
    p_CandidateID NUMBER,
    p_LastName NVARCHAR2,
    p_FirstName NVARCHAR2,
    p_MiddleName NVARCHAR2,
    p_DateOfBirth DATE,
    p_Gender NVARCHAR2,
    p_Experience NVARCHAR2,
    p_Source NVARCHAR2,
    p_Status NVARCHAR2
) AS
BEGIN
    BEGIN
        UPDATE Candidates
        SET
            LastName = p_LastName,
            FirstName = p_FirstName,
            MiddleName = p_MiddleName,
            DateOfBirth = p_DateOfBirth,
            Gender = p_Gender,
            Experience = p_Experience,
            Source = p_Source,
            Status = p_Status
        WHERE CandidateID = p_CandidateID;
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE(SQLERRM);
    END;
END UpdateCandidate;

-- Процедура для удаления данных о кандидатах
CREATE OR REPLACE PROCEDURE DeleteCandidate(p_CandidateID NUMBER) AS
BEGIN
    BEGIN
        DELETE FROM Candidates
        WHERE CandidateID = p_CandidateID;
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE(SQLERRM);
    END;
END DeleteCandidate;

-- Процедура для добавления адреса
CREATE OR REPLACE PROCEDURE InsertAddress(
    p_Country NVARCHAR2,
    p_City NVARCHAR2,
    p_Street NVARCHAR2,
    p_CandidateID NUMBER
) AS
BEGIN
    BEGIN
        INSERT INTO Addresses (Country, City, Street, CandidateID)
        VALUES (p_Country, p_City, p_Street, p_CandidateID);
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE(SQLERRM);
    END;
END InsertAddress;

-- Процедура для обновления данных об адресах
CREATE OR REPLACE PROCEDURE UpdateAddress(
    p_AddressID NUMBER,
    p_Country NVARCHAR2,
    p_City NVARCHAR2,
    p_Street NVARCHAR2
) AS
BEGIN
    BEGIN
        UPDATE Addresses
        SET
            Country = p_Country,
            City = p_City,
            Street = p_Street
        WHERE AddressID = p_AddressID;
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE(SQLERRM);
    END;
END UpdateAddress;

-- Процедура для удаления данных об адресах
CREATE OR REPLACE PROCEDURE DeleteAddress(p_AddressID NUMBER) AS
BEGIN
    BEGIN
        DELETE FROM Addresses
        WHERE AddressID = p_AddressID;
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE(SQLERRM);
    END;
END DeleteAddress;

-- Процедура для добавления образования
CREATE OR REPLACE PROCEDURE InsertEducation(
    p_EducationalInstitution NVARCHAR2,
    p_Specialty NVARCHAR2
) AS
BEGIN
    BEGIN
        INSERT INTO Education (EducationalInstitution, Specialty)
        VALUES (p_EducationalInstitution, p_Specialty);
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE(SQLERRM);
    END;
END InsertEducation;

-- Процедура для обновления данных об образовании
CREATE OR REPLACE PROCEDURE UpdateEducation(
    p_EducationID NUMBER,
    p_EducationalInstitution NVARCHAR2,
    p_Specialty NVARCHAR2
) AS
BEGIN
    BEGIN
        UPDATE Education
        SET
            EducationalInstitution = p_EducationalInstitution,
            Specialty = p_Specialty
        WHERE EducationID = p_EducationID;
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE(SQLERRM);
    END;
END UpdateEducation;

-- Процедура для удаления данных об образовании
CREATE OR REPLACE PROCEDURE DeleteEducation(p_EducationID NUMBER) AS
BEGIN
    BEGIN
        DELETE FROM Education
        WHERE EducationID = p_EducationID;
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE(SQLERRM);
    END;
END DeleteEducation;
-- Процедура для добавления данных о курсах и тренингах
CREATE OR REPLACE PROCEDURE InsertCoursesAndTraining(
    p_CourseName NVARCHAR2,
    p_CourseDescription NCLOB,
    p_Organization NVARCHAR2
) AS
BEGIN
    BEGIN
        INSERT INTO CoursesAndTraining (CourseName, CourseDescription, Organization)
        VALUES (p_CourseName, p_CourseDescription, p_Organization);
    EXCEPTION
        WHEN OTHERS THEN
            -- Обработка ошибок
            DBMS_OUTPUT.PUT_LINE(SQLERRM);
    END;
END InsertCoursesAndTraining;

-- Процедура для обновления данных о курсах и тренингах кандидатов
CREATE OR REPLACE PROCEDURE UpdateCandidateCoursesAndTraining(
    p_CandidatesCoursesAndTrainingID NUMBER,
    p_TrainingStartDate DATE,
    p_TrainingEndDate DATE,
    p_CourseID NUMBER,
    p_CandidateID NUMBER
) AS
BEGIN
    BEGIN
        UPDATE CandidatesCoursesAndTraining
        SET
            TrainingStartDate = p_TrainingStartDate,
            TrainingEndDate = p_TrainingEndDate,
            CourseID = p_CourseID,
            CandidateID = p_CandidateID
        WHERE CandidatesCoursesAndTrainingID = p_CandidatesCoursesAndTrainingID;
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE(SQLERRM);
    END;
END UpdateCandidateCoursesAndTraining;

-- Процедура для удаления данных о курсах и тренингах кандидатов
CREATE OR REPLACE PROCEDURE DeleteCandidateCoursesAndTraining(p_CandidatesCoursesAndTrainingID NUMBER) AS
BEGIN
    BEGIN
        DELETE FROM CandidatesCoursesAndTraining
        WHERE CandidatesCoursesAndTrainingID = p_CandidatesCoursesAndTrainingID;
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE(SQLERRM);
    END;
END DeleteCandidateCoursesAndTraining;

-- Процедура для добавления обучения кандидатов
CREATE OR REPLACE PROCEDURE InsertCandidatesEducation(
    p_YearOfGraduation DATE,
    p_EducationID NUMBER,
    p_CandidateID NUMBER
) AS
BEGIN
    BEGIN
        INSERT INTO CandidatesEducation (YearOfGraduation, EducationID, CandidateID)
        VALUES (p_YearOfGraduation, p_EducationID, p_CandidateID);
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE(SQLERRM);
    END;
END InsertCandidatesEducation;

-- Процедура для обновления данных об образовании кандидатов
CREATE OR REPLACE PROCEDURE UpdateCandidateEducation(
    p_CandidatesEducationID NUMBER,
    p_YearOfGraduation DATE,
    p_EducationID NUMBER,
    p_CandidateID NUMBER
) AS
BEGIN
    BEGIN
        UPDATE CandidatesEducation
        SET
            YearOfGraduation = p_YearOfGraduation,
            EducationID = p_EducationID,
            CandidateID = p_CandidateID
        WHERE CandidatesEducationID = p_CandidatesEducationID;
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE(SQLERRM);
    END;
END UpdateCandidateEducation;

-- Процедура для удаления данных об образовании кандидатов
CREATE OR REPLACE PROCEDURE DeleteCandidateEducation(p_CandidatesEducationID NUMBER) AS
BEGIN
    BEGIN
        DELETE FROM CandidatesEducation
        WHERE CandidatesEducationID = p_CandidatesEducationID;
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE(SQLERRM);
    END;
END DeleteCandidateEducation;

-- Процедура для добавления вакансии
CREATE OR REPLACE PROCEDURE InsertVacancy(
    p_PositionTitle NVARCHAR2,
    p_JobDescription NCLOB,
    p_CreationDate DATE,
    p_HiringSchedule DATE
) AS
BEGIN
    BEGIN
        INSERT INTO Vacancies (PositionTitle, JobDescription, CreationDate, HiringSchedule)
        VALUES (p_PositionTitle, p_JobDescription, p_CreationDate, p_HiringSchedule);
    EXCEPTION
        WHEN OTHERS THEN
            -- Обработка ошибок
            DBMS_OUTPUT.PUT_LINE(SQLERRM);
    END;
END InsertVacancy;

-- Процедура для обновления данных о вакансиях
CREATE OR REPLACE PROCEDURE UpdateVacancy(
    p_VacancyID NUMBER,
    p_PositionTitle NVARCHAR2,
    p_JobDescription NCLOB,
    p_CreationDate DATE,
    p_HiringSchedule DATE
) AS
BEGIN
    BEGIN
        UPDATE Vacancies
        SET
            PositionTitle = p_PositionTitle,
            JobDescription = p_JobDescription,
            CreationDate = p_CreationDate,
            HiringSchedule = p_HiringSchedule
        WHERE VacancyID = p_VacancyID;
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE(SQLERRM);
    END;
END UpdateVacancy;

-- Процедура для удаления данных о вакансиях
CREATE OR REPLACE PROCEDURE DeleteVacancy(p_VacancyID NUMBER) AS
BEGIN
    BEGIN
        DELETE FROM Vacancies
        WHERE VacancyID = p_VacancyID;
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE(SQLERRM);
    END;
END DeleteVacancy;

-- Процедура для добавления собеседования
CREATE OR REPLACE PROCEDURE InsertInterview(
    p_CandidateID NUMBER,
    p_VacancyID NUMBER,
    p_InterviewDateTime TIMESTAMP,
    p_Location NVARCHAR2,
    p_InterviewResult NVARCHAR2,
    p_Parents NUMBER
) AS
BEGIN
    BEGIN
        INSERT INTO Interviews (CandidateID, VacancyID, InterviewDateTime, Location, InterviewResult, Parents)
        VALUES (p_CandidateID, p_VacancyID, p_InterviewDateTime, p_Location, p_InterviewResult, p_Parents);
    EXCEPTION
        WHEN OTHERS THEN
            -- Обработка ошибок
            DBMS_OUTPUT.PUT_LINE(SQLERRM);
    END;
END InsertInterview;

-- Процедура для обновления данных о собеседованиях
CREATE OR REPLACE PROCEDURE UpdateInterview(
    p_InterviewID NUMBER,
    p_CandidateID NUMBER,
    p_VacancyID NUMBER,
    p_InterviewDateTime TIMESTAMP,
    p_Location NVARCHAR2,
    p_InterviewResult NVARCHAR2,
    p_Parents NUMBER
) AS
BEGIN
    BEGIN
        UPDATE Interviews
        SET
            CandidateID = p_CandidateID,
            VacancyID = p_VacancyID,
            InterviewDateTime = p_InterviewDateTime,
            Location = p_Location,
            InterviewResult = p_InterviewResult,
            Parents = p_Parents
        WHERE InterviewID = p_InterviewID;
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE(SQLERRM);
    END;
END UpdateInterview;

-- Процедура для удаления данных о собеседованиях
CREATE OR REPLACE PROCEDURE DeleteInterview(p_InterviewID NUMBER) AS
BEGIN
    BEGIN
        DELETE FROM Interviews
        WHERE InterviewID = p_InterviewID;
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE(SQLERRM);
    END;
END DeleteInterview;

-- Процедура для добавления заявки на работу
CREATE OR REPLACE PROCEDURE InsertJobApplication(
    p_CandidateID NUMBER,
    p_VacancyID NUMBER,
    p_ApplicationDate TIMESTAMP
) AS
BEGIN
    BEGIN
        INSERT INTO JobApplications (CandidateID, VacancyID, ApplicationDate)
        VALUES (p_CandidateID, p_VacancyID, p_ApplicationDate);
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE(SQLERRM);
    END;
END InsertJobApplication;
-- Процедура для добавления информации о контакте кандидата
CREATE OR REPLACE PROCEDURE InsertCandidateContactInfo(
    p_CandidateID NUMBER,
    p_ContactInfo NVARCHAR2
) AS
BEGIN
    BEGIN
        INSERT INTO CandidateContactInfo (CandidateID, ContactInfo)
        VALUES (p_CandidateID, p_ContactInfo);
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            -- Обработка ошибок
            ROLLBACK;
            DBMS_OUTPUT.PUT_LINE(SQLERRM);
    END;
END InsertCandidateContactInfo;

-- Процедура для обновления контактной информации кандидатов
CREATE OR REPLACE PROCEDURE UpdateCandidateContactInfo(
    p_ContactInfoID NUMBER,
    p_CandidateID NUMBER,
    p_ContactInfo NVARCHAR2
) AS
BEGIN
    BEGIN
        UPDATE CandidateContactInfo
        SET
            CandidateID = p_CandidateID,
            ContactInfo = p_ContactInfo
        WHERE ContactInfoID = p_ContactInfoID;
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            DBMS_OUTPUT.PUT_LINE(SQLERRM);
    END;
END UpdateCandidateContactInfo;

-- Процедура для удаления контактной информации кандидатов
CREATE OR REPLACE PROCEDURE DeleteCandidateContactInfo(p_ContactInfoID NUMBER) AS
BEGIN
    BEGIN
        DELETE FROM CandidateContactInfo
        WHERE ContactInfoID = p_ContactInfoID;
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            DBMS_OUTPUT.PUT_LINE(SQLERRM);
    END;
END DeleteCandidateContactInfo;

-- Процедура для добавления информации о собеседователе
CREATE OR REPLACE PROCEDURE InsertInterviewer(
    p_LastName NVARCHAR2,
    p_FirstName NVARCHAR2,
    p_Role NVARCHAR2
) AS
BEGIN
    BEGIN
        INSERT INTO Interviewers (LastName, FirstName, Role)
        VALUES (p_LastName, p_FirstName, p_Role);
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            DBMS_OUTPUT.PUT_LINE(SQLERRM);
    END;
END InsertInterviewer;

-- Процедура для обновления информации о собеседователях
CREATE OR REPLACE PROCEDURE UpdateInterviewer(
    p_InterviewerID NUMBER,
    p_LastName NVARCHAR2,
    p_FirstName NVARCHAR2,
    p_Role NVARCHAR2
) AS
BEGIN
    BEGIN
        UPDATE Interviewers
        SET
            LastName = p_LastName,
            FirstName = p_FirstName,
            Role = p_Role
        WHERE InterviewerID = p_InterviewerID;
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            DBMS_OUTPUT.PUT_LINE(SQLERRM);
    END;
END UpdateInterviewer;

-- Процедура для удаления информации о собеседователях
CREATE OR REPLACE PROCEDURE DeleteInterviewer(p_InterviewerID NUMBER) AS
BEGIN
    BEGIN
        DELETE FROM Interviewers
        WHERE InterviewerID = p_InterviewerID;
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            DBMS_OUTPUT.PUT_LINE(SQLERRM);
    END;
END DeleteInterviewer;

-- Процедура для добавления информации о решении по вакансии
CREATE OR REPLACE PROCEDURE InsertVacancyApproval(
    p_VacancyID NUMBER,
    p_ApprovalDate TIMESTAMP,
    p_InterviewerID NUMBER,
    p_Status NVARCHAR2
) AS
BEGIN
    BEGIN
        INSERT INTO VacancyApproval (VacancyID, ApprovalDate, InterviewerID, Status)
        VALUES (p_VacancyID, p_ApprovalDate, p_InterviewerID, p_Status);
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            DBMS_OUTPUT.PUT_LINE(SQLERRM);
    END;
END InsertVacancyApproval;

-- Процедура для обновления информации о подтверждении вакансии
CREATE OR REPLACE PROCEDURE UpdateVacancyApproval(
    p_ApprovalID NUMBER,
    p_VacancyID NUMBER,
    p_ApprovalDate TIMESTAMP,
    p_InterviewerID NUMBER,
    p_Status NVARCHAR2
) AS
BEGIN
    BEGIN
        UPDATE VacancyApproval
        SET
            VacancyID = p_VacancyID,
            ApprovalDate = p_ApprovalDate,
            InterviewerID = p_InterviewerID,
            Status = p_Status
        WHERE ApprovalID = p_ApprovalID;
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            DBMS_OUTPUT.PUT_LINE(SQLERRM);
    END;
END UpdateVacancyApproval;

-- Процедура для удаления информации о подтверждении вакансии
CREATE OR REPLACE PROCEDURE DeleteVacancyApproval(p_ApprovalID NUMBER) AS
BEGIN
    BEGIN
        DELETE FROM VacancyApproval
        WHERE ApprovalID = p_ApprovalID;
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            DBMS_OUTPUT.PUT_LINE(SQLERRM);
    END;
END DeleteVacancyApproval;

-- Процедура для добавления информации о собеседованиях с собеседователями
CREATE OR REPLACE PROCEDURE InsertInterviewWithInterviewer(
    p_InterviewerID NUMBER,
    p_InterviewID NUMBER
) AS
BEGIN
    BEGIN
        INSERT INTO InterviewsWithInterviewers (InterviewerID, InterviewID)
        VALUES (p_InterviewerID, p_InterviewID);
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            DBMS_OUTPUT.PUT_LINE(SQLERRM);
    END;
END InsertInterviewWithInterviewer;

-- Процедура для обновления информации о собеседованиях с участием собеседователей
CREATE OR REPLACE PROCEDURE UpdateInterviewWithInterviewer(
    p_InterviewWithInterviewerID NUMBER,
    p_InterviewerID NUMBER,
    p_InterviewID NUMBER
) AS
BEGIN
    BEGIN
        UPDATE InterviewsWithInterviewers
        SET
            InterviewerID = p_InterviewerID,
            InterviewID = p_InterviewID
        WHERE InterviewWithInterviewerID = p_InterviewWithInterviewerID;
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            DBMS_OUTPUT.PUT_LINE(SQLERRM);
    END;
END UpdateInterviewWithInterviewer;

-- Процедура для удаления информации о собеседованиях с участием собеседователей
CREATE OR REPLACE PROCEDURE DeleteInterviewWithInterviewer(p_InterviewWithInterviewerID NUMBER) AS
BEGIN
    BEGIN
        DELETE FROM InterviewsWithInterviewers
        WHERE InterviewWithInterviewerID = p_InterviewWithInterviewerID;
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            DBMS_OUTPUT.PUT_LINE(SQLERRM);
    END;
END DeleteInterviewWithInterviewer;

-- Процедура для добавления оценок собеседования
CREATE OR REPLACE PROCEDURE InsertCandidateAssessment(
    p_InterviewID NUMBER,
    p_InterviewerID NUMBER,
    p_AssessmentDate TIMESTAMP,
    p_Rating NUMBER,
    p_Comments NVARCHAR2
) AS
BEGIN
    BEGIN
        INSERT INTO CandidateAssessments (InterviewID, InterviewerID, AssessmentDate, Rating, Comments)
        VALUES (p_InterviewID, p_InterviewerID, p_AssessmentDate, p_Rating, p_Comments);
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            DBMS_OUTPUT.PUT_LINE(SQLERRM);
    END;
END InsertCandidateAssessment;

-- Процедура для обновления оценок кандидатов после собеседования
CREATE OR REPLACE PROCEDURE UpdateCandidateAssessment(
    p_AssessmentID NUMBER,
    p_InterviewID NUMBER,
    p_InterviewerID NUMBER,
    p_AssessmentDate TIMESTAMP,
    p_Rating NUMBER,
    p_Comments NVARCHAR2
) AS
BEGIN
    BEGIN
        UPDATE CandidateAssessments
        SET
            InterviewID = p_InterviewID,
            InterviewerID = p_InterviewerID,
            AssessmentDate = p_AssessmentDate,
            Rating = p_Rating,
            Comments = p_Comments
        WHERE AssessmentID = p_AssessmentID;
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            DBMS_OUTPUT.PUT_LINE(SQLERRM);
    END;
END UpdateCandidateAssessment;

-- Процедура для удаления оценок кандидатов после собеседования
CREATE OR REPLACE PROCEDURE DeleteCandidateAssessment(p_AssessmentID NUMBER) AS
BEGIN
    BEGIN
        DELETE FROM CandidateAssessments
        WHERE AssessmentID = p_AssessmentID;
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            DBMS_OUTPUT.PUT_LINE(SQLERRM);
    END;
END DeleteCandidateAssessment;

-- Процедура для добавления контактных данных для интервьюеров
CREATE OR REPLACE PROCEDURE InsertInterviewerContactInfo(
    p_InterviewerID NUMBER,
    p_ContactInfo NVARCHAR2
) AS
BEGIN
    BEGIN
        INSERT INTO InterviewerContactInfo (InterviewerID, ContactInfo)
        VALUES (p_InterviewerID, p_ContactInfo);
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            -- Обработка ошибок
            ROLLBACK;
            DBMS_OUTPUT.PUT_LINE(SQLERRM);
    END;
END InsertInterviewerContactInfo;

-- Процедура для обновления контактной информации собеседователей
CREATE OR REPLACE PROCEDURE UpdateInterviewerContactInfo(
    p_ContactInfoID NUMBER,
    p_InterviewerID NUMBER,
    p_ContactInfo NVARCHAR2
) AS
BEGIN
    BEGIN
        UPDATE InterviewerContactInfo
        SET
            InterviewerID = p_InterviewerID,
            ContactInfo = p_ContactInfo
        WHERE ContactInfoID = p_ContactInfoID;
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            DBMS_OUTPUT.PUT_LINE(SQLERRM);
    END;
END UpdateInterviewerContactInfo;

-- Процедура для удаления контактной информации собеседователей
CREATE OR REPLACE PROCEDURE DeleteInterviewerContactInfo(p_ContactInfoID NUMBER) AS
BEGIN
    BEGIN
        DELETE FROM InterviewerContactInfo
        WHERE ContactInfoID = p_ContactInfoID;
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            DBMS_OUTPUT.PUT_LINE(SQLERRM);
    END;
END DeleteInterviewerContactInfo;
-- Процедура для добавления информации о языках
CREATE OR REPLACE PROCEDURE InsertLanguage(
    p_LanguageName NVARCHAR2
) AS
BEGIN
    BEGIN
        INSERT INTO Languages (LanguageName)
        VALUES (p_LanguageName);
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            DBMS_OUTPUT.PUT_LINE(SQLERRM);
    END;
END InsertLanguage;

-- Процедура для обновления информации о языках
CREATE OR REPLACE PROCEDURE UpdateLanguage(
    p_LanguageID NUMBER,
    p_LanguageName NVARCHAR2
) AS
BEGIN
    BEGIN
        UPDATE Languages
        SET LanguageName = p_LanguageName
        WHERE LanguageID = p_LanguageID;
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            DBMS_OUTPUT.PUT_LINE(SQLERRM);
    END;
END UpdateLanguage;

-- Процедура для удаления информации о языках
CREATE OR REPLACE PROCEDURE DeleteLanguage(p_LanguageID NUMBER) AS
BEGIN
    BEGIN
        DELETE FROM Languages
        WHERE LanguageID = p_LanguageID;
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            DBMS_OUTPUT.PUT_LINE(SQLERRM);
    END;
END DeleteLanguage;

-- Процедура для добавления информации о владении языками кандидатом
CREATE OR REPLACE PROCEDURE InsertCandidateLanguage(
    p_LanguageID NUMBER,
    p_CandidateID NUMBER,
    p_Level NVARCHAR2
) AS
BEGIN
    BEGIN
        INSERT INTO CandidateLanguage (LanguageID, CandidateID, Level_)
        VALUES (p_LanguageID, p_CandidateID, p_Level);
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            DBMS_OUTPUT.PUT_LINE(SQLERRM);
    END;
END InsertCandidateLanguage;

-- Процедура для обновления информации о навыках языков кандидатов
CREATE OR REPLACE PROCEDURE UpdateCandidateLanguage(
    p_CandidateLanguageID NUMBER,
    p_LanguageID NUMBER,
    p_CandidateID NUMBER,
    p_Level NVARCHAR2
) AS
BEGIN
    BEGIN
        UPDATE CandidateLanguage
        SET
            LanguageID = p_LanguageID,
            CandidateID = p_CandidateID,
            Level_ = p_Level
        WHERE CandidateLanguageID = p_CandidateLanguageID;
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            DBMS_OUTPUT.PUT_LINE(SQLERRM);
    END;
END UpdateCandidateLanguage;

-- Процедура для удаления информации о навыках языков кандидатов
CREATE OR REPLACE PROCEDURE DeleteCandidateLanguage(p_CandidateLanguageID NUMBER) AS
BEGIN
    BEGIN
        DELETE FROM CandidateLanguage
        WHERE CandidateLanguageID = p_CandidateLanguageID;
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            DBMS_OUTPUT.PUT_LINE(SQLERRM);
    END;
END DeleteCandidateLanguage;

-- Процедура для добавления информации о программных языках
CREATE OR REPLACE PROCEDURE InsertProgLang(
    p_ProgLangName NVARCHAR2
) AS
BEGIN
    BEGIN
        INSERT INTO ProgLang (ProgLangName)
        VALUES (p_ProgLangName);
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            DBMS_OUTPUT.PUT_LINE(SQLERRM);
    END;
END InsertProgLang;

-- Процедура для обновления информации о языках программирования
CREATE OR REPLACE PROCEDURE UpdateProgLang(
    p_ProgLangID NUMBER,
    p_ProgLangName NVARCHAR2
) AS
BEGIN
    BEGIN
        UPDATE ProgLang
        SET ProgLangName = p_ProgLangName
        WHERE ProgLangID = p_ProgLangID;
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            DBMS_OUTPUT.PUT_LINE(SQLERRM);
    END;
END UpdateProgLang;

-- Процедура для удаления информации о языках программирования
CREATE OR REPLACE PROCEDURE DeleteProgLang(p_ProgLangID NUMBER) AS
BEGIN
    BEGIN
        DELETE FROM ProgLang
        WHERE ProgLangID = p_ProgLangID;
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            DBMS_OUTPUT.PUT_LINE(SQLERRM);
    END;
END DeleteProgLang;

-- Процедура для добавления информации о владении программными языками кандидатом
CREATE OR REPLACE PROCEDURE InsertCandidateProgLang(
    p_ProgLangID NUMBER,
    p_CandidateID NUMBER,
    p_Level NVARCHAR2
) AS
BEGIN
    BEGIN
        INSERT INTO CandidateProgLang (ProgLangID, CandidateID, Level_)
        VALUES (p_ProgLangID, p_CandidateID, p_Level);
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            DBMS_OUTPUT.PUT_LINE(SQLERRM);
    END;
END InsertCandidateProgLang;

-- Процедура для обновления информации о навыках программирования кандидатов
CREATE OR REPLACE PROCEDURE UpdateCandidateProgLang(
    p_CandidateProgLangID NUMBER,
    p_ProgLangID NUMBER,
    p_CandidateID NUMBER,
    p_Level NVARCHAR2
) AS
BEGIN
    BEGIN
        UPDATE CandidateProgLang
        SET
            ProgLangID = p_ProgLangID,
            CandidateID = p_CandidateID,
            Level_ = p_Level
        WHERE CandidateProgLangID = p_CandidateProgLangID;
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            DBMS_OUTPUT.PUT_LINE(SQLERRM);
    END;
END UpdateCandidateProgLang;

-- Процедура для удаления информации о навыках программирования кандидатов
CREATE OR REPLACE PROCEDURE DeleteCandidateProgLang(p_CandidateProgLangID NUMBER) AS
BEGIN
    BEGIN
        DELETE FROM CandidateProgLang
        WHERE CandidateProgLangID = p_CandidateProgLangID;
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            DBMS_OUTPUT.PUT_LINE(SQLERRM);
    END;
END DeleteCandidateProgLang;

-- Процедура для добавления документов
CREATE OR REPLACE PROCEDURE InsertDocument(
    p_CandidateID NUMBER,
    p_DocumentName NVARCHAR2,
    p_DocumentContent BLOB
) AS
BEGIN
    BEGIN
        INSERT INTO Documents (CandidateID, DocumentName, DocumentContent)
        VALUES (p_CandidateID, p_DocumentName, p_DocumentContent);
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            DBMS_OUTPUT.PUT_LINE(SQLERRM);
    END;
END InsertDocument;

-- Процедура для обновления информации о документах кандидатов
CREATE OR REPLACE PROCEDURE UpdateDocument(
    p_DocumentID NUMBER,
    p_CandidateID NUMBER,
    p_DocumentName NVARCHAR2,
    p_DocumentContent BLOB
) AS
BEGIN
    BEGIN
        UPDATE Documents
        SET
            CandidateID = p_CandidateID,
            DocumentName = p_DocumentName,
            DocumentContent = p_DocumentContent
        WHERE DocumentID = p_DocumentID;
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            DBMS_OUTPUT.PUT_LINE(SQLERRM);
    END;
END UpdateDocument;

-- Процедура для удаления информации о документах кандидатов
CREATE OR REPLACE PROCEDURE DeleteDocument(p_DocumentID NUMBER) AS
BEGIN
    BEGIN
        DELETE FROM Documents
        WHERE DocumentID = p_DocumentID;
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            DBMS_OUTPUT.PUT_LINE(SQLERRM);
    END;
END DeleteDocument;

CREATE OR REPLACE PROCEDURE GetInterviewDetails(p_InterviewID NUMBER) AS
BEGIN
    -- Объявление переменных для хранения данных
    DECLARE
        v_InterviewID NUMBER;
        v_InterviewDateTime DATE;
        v_Location NVARCHAR2(255);
        v_InterviewResult NVARCHAR2(255);
        v_Parents NVARCHAR2(255);
        v_CandidateLastName NVARCHAR2(255);
        v_CandidateFirstName NVARCHAR2(255);
        v_CandidateMiddleName NVARCHAR2(255);
        v_CandidateDateOfBirth DATE;
        v_CandidateGender NVARCHAR2(255);
        v_CandidateExperience NVARCHAR2(255);
        v_CandidateSource NVARCHAR2(255);
        v_CandidateStatus NVARCHAR2(255);
        v_CandidateContactInfo NVARCHAR2(255);
        v_InterviewerID NUMBER;
        v_InterviewerLastName NVARCHAR2(255);
        v_InterviewerFirstName NVARCHAR2(255);
    BEGIN
        -- Получить информацию о собеседовании
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
        INTO
            v_InterviewID,
            v_InterviewDateTime,
            v_Location,
            v_InterviewResult,
            v_Parents,
            v_CandidateLastName,
            v_CandidateFirstName,
            v_CandidateMiddleName,
            v_CandidateDateOfBirth,
            v_CandidateGender,
            v_CandidateExperience,
            v_CandidateSource,
            v_CandidateStatus,
            v_CandidateContactInfo,
            v_InterviewerID,
            v_InterviewerLastName,
            v_InterviewerFirstName
        FROM Interviews I
        INNER JOIN Candidates C ON I.CandidateID = C.CandidateID
        LEFT JOIN CandidateContactInfo IC ON C.CandidateID = IC.CandidateID
        LEFT JOIN InterviewsWithInterviewers IWI ON I.InterviewID = IWI.InterviewID
        LEFT JOIN Interviewers IR ON IWI.InterviewerID = IR.InterviewerID
        WHERE I.InterviewID = p_InterviewID;

        -- Вывести информацию
        DBMS_OUTPUT.PUT_LINE('InterviewID: ' || v_InterviewID);
        DBMS_OUTPUT.PUT_LINE('InterviewDateTime: ' || TO_CHAR(v_InterviewDateTime, 'YYYY-MM-DD HH24:MI:SS'));
        DBMS_OUTPUT.PUT_LINE('Location: ' || v_Location);
        DBMS_OUTPUT.PUT_LINE('InterviewResult: ' || v_InterviewResult);
        DBMS_OUTPUT.PUT_LINE('Parents: ' || v_Parents);
        DBMS_OUTPUT.PUT_LINE('CandidateLastName: ' || v_CandidateLastName);
        DBMS_OUTPUT.PUT_LINE('CandidateFirstName: ' || v_CandidateFirstName);
        DBMS_OUTPUT.PUT_LINE('CandidateMiddleName: ' || v_CandidateMiddleName);
        DBMS_OUTPUT.PUT_LINE('CandidateDateOfBirth: ' || TO_CHAR(v_CandidateDateOfBirth, 'YYYY-MM-DD'));
        DBMS_OUTPUT.PUT_LINE('CandidateGender: ' || v_CandidateGender);
        DBMS_OUTPUT.PUT_LINE('CandidateExperience: ' || v_CandidateExperience);
        DBMS_OUTPUT.PUT_LINE('CandidateSource: ' || v_CandidateSource);
        DBMS_OUTPUT.PUT_LINE('CandidateStatus: ' || v_CandidateStatus);
        DBMS_OUTPUT.PUT_LINE('CandidateContactInfo: ' || v_CandidateContactInfo);
        DBMS_OUTPUT.PUT_LINE('InterviewerID: ' || v_InterviewerID);
        DBMS_OUTPUT.PUT_LINE('InterviewerLastName: ' || v_InterviewerLastName);
        DBMS_OUTPUT.PUT_LINE('InterviewerFirstName: ' || v_InterviewerFirstName);
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
    END;
END GetInterviewDetails;

-- Добавление кандидатов
BEGIN
    InsertCandidate(
        'Smith1',
        'John1',
        'Doe1',
        TO_DATE('1990-01-01', 'YYYY-MM-DD'),
        'Male',
        '5 years',
        'LinkedIn',
        'Active'
    );
    
    InsertCandidate(
        'Smith2',
        'John2',
        'Doe2',
        TO_DATE('1990-02-02', 'YYYY-MM-DD'),
        'Female',
        '4 years',
        'Referral',
        'Active'
    );
    
    InsertCandidate(
        'Smith3',
        'John3',
        'Doe3',
        TO_DATE('1990-03-03', 'YYYY-MM-DD'),
        'Male',
        '6 years',
        'LinkedIn',
        'Inactive'
    );
    
    InsertCandidate(
        'Smith4',
        'John4',
        'Doe4',
        TO_DATE('1990-04-04', 'YYYY-MM-DD'),
        'Female',
        '7 years',
        'Referral',
        'Active'
    );
    
    InsertCandidate(
        'Smith5',
        'John5',
        'Doe5',
        TO_DATE('1990-05-05', 'YYYY-MM-DD'),
        'Male',
        '3 years',
        'LinkedIn',
        'Active'
    );
END;

-- Обновление информации о кандидатах
BEGIN
    UpdateCandidate(3, 'Max', 'John1', 'Doe1', TO_DATE('1990-01-01', 'YYYY-MM-DD'), 'Male', '5 years', 'LinkedIn', 'Active');
END;

-- Добавление интервьюеров
BEGIN
    InsertInterviewer('Smith1', 'John1', 'Senior Interviewer');
    InsertInterviewer('Johnson2', 'Jane2', 'Junior Interviewer');
    InsertInterviewer('Brown3', 'David3', 'HR Specialist');
    InsertInterviewer('Williams4', 'Emma4', 'Technical Interviewer');
    InsertInterviewer('Davis5', 'Michael5', 'Senior Interviewer');
END;

-- Добавление вакансий
BEGIN
    InsertVacancy('Software Engineer', 'We are looking for a skilled software engineer to join our team.', TO_DATE('2023-01-10', 'YYYY-MM-DD'), TO_DATE('2023-02-15', 'YYYY-MM-DD'));
    InsertVacancy('Data Analyst', 'Seeking a data analyst to analyze and interpret complex data.', TO_DATE('2023-01-12', 'YYYY-MM-DD'), TO_DATE('2023-03-01', 'YYYY-MM-DD'));
    InsertVacancy('Project Manager', 'Looking for an experienced project manager to lead our projects.', TO_DATE('2023-01-14', 'YYYY-MM-DD'), TO_DATE('2023-02-28', 'YYYY-MM-DD'));
    InsertVacancy('Sales Representative', 'Hiring a sales representative to promote and sell our products.', TO_DATE('2023-01-16', 'YYYY-MM-DD'), TO_DATE('2023-03-10', 'YYYY-MM-DD'));
    InsertVacancy('Graphic Designer', 'We need a creative graphic designer to create visual content.', TO_DATE('2023-01-18', 'YYYY-MM-DD'), TO_DATE('2023-02-20', 'YYYY-MM-DD'));
END;

-- Добавление собеседований
BEGIN
    InsertInterview(3, 1, TO_DATE('2023-01-15 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Meeting Room 1', 'Passed', null);
    InsertInterview(4, 1, TO_DATE('2023-01-16 10:30:00', 'YYYY-MM-DD HH24:MI:SS'), 'Meeting Room 2', 'Passed', null);
    InsertInterview(5, 2, TO_DATE('2023-01-17 14:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Meeting Room 3', 'Pending', null);
    InsertInterview(6, 2, TO_DATE('2023-01-18 11:15:00', 'YYYY-MM-DD HH24:MI:SS'), 'Meeting Room 2', 'Failed', null);
    InsertInterview(5, 3, TO_DATE('2023-01-19 16:30:00', 'YYYY-MM-DD HH24:MI:SS'), 'Meeting Room 4', 'Passed', null);
END;
-- Триггер для таблицы ChangeLog
CREATE OR REPLACE TRIGGER trg_Candidates_Audit
AFTER INSERT OR UPDATE OR DELETE ON Candidates
FOR EACH ROW
DECLARE
    OperationType NVARCHAR2(10);
    ChangeDateTime DATE := SYSDATE;
BEGIN
    IF INSERTING OR UPDATING THEN
        OperationType := 'INSERT/UPDATE';
    ELSE
        OperationType := 'DELETE';
    END IF;

    -- Вам нужно явно указать столбцы таблицы Candidates, которые вас интересуют
    IF INSERTING OR UPDATING THEN
        -- Укажите столбцы, которые вас интересуют
        NULL; -- Пример: :new.LastName, :new.FirstName
    END IF;

    -- Вставьте запись в журнал изменений (ChangeLog)
    INSERT INTO ChangeLog (TableName, OperationType, ChangedColumns, OldValues, NewValues, ChangeDateTime)
    VALUES (
        'Candidates',
        OperationType,
        'LastName,FirstName', -- Замените на нужные столбцы
        NULL, -- Замените на :old.XX, если вас интересуют старые значения
        NULL, -- Замените на :new.XX, если вас интересуют новые значения
        ChangeDateTime
    );
END;

-- Представление CandidateFullInfo
CREATE OR REPLACE VIEW CandidateFullInfo AS
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
    CL.Level_ AS LanguageLevel,
    PL.ProgLangName AS ProgrammingLanguage
FROM Candidates C
LEFT JOIN Addresses A ON C.CandidateID = A.CandidateID
LEFT JOIN CandidatesEducation CE ON C.CandidateID = CE.CandidateID
LEFT JOIN CandidatesCoursesAndTraining CT ON C.CandidateID = CT.CandidateID
LEFT JOIN JobApplications IA ON C.CandidateID = IA.CandidateID
LEFT JOIN CandidateContactInfo CI ON C.CandidateID = CI.CandidateID
LEFT JOIN CandidateLanguage CL ON C.CandidateID = CL.CandidateID
LEFT JOIN ProgLang PL ON CL.LanguageID = PL.ProgLangID;

-- Пример использования представления
SELECT * FROM CandidateFullInfo;

-- Представление InterviewInfo
CREATE OR REPLACE VIEW InterviewInfo AS
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
FROM Candidates C
INNER JOIN Interviews I ON C.CandidateID = I.CandidateID
INNER JOIN Vacancies V ON I.VacancyID = V.VacancyID
INNER JOIN InterviewsWithInterviewers IWI ON I.InterviewID = IWI.InterviewID
INNER JOIN Interviewers IL ON IWI.InterviewerID = IL.InterviewerID;

-- Пример использования представления
SELECT * FROM InterviewInfo;

--Представление для ввыовода информации об вакансиях
CREATE OR REPLACE VIEW VacancyApprovalInfo AS
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
--Представление для вывода информации об образовании кандидатов
CREATE OR REPLACE VIEW CandidateEducationInfo AS
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
--Представление для вывода информации о заявках на вакансии
CREATE OR REPLACE VIEW JobApplicationInfo AS
SELECT
    C.CandidateID,
    C.LastName AS CandidateLastName,
    C.FirstName AS CandidateFirstName,
    V.PositionTitle AS VacancyPosition,
    JA.ApplicationDate
FROM Candidates C
INNER JOIN JobApplications JA ON C.CandidateID = JA.CandidateID
INNER JOIN Vacancies V ON JA.VacancyID = V.VacancyID;
--Представление для вывода информации о языках и уровне кандидатов
CREATE OR REPLACE VIEW CandidateLanguageInfo AS
SELECT
    C.CandidateID,
    C.LastName AS CandidateLastName,
    C.FirstName AS CandidateFirstName,
    CL.Level_ AS LanguageLevel,
    L.LanguageName
FROM Candidates C
INNER JOIN CandidateLanguage CL ON C.CandidateID = CL.CandidateID
INNER JOIN Languages L ON CL.LanguageID = L.LanguageID;
--Представление для вывода информации о знании программных языков кандидатов:
CREATE OR REPLACE VIEW CandidateProgrammingLanguageInfo AS
SELECT
    C.CandidateID,
    C.LastName AS CandidateLastName,
    C.FirstName AS CandidateFirstName,
    CPL.Level_ AS ProgrammingLanguageLevel,
    PL.ProgLangName
FROM Candidates C
INNER JOIN CandidateProgLang CPL ON C.CandidateID = CPL.CandidateID
INNER JOIN ProgLang PL ON CPL.ProgLangID = PL.ProgLangID;

-- Создание индексов
CREATE INDEX IDX_FK_Addresses_CandidateID ON Addresses (CandidateID);
CREATE INDEX IDX_FK_CandidatesEducation_CandidateID ON CandidatesEducation (CandidateID);
CREATE INDEX IDX_FK_CandidatesCoursesAndTraining_CandidateID ON CandidatesCoursesAndTraining (CandidateID);
CREATE INDEX IDX_FK_JobApplications_CandidateID ON JobApplications (CandidateID);
CREATE INDEX IDX_FK_CandidateContactInfo_CandidateID ON CandidateContactInfo (CandidateID);
CREATE INDEX IDX_FK_CandidateLanguage_CandidateID ON CandidateLanguage (CandidateID);
CREATE INDEX IDX_FK_CandidateProgLang_CandidateID ON CandidateProgLang (CandidateID);
CREATE INDEX IDX_FK_InterviewInfo_CandidateID ON Interviews (CandidateID);
CREATE INDEX IDX_FK_InterviewInfo_VacancyID ON Interviews (VacancyID);

-- 3 laba
alter database open
Select * from InterviewInfo
Select * from Interviews
BEGIN
    InsertInterview(21, 21, TO_DATE('2023-01-15 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Meeting Room 1', 'Passed', 79);
    InsertInterview(24, 21, TO_DATE('2023-01-16 10:30:00', 'YYYY-MM-DD HH24:MI:SS'), 'Meeting Room 2', 'Passed', 80);
    InsertInterview(25, 22, TO_DATE('2023-01-17 14:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Meeting Room 3', 'Pending', 81);
    InsertInterview(23, 22, TO_DATE('2023-01-18 11:15:00', 'YYYY-MM-DD HH24:MI:SS'), 'Meeting Room 2', 'Failed', 82);
    InsertInterview(25, 23, TO_DATE('2023-01-19 16:30:00', 'YYYY-MM-DD HH24:MI:SS'), 'Meeting Room 4', 'Passed', 83);
END;
Commit
Select * from Vacancies
CREATE OR REPLACE PROCEDURE ParentsInterview(p_ParentInterviewID NUMBER) IS
BEGIN
    FOR r IN (
        SELECT InterviewID, CandidateID, VacancyID, InterviewDateTime, Location, InterviewResult, Parents,
               LEVEL AS Hierarchy_Level,
               SYS_CONNECT_BY_PATH(InterviewID, '-') AS Path
        FROM Interviews
        CONNECT BY PRIOR InterviewID = Parents
        START WITH InterviewID = p_ParentInterviewID
    ) LOOP
        DBMS_OUTPUT.PUT_LINE('InterviewID: ' || r.InterviewID || ', CandidateID: ' || r.CandidateID || 
                            ', VacancyID: ' || r.VacancyID || ', InterviewDateTime: ' || r.InterviewDateTime ||
                            ', Location: ' || r.Location || ', InterviewResult: ' || r.InterviewResult ||
                            ', Level: ' || r.Path);
    END LOOP;
END ParentsInterview;

Begin 
ParentsInterview (89);
end;
Select * from Interviews
CREATE OR REPLACE PROCEDURE AddSubParentInterview(
    p_ParentInterviewID NUMBER,
    p_CandidateID NUMBER,
    p_VacancyID NUMBER,
    p_InterviewDateTime TIMESTAMP,
    p_Location NVARCHAR2,
    p_InterviewResult NVARCHAR2
) IS
BEGIN
    INSERT INTO Interviews (CandidateID, VacancyID, InterviewDateTime, Location, InterviewResult, Parents)
    VALUES (p_CandidateID, p_VacancyID, p_InterviewDateTime, p_Location, p_InterviewResult, p_ParentInterviewID);
END AddSubParentInterview;

BEGIN
    AddSubParentInterview(89, 25, 23, TO_TIMESTAMP('2023-11-02 15:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Meeting Room 5', 'Pending');
END;

Select * from Interviews

CREATE OR REPLACE PROCEDURE MoveInterviewBranch(p_SourceInterviewID NUMBER, p_TargetParentInterviewID NUMBER) AS
BEGIN
    -- Находим все подчиненные элементы исходного InterviewID
    FOR r IN (
        SELECT InterviewID
        FROM Interviews
        CONNECT BY PRIOR InterviewID = Parents
        START WITH InterviewID = p_SourceInterviewID
    ) LOOP
        -- Обновляем их поле Parents
        UPDATE Interviews 
        SET Parents = p_TargetParentInterviewID 
        WHERE InterviewID = r.InterviewID;
    END LOOP;

    COMMIT;
END MoveInterviewBranch;


BEGIN
    MoveInterviewBranch(74, 76);
END;
--4 LABA 
SELECT * from Interviews
Delete from Interviews where Location like 'M%'
commit
DECLARE
    p_CandidateID NUMBER;
    p_VacancyID NUMBER;
    p_InterviewDateTime TIMESTAMP;
    p_Location NVARCHAR2(100);
    p_InterviewResult NVARCHAR2(100);
    p_Parents NUMBER;
    random_day NUMBER;
BEGIN
    -- Генерация и добавление 20 интервью, произошедших в последнем месяце
    FOR i IN 1..20 LOOP
        -- Генерация случайных значений для параметров
        p_CandidateID := 21;
        p_VacancyID := 21;
        
        -- Генерация случайного числа от 1 до 30
        random_day := ROUND(DBMS_RANDOM.VALUE(1, 30));
        
        -- Вычисление даты на основе текущей даты и случайного числа дня в пределах месяца
        p_InterviewDateTime := TRUNC(SYSDATE, 'MM') + random_day - 1;
        
        p_Location := 'Meeting Room 1';
        p_InterviewResult := 'Passed';
        p_Parents := NULL;

        -- Вызов процедуры InsertInterview для добавления записи
        InsertInterview(p_CandidateID, p_VacancyID, p_InterviewDateTime, p_Location, p_InterviewResult, p_Parents);
    END LOOP;
END;

DECLARE
    p_CandidateID NUMBER;
    p_VacancyID NUMBER;
    p_InterviewDateTime TIMESTAMP;
    p_Location NVARCHAR2(100);
    p_InterviewResult NVARCHAR2(100);
    p_Parents NUMBER;
    random_day NUMBER;
BEGIN
    -- Генерация и добавление 20 интервью, произошедших в последнем квартале
    FOR i IN 1..20 LOOP
        -- Генерация случайных значений для параметров
        p_CandidateID := 21;
        p_VacancyID := 21;
        
        -- Генерация случайного числа от 1 до 90
        random_day := ROUND(DBMS_RANDOM.VALUE(1, 90));
        
        -- Вычисление даты на основе текущей даты и случайного числа дня в пределах квартала
        p_InterviewDateTime := TRUNC(SYSDATE, 'Q') + random_day - 1;
        
        p_Location := 'Meeting Room 1';
        p_InterviewResult := 'Passed';
        p_Parents := NULL;

        -- Вызов процедуры InsertInterview для добавления записи
        InsertInterview(p_CandidateID, p_VacancyID, p_InterviewDateTime, p_Location, p_InterviewResult, p_Parents);
    END LOOP;
END;

DECLARE
    p_CandidateID NUMBER;
    p_VacancyID NUMBER;
    p_InterviewDateTime TIMESTAMP;
    p_Location NVARCHAR2(100);
    p_InterviewResult NVARCHAR2(100);
    p_Parents NUMBER;
    random_day NUMBER;
BEGIN
    -- Генерация и добавление 20 интервью, произошедших в прошедшем полугодии
    FOR i IN 1..20 LOOP
        -- Генерация случайных значений для параметров
        p_CandidateID := 21;
        p_VacancyID := 21;
        
        -- Генерация случайного числа от 1 до 180 (6 месяцев)
        random_day := ROUND(DBMS_RANDOM.VALUE(1, 180));
        
        -- Вычисление даты на основе текущей даты и случайного числа дня в пределах прошедшего полугодия
        p_InterviewDateTime := TRUNC(SYSDATE, 'Q') - random_day;
        
        -- Проверка, если месяц равен 11 или 12, увеличиваем случайное число на 61 (декабрь и ноябрь)
        IF EXTRACT(MONTH FROM p_InterviewDateTime) = 11 OR EXTRACT(MONTH FROM p_InterviewDateTime) = 12 THEN
            random_day := random_day + 61;
            p_InterviewDateTime := TRUNC(SYSDATE, 'Q') - random_day;
        END IF;
        
        p_Location := 'Meeting Room 1';
        p_InterviewResult := 'Passed';
        p_Parents := NULL;

        -- Вызов процедуры InsertInterview для добавления записи
        InsertInterview(p_CandidateID, p_VacancyID, p_InterviewDateTime, p_Location, p_InterviewResult, p_Parents);
    END LOOP;
END;

DECLARE
    p_CandidateID NUMBER;
    p_VacancyID NUMBER;
    p_InterviewDateTime TIMESTAMP;
    p_Location NVARCHAR2(100);
    p_InterviewResult NVARCHAR2(100);
    p_Parents NUMBER;
    random_day NUMBER;
BEGIN
    -- Генерация и добавление 20 интервью, произошедших в пределах прошедшего года
    FOR i IN 1..20 LOOP
        -- Генерация случайных значений для параметров
        p_CandidateID := 21;
        p_VacancyID := 21;
        
        -- Генерация случайного числа от 1 до 365 (год)
        random_day := ROUND(DBMS_RANDOM.VALUE(1, 365));
        
        -- Вычисление даты на основе текущей даты и случайного числа дня в пределах прошедшего года
        p_InterviewDateTime := TRUNC(SYSDATE, 'YYYY') - random_day;
        
        -- Проверка, если месяц равен 11, 12 или текущий месяц, увеличиваем случайное число на 61 (декабрь, ноябрь или текущий месяц)
        IF EXTRACT(MONTH FROM p_InterviewDateTime) = 11 OR EXTRACT(MONTH FROM p_InterviewDateTime) = 12 OR EXTRACT(MONTH FROM p_InterviewDateTime) = EXTRACT(MONTH FROM SYSDATE) THEN
            random_day := random_day + 61;
            p_InterviewDateTime := TRUNC(SYSDATE, 'YYYY') - random_day;
        END IF;
        
        p_Location := 'Meeting Room 1';
        p_InterviewResult := 'Passed';
        p_Parents := NULL;

        -- Вызов процедуры InsertInterview для добавления записи
        InsertInterview(p_CandidateID, p_VacancyID, p_InterviewDateTime, p_Location, p_InterviewResult, p_Parents);
    END LOOP;
END;

Select * from InterviewsWithInterviewers
Select * from Interviewers

CREATE OR REPLACE PROCEDURE InsertInterviewWithInterviewer(
    p_InterviewerID NUMBER,
    p_InterviewID NUMBER
) AS
BEGIN
    BEGIN
        INSERT INTO InterviewsWithInterviewers (InterviewerID, InterviewID)
        VALUES (p_InterviewerID, p_InterviewID);
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            DBMS_OUTPUT.PUT_LINE(SQLERRM);
    END;
END InsertInterviewWithInterviewer;

DECLARE
    v_InterviewerID NUMBER;
    v_InterviewID NUMBER := 161;
    v_Counter NUMBER := 1;
BEGIN
    WHILE v_Counter <= 80 LOOP -- Количество вставок (80 в данном примере)
        BEGIN
            v_InterviewerID := FLOOR(DBMS_RANDOM.VALUE(21, 26));
            
            INSERT INTO InterviewsWithInterviewers (InterviewerID, InterviewID)
            VALUES (v_InterviewerID, v_InterviewID);
            
            v_InterviewID := v_InterviewID + 1; -- Увеличение значения InterviewID на 1
            
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                DBMS_OUTPUT.PUT_LINE(SQLERRM);
        END;

        v_Counter := v_Counter + 1;
    END LOOP;
END;
Select * from Interviewers
CREATE TABLE Interviews (
    InterviewID NUMBER DEFAULT InterviewID_Seq.NEXTVAL PRIMARY KEY,
    CandidateID NUMBER,
    VacancyID NUMBER,
    InterviewDateTime DATE,
    Location NVARCHAR2(255),
    InterviewResult NVARCHAR2(255),
    Parents NUMBER,
    FOREIGN KEY (CandidateID) REFERENCES Candidates (CandidateID),
    FOREIGN KEY (VacancyID) REFERENCES Vacancies (VacancyID),
    FOREIGN KEY (Parents) REFERENCES Interviews (InterviewID)
);
CREATE TABLE Interviewers (
    InterviewerID NUMBER DEFAULT InterviewerID_Seq.NEXTVAL PRIMARY KEY,
    LastName NVARCHAR2(255),
    FirstName NVARCHAR2(255),
    Role NVARCHAR2(255)
);
Select * from InterviewsWithInterviewers
Select * from Interviewers
Select * from Interviews
SET MARKUP HTML ON;
SELECT
    Interviewers.InterviewerID, 
    EXTRACT(MONTH FROM Interviews.InterviewDateTime) AS Month,
    TO_CHAR(Interviews.InterviewDateTime, 'Q') AS Quartal,
    CASE
        WHEN EXTRACT(MONTH FROM Interviews.InterviewDateTime) BETWEEN 1 AND 6 THEN '1 half-year'
        WHEN EXTRACT(MONTH FROM Interviews.InterviewDateTime) BETWEEN 7 AND 12 THEN '2 half-year'
    END AS HalfYear,
    EXTRACT(YEAR FROM Interviews.InterviewDateTime) AS Year,
    COUNT(InterviewsWithInterviewers.InterviewID) OVER (
        PARTITION BY Interviewers.InterviewerID, 
        EXTRACT(MONTH FROM Interviews.InterviewDateTime)
        ORDER BY Interviews.InterviewDateTime
    ) AS MonthCount,
    COUNT(InterviewsWithInterviewers.InterviewID) OVER (
        PARTITION BY Interviewers.InterviewerID, 
        TO_CHAR(Interviews.InterviewDateTime, 'Q')
        ORDER BY Interviews.InterviewDateTime
    ) AS QuartalCount,
    COUNT(InterviewsWithInterviewers.InterviewID) OVER (
        PARTITION BY Interviewers.InterviewerID, 
        CASE WHEN EXTRACT(MONTH FROM Interviews.InterviewDateTime) BETWEEN 1 AND 6 THEN 1 ELSE 2 END 
        ORDER BY Interviews.InterviewDateTime
    ) AS HalfYearCount,
    COUNT(InterviewsWithInterviewers.InterviewID) OVER (
        PARTITION BY Interviewers.InterviewerID, 
        EXTRACT(YEAR FROM Interviews.InterviewDateTime)
        ORDER BY Interviews.InterviewDateTime
    ) AS YearCount
FROM
    Interviews
INNER JOIN
    InterviewsWithInterviewers ON Interviews.InterviewID = InterviewsWithInterviewers.InterviewID
INNER JOIN
    Interviewers ON Interviewers.InterviewerID = InterviewsWithInterviewers.InterviewerID
ORDER BY Interviewers.InterviewerID
   
 

 
//3
Select * from Interviews
Begin
UpdateInterview(
    237,
    21,
    21,
    '03.03.22',
    'Meeting Room 1',
    'Fail',
    NULL
);
END;

WITH PeriodPassed AS (
    SELECT
        hr.InterviewerID,
        COUNT(i.InterviewID) AS CountCandid
    FROM
    Interviews i
    INNER JOIN
    InterviewsWithInterviewers hr ON i.InterviewID = hr.InterviewID
    WHERE
        EXTRACT(MONTH FROM i.InterviewDateTime) = 11
        AND EXTRACT(YEAR FROM i.InterviewDateTime) = 2023
        AND i.InterviewResult like 'P%'
    GROUP BY
        hr.InterviewerID
),
ObshiyCount AS (
    SELECT
        COUNT(i.InterviewID) AS CountCandid
    FROM
    Interviews i
    WHERE
        EXTRACT(MONTH FROM i.InterviewDateTime) = 11
        AND EXTRACT(YEAR FROM i.InterviewDateTime) = 2023
        AND
        i.InterviewResult like 'P%'
    
),
FailCount AS (
    SELECT
        COUNT(i.InterviewID) AS CountCandid
    FROM
    Interviews i
    WHERE
        EXTRACT(MONTH FROM i.InterviewDateTime) = 11
        AND EXTRACT(YEAR FROM i.InterviewDateTime) = 2023
        AND
        i.InterviewResult like 'F%'
    
)
SELECT
    hri.InterviewerID,
    hri.LastName || ' ' || hri.FirstName AS FULLNAME,
    COALESCE(pp.CountCandid, 0) AS CountCandidPassed,
    ROUND((COALESCE(pp.CountCandid, 0) / oc.CountCandid) * 100 , 1) AS PercentDiffFromObsh,
    ROUND((COALESCE(pp.CountCandid, 0) / fc.CountCandid) * 100 , 1) AS PercentDiffFromFail
FROM
    Interviewers hri
LEFT JOIN
    PeriodPassed pp ON hri.InterviewerID = pp.InterviewerID
CROSS JOIN
    ObshiyCount oc
CROSS JOIN 
    FailCount fc

//4
WITH RowsR AS (
    SELECT
        i.CandidateID,
        i.InterviewDateTime,
        ROW_NUMBER() OVER (ORDER BY i.InterviewDateTime) AS RowNumber
    FROM Interviews i
)
SELECT
    rr.CandidateID,
    rr.InterviewDateTime
FROM
    RowsR rr
WHERE
    rr.RowNumber BETWEEN 1 AND 20;

--5
WITH RowsR AS (
    SELECT
        i.CandidateID,
        i.InterviewDateTime,
        ROW_NUMBER() OVER (PARTITION BY i.InterviewDateTime ORDER BY i.InterviewDateTime) AS RowNumber
    FROM
       Interviews i
)
DELETE FROM RowsR WHERE RowNumber > 1;
--6
WITH Last6Month AS (
    SELECT
        i.InterviewID,
        i.InterviewDateTime,
        RANK() OVER (ORDER BY EXTRACT(MONTH FROM i.InterviewDateTime) DESC) AS MonthRank
    FROM
    Interviews i
    WHERE
    i.InterviewResult like 'P%'
    GROUP BY
        i.InterviewDateTime,i.InterviewID
)
SELECT
    hri.InterviewerID,
    COUNT(hri.InterviewerID) AS CountCandid
FROM
    Interviews i
JOIN
    Last6Month l ON i.InterviewID = l.InterviewID AND l.MonthRank < 60
JOIN
    InterviewsWithInterviewers hri ON i.InterviewID = hri.InterviewID AND l.InterviewID = hri.InterviewID
GROUP BY
    hri.InterviewerID
ORDER BY
    CountCandid;

--7
--В какой месяц было принято максимальное количество людей

WITH MonthlyInterviewCounts AS (
    SELECT 
        hri.InterviewerID,
        EXTRACT(MONTH FROM i.InterviewDateTime) as month,
        COUNT(DISTINCT i.InterviewID) as InterviewCount,
        RANK() OVER (PARTITION BY hri.InterviewerID ORDER BY COUNT(i.InterviewID) DESC) as rnk
    FROM
        Interviews i
    JOIN
        InterviewsWithInterviewers hri ON i.InterviewID = hri.InterviewID
    GROUP BY
        hri.InterviewerID, EXTRACT(MONTH FROM i.InterviewDateTime)
)

SELECT 
    InterviewerID,
    month,
    InterviewCount
FROM 
    MonthlyInterviewCounts
WHERE 
    rnk = 1;

--6 laba 
Select * from Interviews
--1. Разработайте локальную процедуру и локальную функцию для своей БД по варианту.
CREATE OR REPLACE PROCEDURE UpdateInterviewLocation(p_InterviewID NUMBER, p_NewLocation NVARCHAR2) AS
BEGIN
    BEGIN
        UPDATE Interviews SET Location = p_NewLocation WHERE InterviewID = p_InterviewID;
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('Местоположение интервью успешно обновлено.');
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('Интервью не найдено.');
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Произошла ошибка: ' || SQLERRM);
    END;
END UpdateInterviewLocation;


CREATE OR REPLACE FUNCTION GetInterviewCount(p_CandidateID NUMBER) RETURN NUMBER AS
    v_Count NUMBER;
BEGIN
    BEGIN
        SELECT COUNT(*) INTO v_Count FROM Interviews WHERE CandidateID = p_CandidateID;
        RETURN v_Count;
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Произошла ошибка: ' || SQLERRM);
            RETURN NULL;
    END;
END GetInterviewCount;


DECLARE
    v_CandidateID NUMBER := 21;
BEGIN
    UpdateInterviewLocation(123, 'New Location');
    DBMS_OUTPUT.PUT_LINE('Interview Count for Candidate ' || v_CandidateID || ': ' || GetInterviewCount(v_CandidateID));
END;
Select * from Interviews
--3. Разработайте 2 хранимые процедуры: одну для выполнения какого-либо DML-оператора для своей БД по варианту, 
--а вторую – для получения какого-либо результирующего набора для своей БД по варианту. Предусмотрите обработку ошибок.
CREATE OR REPLACE PROCEDURE DeleteInterview(p_InterviewID IN NUMBER) AS
BEGIN
    BEGIN
        DELETE FROM Interviews WHERE InterviewID = p_InterviewID;
        DBMS_OUTPUT.PUT_LINE('Интервью успешно удалено.');
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('Интервью не найдено.');
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Произошла ошибка: ' || SQLERRM);
    END;
END;

CREATE OR REPLACE PROCEDURE GetInterviewInfo(p_InterviewID IN NUMBER) AS
    v_Result NVARCHAR2(255);
BEGIN
    BEGIN
        SELECT InterviewResult INTO v_Result FROM Interviews WHERE InterviewID = p_InterviewID;
        DBMS_OUTPUT.PUT_LINE('Результат интервью: ' || v_Result);
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('Интервью не найдено.');
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Произошла ошибка: ' || SQLERRM);
    END;
END;

DECLARE
    v_InterviewID NUMBER := 233;
BEGIN
    DeleteInterview(v_InterviewID);
    GetInterviewInfo(v_InterviewID);
END;
--5. Разработайте 2 функции, определенные пользователем: одну для вычисления какого-либо агрегатного значения 
--над набором строк для своей БД по варианту (например, суммы или среднего),
--а вторую – для обработки дат для своей БД по варианту (например, получения разницы дат).
CREATE OR REPLACE FUNCTION calculate_aggregate(candidate_id_in NUMBER) RETURN NUMBER IS
    total_interviews NUMBER;
BEGIN
    BEGIN
        SELECT COUNT(*) INTO total_interviews FROM Interviews WHERE CandidateID = candidate_id_in;
        RETURN total_interviews;
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Произошла ошибка: ' || SQLERRM);
            RETURN NULL;
    END;
END calculate_aggregate;

CREATE OR REPLACE FUNCTION date_difference(interview_id_1_in NUMBER, interview_id_2_in NUMBER) RETURN NUMBER IS
    diff_days NUMBER;
BEGIN
    BEGIN
        SELECT ABS(TRUNC(i1.InterviewDateTime) - TRUNC(i2.InterviewDateTime))
        INTO diff_days
        FROM Interviews i1, Interviews i2
        WHERE i1.InterviewID = interview_id_1_in AND i2.InterviewID = interview_id_2_in;
        RETURN diff_days;
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Произошла ошибка: ' || SQLERRM);
            RETURN NULL;
    END;
END date_difference;

SELECT 
    CandidateID,
    calculate_aggregate(CandidateID) AS TotalInterviews,
    date_difference(233, 234) AS DaysBetweenInterviews
FROM 
    Interviews

DECLARE
    total_interviews_for_candidate NUMBER;
    days_between_interivews NUMBER;
BEGIN
    total_interviews_for_candidate := calculate_aggregate(21);
    IF total_interviews_for_candidate IS NOT NULL THEN
        DBMS_OUTPUT.PUT_LINE('Общее количество интервью для Кандидата 1: ' || total_interviews_for_candidate);
    END IF;

    days_between_interivews := date_difference(233, 234);
    IF days_between_interivews IS NOT NULL THEN
        DBMS_OUTPUT.PUT_LINE('Дни между Интервью 1 и Интервью 2: ' || days_between_interivews);
    END IF;
END;

--8. Разработайте пакет, содержащий данные процедуры и функции:
CREATE OR REPLACE PACKAGE InterviewPackage AS
    PROCEDURE update_interview_location(interview_id_in NUMBER, new_location_in NVARCHAR2);
    FUNCTION get_interview_result(interview_id_in NUMBER) RETURN NVARCHAR2;
END InterviewPackage;

CREATE OR REPLACE PACKAGE BODY InterviewPackage AS
    PROCEDURE update_interview_location(interview_id_in NUMBER, new_location_in NVARCHAR2) IS
    BEGIN
        BEGIN
            UPDATE Interviews SET Location = new_location_in WHERE InterviewID = interview_id_in;
        EXCEPTION
            WHEN OTHERS THEN
                DBMS_OUTPUT.PUT_LINE('Произошла ошибка: ' || SQLERRM);
        END;
    END update_interview_location;

    FUNCTION get_interview_result(interview_id_in NUMBER) RETURN NVARCHAR2 IS
        result NVARCHAR2(255);
    BEGIN
        BEGIN
            SELECT InterviewResult INTO result FROM Interviews WHERE InterviewID = interview_id_in;
            RETURN result;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                DBMS_OUTPUT.PUT_LINE('Интервью не найдено.');
            WHEN OTHERS THEN
                DBMS_OUTPUT.PUT_LINE('Произошла ошибка: ' || SQLERRM);
                RETURN NULL;
        END;
    END get_interview_result;
END InterviewPackage;
        

DECLARE
    new_location NVARCHAR2(255);
    interview_result NVARCHAR2(255);
BEGIN
    InterviewPackage.update_interview_location(1, 'Новое Место');

    interview_result := InterviewPackage.get_interview_result(233);
    IF interview_result IS NOT NULL THEN
        DBMS_OUTPUT.PUT_LINE('Результат интервью для Интервью 1: ' || interview_result);
    END IF;
END



