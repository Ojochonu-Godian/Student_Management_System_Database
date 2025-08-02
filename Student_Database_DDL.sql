 -- Create the database

CREATE DATABASE Student_Management_System_Database;

-- Use the database
USE Student_Management_System_Database;

--Create Table: Departments

CREATE TABLE Departments (
	DepartmentID VARCHAR(30) PRIMARY KEY,
	DepartmentName VARCHAR(50) NOT NULL,
);

-- Create Table: Students

CREATE TABLE Students (
	StudentID VARCHAR(30) PRIMARY KEY,
	FirstName NVARCHAR(30) NOT NULL,
	LastName NVARCHAR(30) NOT NULL,
	Gender NVARCHAR(10) NOT NULL CHECK (Gender IN ('Male', 'Female', 'Others')),
	Date_of_Birth DATE,
	DepartmentID VARCHAR(30) FOREIGN KEY 
	REFERENCES Departments(DepartmentID)
);

-- Create Table: Courses

CREATE TABLE Courses (
	CourseID VARCHAR(30) PRIMARY KEY,
	CourseName VARCHAR(100) NOT NULL,
	DepartmentID VARCHAR(30) FOREIGN KEY
	REFERENCES Departments(DepartmentID)
);

-- Create Table: Enrollments

CREATE TABLE Enrollments (
	EnrollmentID VARCHAR(30) PRIMARY KEY,
	StudentID VARCHAR(30) FOREIGN KEY REFERENCES Students(StudentID),
	CourseID VARCHAR(30) FOREIGN KEY REFERENCES Courses(CourseID),
	EnrollmentDate Date
);

-- Create Table: Instructors

CREATE TABLE Instructors (
	InstructorID VARCHAR(30) PRIMARY KEY,
	Title VARCHAR(10),
	FirstName NVARCHAR(30) NOT NULL,
	LastName NVARCHAR(30) NOT NULL,
	Gender NVARCHAR(10) NOT NULL CHECK (Gender IN ('Male', 'Female', 'Others')),
	DepartmentID VARCHAR(30) FOREIGN KEY REFERENCES Departments(DepartmentID),
);
-- Create CourseInstructors table

CREATE TABLE CourseInstructors (
    CourseID VARCHAR(30) FOREIGN KEY REFERENCES Courses(CourseID),
    InstructorID VARCHAR(30) FOREIGN KEY REFERENCES Instructors(InstructorID),
    PRIMARY KEY (CourseID, InstructorID)
);


/* 

Although the sample data was inserted into each table using MS SQL Server Import-Export wizard,
Here is how it would be done using DDL.
*/

--Inserting Data into the Departments Table

INSERT INTO Departments(DepartmentID, DepartmentName)
VALUES 
('DPT001', 'Computer Science'),
('DPT002', 'Mathematics'),
('DPT003', 'Physics')
;

--Inserting Data into the Students Table

INSERT INTO Students (StudentID, FirstName, LastName, Gender, Date_of_Birth, DepartmentID) 
VALUES
('STU001', 'Emily', 'Johnson', 'Female', '2000-05-15', 'DPT001'),
('STU002', 'Michael', 'Chen', 'Male', '2001-02-20', 'DPT009'),
('STU003', 'Sophia', 'Williams', 'Female', '1999-11-30', 'DPT002');
;

--Inserting Data into the Courses Table

INSERT INTO Courses (CourseID, CourseName, DepartmentID) 
VALUES
('CSC101', 'Introduction to Programming', 'DPT001'),
('CSC102', 'Object-Oriented Programming', 'DPT001'),
('CSC201', 'Data Structures', 'DPT001')
;

--Inserting Data into the Enrollments Table

INSERT INTO Enrollments (EnrollmentID, StudentID, CourseID, EnrollmentDate) 
VALUES
('ENR001', 'STU001', 'CSC101', '2023-09-12'),
('ENR002', 'STU001', 'MTH101', '2023-09-05'),
('ENR003', 'STU001', 'ENG101', '2023-09-18')
;

--Inserting Data into the Instructors Table

INSERT INTO Instructors (InstructorID, Title, FirstName, LastName, DepartmentID) 
VALUES
('INST001', 'Prof.', 'Alan', 'Turing', 'DPT001'),
('INST002', 'Dr.', 'Grace', 'Hopper', 'DPT001'),
('INST003', 'Prof.', 'Donald', 'Knuth', 'DPT001'),
('INST004', 'Dr.', 'Barbara', 'Liskov', 'DPT001')
;

--Inserting Data into the CourseInstructors Table

INSERT INTO CourseInstructors (CourseID, InstructorID)
VALUES
('CSC101', 'INST001'),
('CSC201', 'INST002'),
('CSC201', 'INST003')
;