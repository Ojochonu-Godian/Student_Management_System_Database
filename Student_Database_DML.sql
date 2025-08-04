
USE Student_Management_System_Database;

-- STUDENTS AND ENROLLMENT REPORTS


-- How many students are currently enrolled in each course?

SELECT c.CourseName, c.CourseID, COUNT(e.StudentID) AS No_of_Students_Enrolled
FROM Courses c
JOIN Enrollments e
ON c.CourseID = e.CourseID
GROUP BY c.CourseName, c.CourseID
ORDER BY No_of_Students_Enrolled DESC;


-- Which students are enrolled in multiple courses, and which courses are they taking?

SELECT s.FirstName + ' ' + s.LastName AS FullName, s.StudentID, c.CourseID, c.CourseName
FROM Enrollments e
JOIN Students s
ON s.StudentID = e.StudentID
JOIN Courses c
ON c.CourseID = e.CourseID
WHERE e.StudentID IN (
	SELECT StudentID
	FROM Enrollments
	GROUP BY StudentID
	HAVING COUNT(EnrollmentID) > 1)
ORDER BY FullName, CourseID;


-- What is the total number of students per department across all courses?

SELECT d.DepartmentID, d.DepartmentName, COUNT(DISTINCT s.StudentID) AS No_of_Students 
FROM Departments d
JOIN Students s
ON d.DepartmentID = s.DepartmentID
GROUP BY d.DepartmentID, d.DepartmentName
ORDER BY No_of_Students DESC;


-- COURSE AND INSTRUCTOR ANALYSIS


-- Which courses have the highest number of enrollments?

SELECT TOP 3 c.CourseID, c.CourseName, COUNT(e.EnrollmentID) AS No_of_Enrollments
FROM Enrollments e
JOIN Courses c
ON c.CourseID = e.CourseID
GROUP BY c.CourseID, c.CourseName
ORDER BY No_of_Enrollments DESC;


-- Which department has the least number of students?

SELECT TOP 3 d.DepartmentID, d.DepartmentName, COUNT(s.StudentID) AS No_of_Students
FROM Departments d
JOIN Students s
ON s.DepartmentID = d.DepartmentID
GROUP BY d.DepartmentID, d.DepartmentName
ORDER BY No_of_Students ASC;


-- DATA INTEGRITY AND OPERATIONAL INSIGHTS


-- Are there any students not enrolled in any course?

SELECT s.StudentID, s.FirstName + ' ' + s.LastName AS FullName
FROM Students s
LEFT JOIN Enrollments e
ON e.StudentID = s.StudentID
WHERE e.EnrollmentID IS NULL;


-- How many courses does each student take on average?

SELECT AVG(Course_Count) AS Avg_Course_Count_Per_Student
FROM (
	SELECT StudentID, COUNT(CourseID) AS Course_Count
	FROM Enrollments
	GROUP BY StudentID
	) sub
;

-- What is the gender distribution of students across courses and instructors?

--Across Courses

SELECT c.CourseID, c.CourseName, s.Gender, COUNT(s.StudentID) AS No_of_Students
FROM Students s
JOIN Enrollments e
ON e.StudentID = s.StudentID
JOIN Courses c
ON c.CourseID = e.CourseID
GROUP BY c.CourseID, c.CourseName, s.Gender
ORDER BY c.CourseID;

-- Across Instructors

SELECT ci.InstructorID, i.InstructorName, c.CourseID, c.CourseName, s.Gender, COUNT(s.StudentID) AS No_of_Students
FROM (SELECT FirstName + ' ' + LastName AS InstructorName, InstructorID
     FROM Instructors) i
JOIN CourseInstructors ci
ON ci.InstructorID = i.InstructorID
JOIN Courses c
ON c.CourseID = ci.CourseID
JOIN Enrollments e
ON e.CourseID = c.CourseID
JOIN Students s
ON s.StudentID = e.StudentID
GROUP BY ci.InstructorID, i.InstructorName, c.CourseID, c.CourseName, s.Gender
ORDER BY ci.InstructorID, c.CourseID;


-- Which course has the highest number of male or female students enrolled?

SELECT c.CourseID, c.CourseName, s.Gender, COUNT(e.EnrollmentID) as No_of_Students_Enrolled
FROM Courses c
JOIN Enrollments e
ON c.CourseID = e.CourseID
JOIN Students s
ON s.StudentID = e.StudentID
GROUP BY c.CourseID, c.CourseName, s.Gender
ORDER BY No_of_Students_Enrolled DESC;