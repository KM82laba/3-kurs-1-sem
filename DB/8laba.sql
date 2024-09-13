-- �������� ���������� ���� ������ ��� ��������
CREATE TYPE InterviewType AS OBJECT (
  InterviewID NUMBER,
  CandidateID NUMBER,
  VacancyID NUMBER,
  InterviewDateTime DATE,
  Location NVARCHAR2(255),
  InterviewResult NVARCHAR2(255),
  Parents NUMBER,

  -- �������������� �����������
  CONSTRUCTOR FUNCTION InterviewType (
    InterviewID NUMBER,
    CandidateID NUMBER,
    VacancyID NUMBER,
    InterviewDateTime DATE,
    Location NVARCHAR2,
    InterviewResult NVARCHAR2,
    Parents NUMBER
  ) RETURN SELF AS RESULT,

  -- ����� ��������� ���� MAP
  ORDER MEMBER FUNCTION is_older(p_obj InterviewType) RETURN NUMBER,

  -- ����� ���������� �������
  MEMBER FUNCTION getInterviewDetails RETURN VARCHAR2,

  -- ����� ���������� ���������
  MEMBER PROCEDURE updateInterviewResult(p_result NVARCHAR2)
);

-- ���������� ���������� ���� ������
CREATE TYPE BODY InterviewType AS
  -- �������������� �����������
  CONSTRUCTOR FUNCTION InterviewType (
    InterviewID NUMBER,
    CandidateID NUMBER,
    VacancyID NUMBER,
    InterviewDateTime DATE,
    Location NVARCHAR2,
    InterviewResult NVARCHAR2,
    Parents NUMBER
  ) RETURN SELF AS RESULT IS
  BEGIN
    SELF.InterviewID := InterviewID;
    SELF.CandidateID := CandidateID;
    SELF.VacancyID := VacancyID;
    SELF.InterviewDateTime := InterviewDateTime;
    SELF.Location := Location;
    SELF.InterviewResult := InterviewResult;
    SELF.Parents := Parents;
    RETURN;
  END;

  -- ����� ��������� ���� ORDER
  ORDER MEMBER FUNCTION is_older(p_obj InterviewType) RETURN NUMBER IS
  BEGIN
    -- ���� ������ ���������, ��������, �� InterviewID
    IF SELF.InterviewDateTime > p_obj.InterviewDateTime 
        THEN RETURN -1; -- 1 > 2
    ELSIF SELF.InterviewDateTime < p_obj.InterviewDateTime 
        THEN RETURN 1; -- 1 < 2
    ELSE RETURN 0;
    END IF;
  END;

  -- ����� ���������� �������
  MEMBER FUNCTION getInterviewDetails RETURN VARCHAR2 IS
  BEGIN
    RETURN 'Interview ID: ' || TO_CHAR(InterviewID) ||
           ', Candidate ID: ' || TO_CHAR(CandidateID) ||
           ', Vacancy ID: ' || TO_CHAR(VacancyID) ||
           ', Interview DateTime: ' || TO_CHAR(InterviewDateTime, 'DD-MON-YYYY HH24:MI:SS') ||
           ', Location: ' || Location ||
           ', Interview Result: ' || InterviewResult ||
           ', Parents: ' || TO_CHAR(Parents);
  END;

  -- ����� ���������� ���������
  MEMBER PROCEDURE updateInterviewResult(p_result NVARCHAR2) IS
  BEGIN
    SELF.InterviewResult := p_result;
  END;
END;

SELECT * FROM Interviews

DECLARE
  interview_obj InterviewType;
