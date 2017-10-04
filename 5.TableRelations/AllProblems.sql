--Problem 1.	One-To-One Relationship
CREATE TABLE Persons(
PersonID INT PRIMARY KEY IDENTITY,
FirstName VARCHAR(50) NOT NULL,
Salary DECIMAL,
PassportID INT UNIQUE
)
CREATE TABLE Passports
(
PassportID INT PRIMARY KEY,
PassportNumber VARCHAR(255)NOT NULL
)
INSERT INTO Persons(FirstName,Salary,PassportID)
VALUES
('Roberto',43300.00,102),
('Tom',56100.00,103),
('Yana',60200.00,101)


INSERT INTO Passports(PassportID,PassportNumber)
VALUES
(101,'N34FG21B'),
(102,'K65LO4R7'),
(103,'ZE657QP2')

ALTER TABLE Persons
ADD CONSTRAINT FK_Persons_Passports FOREIGN KEY(PassportID) REFERENCES Passports(PassportID)


--Problem 2.	One-To-Many Relationship
CREATE TABLE Manufacturers
(
ManufacturerID INT PRIMARY KEY IDENTITY,
Name VARCHAR(50) NOT NULL,
EstablishedOn date
)
CREATE TABLE Models
(
ModelID INT PRIMARY KEY,
Name VARCHAR(50)NOT NULL,
ManufacturerID INT FOREIGN KEY REFERENCES Manufacturers(ManufacturerID)
)

INSERT INTO Manufacturers(Name,EstablishedOn)
VALUES
('BMW','07/03/1916'),
('Tesla','01/01/2003'),
('Lada','01/05/1966')

INSERT INTO Models(ModelID,Name,ManufacturerID)
VALUES
(101,'X1',1),
(102,'i6',1),
(103,'Model S',2),
(104,'Model X',2),
(105,'Model 3',2),
(106,'Nova',3)
SELECT*FROM Models,Manufacturers
--Problem 3.	Many-To-Many Relationship 

CREATE TABLE Students
(
StudentID INT PRIMARY KEY IDENTITY,
Name VARCHAR(50) NOT NULL,
)
CREATE TABLE Exams
(
ExamID INT PRIMARY KEY,
Name VARCHAR (50) NOT NULL
)
CREATE TABLE StudentsExams
(
StudentID INT,
ExamID INT,
CONSTRAINT PK_StudentsExams PRIMARY KEY(StudentID,ExamID),
CONSTRAINT FK_StudentsExams_Students FOREIGN KEY(StudentID)
REFERENCES Students(StudentID),
CONSTRAINT FK_StudentsExams_Exams FOREIGN KEY(ExamID)
REFERENCES Exams(ExamID)
)
INSERT INTO Students(Name)
VALUES
('Mila'),
('Toni'),
('Ron')

INSERT INTO Exams(ExamID,Name)
VALUES
(101,'SpringMVC'),
(102,'Neo4j'),
(103,'Oracle 11g')

INSERT INTO StudentsExams(StudentID,ExamID)
VALUES
(1,101),
(1,102),
(2,101),
(3,103),
(2,102),
(2,103)
SELECT*FROM StudentsExams

--Problem 4.	Self-Referencing

Create TABLE Teachers(
TeacherID INT PRIMARY KEY,
Name VARCHAR(50)NOT NULL,
ManagerID INT,
CONSTRAINT FK_Teachers_ManagerID FOREIGN KEY (ManagerID) REFERENCES Teachers(TeacherID)
) 

INSERT INTO Teachers(TeacherID,Name,ManagerID)
 VALUES
  (101, 'John', NULL),
  (102, 'Maya', 106),
  (103, 'Silvia', 106),
  (104, 'Ted', 105),
  (105, 'Mark', 101),
  (106, 'Greta', 101)

--Problem 5.	Online Store Database
CREATE TABLE Cities(
  CityID INT PRIMARY KEY,
  Name VARCHAR(50) NOT NULL,
)

CREATE TABLE Customers(
  CustomerID INT PRIMARY KEY,
  Name VARCHAR(50) NOT NULL,
  Birthday DATE,
  CityID INT,
  CONSTRAINT FK_Customers_Cities FOREIGN KEY (CityID) REFERENCES Cities(CityID)
)

CREATE TABLE Orders(
  OrderID INT PRIMARY KEY,
  CustomerID INT NOT NULL,
  CONSTRAINT FK_Orders_Customers FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
)

CREATE TABLE ItemTypes(
  ItemTypeID INT PRIMARY KEY,
  Name VARCHAR(50) NOT NULL,
)

CREATE TABLE Items(
  ItemID INT PRIMARY KEY,
  Name VARCHAR(50) NOT NULL,
  ItemTypeID INT NOT NULL,
  CONSTRAINT FK_Items_ItemTypes FOREIGN KEY (ItemTypeID) REFERENCES ItemTypes(ItemTypeID)
)

CREATE TABLE OrderItems(
  OrderID INT NOT NULL,
  ItemID INT NOT NULL,
  CONSTRAINT PK_OrderItems PRIMARY KEY (OrderID, ItemID),
  CONSTRAINT FK_OrderItems_Orders FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
  CONSTRAINT FK_OrderItems_Items FOREIGN KEY (ItemID) REFERENCES Items(ItemID)
)
--Problem 6.	University Database
--CREATE DATABASE UniversityDatabase
--USE UniversityDatabase

CREATE TABLE Majors
(
MajorID INT PRIMARY KEY,
Name VARCHAR(50)NOT NULL,
)
CREATE TABLE Students
(
StudentID INT PRIMARY KEY,
StudentNumber INT NOT NULL,
StudentName VARCHAR(50) NOT NULL,
MajorID INT,
CONSTRAINT FK_Students_Majors FOREIGN KEY (MajorID) REFERENCES Majors(MajorID)
)
CREATE TABLE Subjects
(
SubjectID INT PRIMARY KEY,
SubjectName VARCHAR(50)
)
CREATE TABLE Agenda
(
StudentID INT,
SubjectID INT ,
CONSTRAINT PK_Agenda_ PRIMARY KEY(StudentID,SubjectID),
CONSTRAINT FK_Agenda_Subject  FOREIGN KEY (SubjectID) REFERENCES Subjects(SubjectID),
CONSTRAINT FK_Agenda_Students  FOREIGN KEY(StudentID) REFERENCES Students(StudentID) 
)

CREATE TABLE Payments
(
PaymentID INT PRIMARY KEY,
PaymantDate DATE NOT NULL,
PaymentAmount DECIMAL,
StudentID INT,
CONSTRAINT FK_Payments_Students FOREIGN KEY(StudentID) REFERENCES Students(StudentID)
)

--Problem 9.	*Peaks in Rila
SELECT*FROM Peaks
SELECT * FROM Mountains
SELECT MountainRange,PeakName,Elevation FROM Peaks as p
JOIN Mountains AS m ON p.MountainId=m.Id
WHERE m.MountainRange='Rila'
ORDER BY Elevation DESC


