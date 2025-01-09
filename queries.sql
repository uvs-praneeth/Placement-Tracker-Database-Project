USE Placements;

-- INSERT DATA INTO Companies
INSERT INTO Companies (CompanyID, Name, Contact_Person, MailID, Phone)
VALUES
    (1, 'Google', 'Sandy Williams', 'Williams.sandy@google.com', '+1-6502530000'),
    (2, 'Microsoft', 'Kumaran Swamy', 'swamy@microsoft.com', '+1-4258828080'),
    (3, 'Amazon', 'Jessica smith', 'jessica.smith@amazon.com', '+1-2062661000'),
    (4, 'Tesla', 'Max McDonald', 'Max@tesla.com', '+1-3478003630');

-- INSERT DATA INTO Students
INSERT INTO Students (StudentID, Name, DepartmentName, CGPA, MailID, Phone, ActiveBacklog, GraduationYear)
VALUES
    ('S101', 'Alice', 'Computer Science', 9.2, 'alice@outlook.com', '+91-9876543210', FALSE, 2024),
    ('S102', 'Bob', 'Electronics', 8.5, 'bob@gmail.com', '+91-9876543211', FALSE, 2024),
    ('S103', 'Charlie', 'Mechanical', 7.8, 'charlie@gmail.com', '+91-9876543212', TRUE, 2024),
    ('S104', 'David', 'Civil', 9.0, 'david@gmail.com', '+91-9876543213', FALSE, 2023),
    ('S105', 'Eve', 'Information Technology', 8.7, 'eve@gmail.com', '+91-9876543214', FALSE, 2024),
    ('S106', 'Isagi', 'Computer Science', 8.7, 'isagi@yahoo.com', '+91-9876543214', FALSE, 2024);


-- INSERT DATA INTO Jobs
INSERT INTO Jobs (JobID, CompanyID, Role, TechJob, JobType, Description, Posted, Salary, ApplicationEnd, ApplyLink)
VALUES
    ('J101', 1, 'Software Engineer', TRUE, 'Full-time', 'Develop and maintain software systems.', '2024-01-01', 30.0, '2024-03-01', 'google.com/apply/GJOB-99885432'),
    ('J102', 2, 'Data Analyst', TRUE, 'Internship', 'Analyze data for business insights.', '2024-01-15', 10.0, '2024-02-15', 'microsoft.com/apply/?jd345609'),
    ('J103', 3, 'Product Manager', FALSE, 'Full-time', 'Oversee product development.', '2024-02-01', 25.0, '2024-03-15', 'amazon.com/apply/JD009876'),
    ('J104', 4, 'Design Engineer', FALSE, 'Full-time', 'Design Architecture', '2024-02-01', 19.5, '2024-03-15', 'tesla.com/apply/000981');


-- INSERT DATA INTO Applications
INSERT INTO Applications (ApplicationID, JobID, StudentID, Applied, ApplicationStatus)
VALUES
    ('A101', 'J101', 'S101', '2024-01-10', 'Shortlisted'),
    ('A102', 'J102', 'S102', '2024-01-20', 'Shortlisted'),
    ('A103', 'J103', 'S103', '2024-02-05', 'Not-Shortlisted'),
    ('A104', 'J101', 'S105', '2024-01-25', 'Shortlisted'),
    ('A105', 'J102', 'S104', '2024-01-30', 'Applied'),
    ('A106', 'J101', 'S106', '2024-01-30', 'Shortlisted');

-- RETRIEVE THE TOP PLACED STUDENTS FROM 2024 BATCH.

-- TOP 3 HIGH PAID STUDENTS LIST
SELECT *
FROM Placed_Students
ORDER BY CTC_in_LPA DESC
LIMIT 3;

-- PERCENTAGE OF STUDENTS NOT YET PLACED IN YEAR 2024
SELECT ROUND(100 - Placement_Percentage, 1) AS Unplaced_Students_Percentage
FROM Placed_Students_Percentage;

-- AVERAGE CTC in Year 2024
SELECT AVG(CTC_in_LPA)
FROM Placed_Students;

-- STUDENTS NOT YET PLACED
SELECT *
FROM Students Student
WHERE NOT EXISTS(SELECT 1
                 FROM Placed_Students
                 WHERE Student.StudentID = Placed_Students.StudentID);
-- Update
UPDATE Applications SET ApplicationsStatus = 'Shortlisted'
WHERE (ApplicationID = 'A105') AND (JobID = 'J102') AND (StudentID = 'S104');

-- Delete a record where job id is j104.
DELETE FROM Jobs
WHERE JobID = 'J104';