BEGIN
  -- ������������� �������
  interview_obj := InterviewType(NULL, NULL, NULL, NULL, NULL, NULL, NULL);

  -- ������� ������ �� ����������� �������
  SELECT InterviewID, CandidateID, VacancyID, InterviewDateTime, Location, InterviewResult, Parents
  INTO interview_obj.InterviewID, interview_obj.CandidateID, interview_obj.VacancyID,
       interview_obj.InterviewDateTime, interview_obj.Location, interview_obj.InterviewResult, interview_obj.Parents
  FROM Interviews
  WHERE InterviewID = 161; -- �������� �� ���� ������� �������

  -- �������� ������� � �������������� ������������
  interview_obj := InterviewType(
    interview_obj.InterviewID,
    interview_obj.CandidateID,
    interview_obj.VacancyID,
    interview_obj.InterviewDateTime,
    interview_obj.Location,
    interview_obj.InterviewResult,
    interview_obj.Parents
  );

  -- ����� ������ (��� ����� ���� ���� ������ ��������� �������)
  DBMS_OUTPUT.PUT_LINE('Interview ID: ' || TO_CHAR(interview_obj.InterviewID));
  DBMS_OUTPUT.PUT_LINE('Candidate ID: ' || TO_CHAR(interview_obj.CandidateID));
  DBMS_OUTPUT.PUT_LINE('Vacancy ID: ' || TO_CHAR(interview_obj.VacancyID));
  DBMS_OUTPUT.PUT_LINE('Interview DateTime: ' || TO_CHAR(interview_obj.InterviewDateTime, 'DD-MON-YYYY HH24:MI:SS'));
  DBMS_OUTPUT.PUT_LINE('Location: ' || interview_obj.Location);
  DBMS_OUTPUT.PUT_LINE('Interview Result: ' || interview_obj.InterviewResult);
  DBMS_OUTPUT.PUT_LINE('Parents: ' || TO_CHAR(interview_obj.Parents));
END;

DECLARE
  interview_first InterviewType;
  interview_second InterviewType;
  is_older NUMBER(1);
