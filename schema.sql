CREATE DATABASE Placements;
USE Placements;

-- CREATING THE COMPANIES TABLE
CREATE TABLE Companies(
    CompanyID INT PRIMARY KEY,
    Name VARCHAR(128),
    Contact_Person VARCHAR(128),
    MailID VARCHAR(128),
    Phone VARCHAR(14)
);

-- CREATING THE STUDENTS TABLE
CREATE TABLE Students(
    StudentID VARCHAR(50) PRIMARY KEY,
    Name VARCHAR(128),
    DepartmentName VARCHAR(128),
    CGPA DECIMAL(2),
    MailID VARCHAR(128),
    Phone VARCHAR(14),
    ActiveBacklog BOOLEAN
);

-- CREATING THE JOB OFFERINGS
CREATE TABLE Jobs(
    JobID VARCHAR(50) PRIMARY KEY,
    CompanyID INT REFERENCES Companies(CompanyID),
    Role VARCHAR(128),
    TechJob BOOLEAN,
    JobType ENUM('Internship', 'Full-time'),
    Description TINYTEXT,
    Posted DATETIME,
    Salary DOUBLE,
    ApplicationEnd DATETIME,
    ApplyLink VARCHAR(128)
);

-- CREATING APPLICATIONS TABLE
CREATE TABLE Applications(
    ApplicationID VARCHAR(50),
    JobID VARCHAR(50) REFERENCES Jobs(JobID),
    StudentID VARCHAR(50) REFERENCES Students(StudentID),
    Applied DATETIME,
    ApplicationStatus ENUM('Applied', 'Shortlisted', 'Not-Shortlisted')
);


ALTER TABLE Students ADD COLUMN GraduationYear INT;

-- INDEXES TIME
CREATE INDEX Applications_IDX ON Applications (ApplicationStatus);

CREATE INDEX Graduation_idx ON Students (GraduationYear);

-- VIEWS TIME
CREATE VIEW Placed_Students AS
SELECT App.ApplicationID,
       Company.Name AS CompanyName,
       Student.StudentID,
       Student.Name AS StudentName,
       Student.MailID,
       Job.Salary AS CTC_in_LPA,
       Job.Role
FROM Applications App
         JOIN Jobs Job ON App.JobID = Job.JobID
         JOIN Companies Company ON Job.CompanyID = Company.CompanyID
         JOIN Students Student ON App.StudentID = Student.StudentID
WHERE ApplicationStatus = 'Shortlisted'
  AND GraduationYear = 2024;

-- A VIEW PERCENTAGE OF STUDENTS PLACED IN THE YEAR 2024

CREATE VIEW Placed_Students_Percentage AS
SELECT (COUNT(CASE WHEN Applications.ApplicationStatus = 'Shortlisted' THEN 1 END) * 100 /
        COUNT(Student.StudentID)) AS Placement_Percentage
FROM Students Student
         JOIN Applications ON Student.StudentID = Applications.StudentID
WHERE GraduationYear = 2024;