BEGIN
  -- ������������� ��������
  interview_first := InterviewType(1, 101, 201, TO_DATE('2023-01-14 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Location_first', 'Result_first', NULL);
  interview_second := InterviewType(2, 102, 202, TO_DATE('2023-01-15 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Location_second', 'Result_second', NULL);

  -- ����� ������ is_older
  is_older := interview_first.is_older(interview_second);

  -- ����� ����������
  IF is_older = 1 THEN
    DBMS_OUTPUT.PUT_LINE('Interview_first is older than Interview_second');
  ELSIF is_older = -1 THEN
    DBMS_OUTPUT.PUT_LINE('Interview_second is older than Interview_first');
  ELSE
    DBMS_OUTPUT.PUT_LINE('Interview_first and Interview_second have the same InterviewDateTime');
  END IF;

  -- ���������� ���������� ��������
  interview_first.updateInterviewResult('Updated Result for Interview_first');

  -- ����� ���������� �� ��������
  DBMS_OUTPUT.PUT_LINE(interview_first.getInterviewDetails());
  DBMS_OUTPUT.PUT_LINE(interview_second.getInterviewDetails());
END;

CREATE TABLE interview_obj OF InterviewType;
INSERT INTO interview_obj SELECT * FROM Interviews;

CREATE VIEW InterviewView AS
SELECT
  InterviewType(
    InterviewID,
    CandidateID,
    VacancyID,
    InterviewDateTime,
    Location,
    InterviewResult,
    Parents
  ) AS interview_obj
FROM Interviews;

Select * from InterviewView
-- �� �������� 
CREATE INDEX idx_interview_location ON interview_obj(Location);
-- �� ������ 
CREATE INDEX idx_interview_is_older ON interview_obj(MEMBER FUNCTION is_older(p_obj InterviewType) RETURN NUMBER);
create bitmap index idx_interview_is_older on interview_obj(Interviews.getInterviewDetails());

-- �������� ���������� ���� ������ ��� ���������
CREATE TYPE CandidateType AS OBJECT (
  CandidateID NUMBER,
  LastName NVARCHAR2(255),
  FirstName NVARCHAR2(255),
  MiddleName NVARCHAR2(255),
  DateOfBirth DATE,
  Gender NVARCHAR2(10),
  Experience NVARCHAR2(255),
  Source NVARCHAR2(255),
  Status NVARCHAR2(255),

  -- �������������� �����������
  CONSTRUCTOR FUNCTION CandidateType (
    CandidateID NUMBER,
    LastName NVARCHAR2,
    FirstName NVARCHAR2,
    MiddleName NVARCHAR2,
    DateOfBirth DATE,
    Gender NVARCHAR2,
    Experience NVARCHAR2,
    Source NVARCHAR2,
    Status NVARCHAR2
  ) RETURN SELF AS RESULT,

  -- ����� ���������� �������
  MEMBER FUNCTION getCandidateDetails RETURN VARCHAR2,

  -- ����� ���������� ������� ��� ���������� ��������
  MEMBER FUNCTION getCandidateAge RETURN NUMBER
);

-- ���������� ���������� ���� ������ ��� ���������
CREATE TYPE BODY CandidateType AS
  -- �������������� �����������
  CONSTRUCTOR FUNCTION CandidateType (
    CandidateID NUMBER,
    LastName NVARCHAR2,
    FirstName NVARCHAR2,
    MiddleName NVARCHAR2,
    DateOfBirth DATE,
    Gender NVARCHAR2,
    Experience NVARCHAR2,
    Source NVARCHAR2,
    Status NVARCHAR2
  ) RETURN SELF AS RESULT IS
  BEGIN
    SELF.CandidateID := CandidateID;
    SELF.LastName := LastName;
    SELF.FirstName := FirstName;
    SELF.MiddleName := MiddleName;
    SELF.DateOfBirth := DateOfBirth;
    SELF.Gender := Gender;
    SELF.Experience := Experience;
    SELF.Source := Source;
    SELF.Status := Status;
    RETURN;
  END;

  -- ����� ���������� �������
  MEMBER FUNCTION getCandidateDetails RETURN VARCHAR2 IS
  BEGIN
    RETURN 'Candidate ID: ' || TO_CHAR(CandidateID) ||
           ', Last Name: ' || LastName ||
           ', First Name: ' || FirstName ||
           ', Middle Name: ' || MiddleName ||
           ', Date of Birth: ' || TO_CHAR(DateOfBirth, 'DD-MON-YYYY') ||
           ', Gender: ' || Gender ||
           ', Experience: ' || Experience ||
           ', Source: ' || Source ||
           ', Status: ' || Status;
  END;

  -- ����� ���������� ������� ��� ���������� ��������
  MEMBER FUNCTION getCandidateAge RETURN NUMBER IS
    current_date DATE := SYSDATE;
    birth_date DATE := DateOfBirth;
  BEGIN
    RETURN calculateAge(birth_date, current_date);
  END;
END;


-- ������� ��� ���������� ��������
CREATE OR REPLACE FUNCTION calculateAge(birth_date DATE, current_date DATE) RETURN NUMBER IS
BEGIN
  RETURN TRUNC(MONTHS_BETWEEN(current_date, birth_date) / 12);
END;


-- �������� ������� ��� ����������
CREATE TABLE Candidates_t OF CandidateType;

-- ���������� ������� �����������
INSERT INTO Candidates_t
SELECT
  CandidateType(
    CandidateID,
    LastName,
    FirstName,
    MiddleName,
    DateOfBirth,
    Gender,
    Experience,
    Source,
    Status
  )
FROM Candidates;

-- �������� ���������� ������������� ��� ����������
CREATE VIEW CandidateView AS
SELECT
  t.CandidateID,
  t.Candidate.getCandidateDetails() AS CandidateDetails
FROM Candidates t;

-- �������� ������� �� ��������
CREATE INDEX idx_candidate_lastname ON Candidates(LastName);

-- �������� ������� �� ������
create bitmap index idx_candidate_age on Candidates(Candidates.getCandidateAge());


