
CREATE TABLE Categories 
(
Id INT PRIMARY KEY IDENTITY, 
	CategoryName VARCHAR(50) NOT NULL, 
	DailyRate DECIMAL(4, 2) NOT NULL, 
	WeeklyRate DECIMAL(5, 2) NOT NULL, 
	MonthlyRate DECIMAL(6, 2) NOT NULL, 
	WeekendRate DECIMAL(5, 2) NOT NULL,
)

CREATE TABLE Cars (
Id INT PRIMARY KEY IDENTITY,
PlateNumber CHAR(8) NOT NULL,
Manufacturer VARCHAR (50) NOT NULL,
Model VARCHAR(20) NOT NULL,
CarYear INT NOT NULL,
CategoryId INT FOREIGN KEY REFERENCES Categories(Id) NOT NULL,
Doors INT NOT NULL,
Picture VARBINARY(1024),
Condition VARCHAR(50) NOT NULL,
Available BIT NOT NULL
)

CREATE TABLE Employees
(
Id INT PRIMARY KEY IDENTITY,
FirstName NVARCHAR(50)NOT NULL,
LastName NVARCHAR (50) NOT NULL,
Title NVARCHAR(20)NOT NULL,
Notes NVARCHAR(MAX)
)

CREATE TABLE Customers
(
Id INT PRIMARY KEY IDENTITY,
DriverLicenceNumber NVARCHAR(50) NOT NULL,
FullName NVARCHAR (50),
[Address] NTEXT NOT NULL,
 City NVARCHAR (20)NOT NULL, 
 ZIPCode INT NOT NULL,
  Notes NVARCHAR(MAX)
)


CREATE TABLE RentalOrders(
Id INT PRIMARY KEY IDENTITY,
EmployeeId INT FOREIGN KEY REFERENCES Employees(Id) NOT NULL,
CustomerId INT FOREIGN KEY REFERENCES Customers(Id) NOT NULL,
CarId INT FOREIGN KEY REFERENCES Cars(ID) NOT NULL,
TankLevel DECIMAL(5,2) NOT NULL,
KilometrageStart DECIMAL NOT NULL,
KilometrageEnd DECIMAL NOT NULL,
TotalKilometrage DECIMAL  NOT NULL,
StartDate DATE NOT NULL,
 EndDate DATE NOT NULL,
 TotalDays INT NOT NULL,
 RateApplied DECIMAL  NOT NULL,
 TaxRate DECIMAL NOT NULL,
 OrderStatus NVARCHAR(20) NOT NULL,
 Notes NTEXT )
 

   INSERT INTO Categories(CategoryName, DailyRate, WeeklyRate, MonthlyRate, WeekendRate)
VALUES
('Compact', 50, 400, 1000, 75),
('Luxury', 60, 420, 1500, 100),  
('Economy', 30, 150, 1200, 50)

INSERT INTO Cars (PlateNumber, Manufacturer, Model, CarYear, CategoryId, Doors, Picture, Condition, Available)
VALUES
('CA2563BA', 'Italy', 'ALFA ROMEO', 2007, 1, 4, NULL, 'Very good', 1),
('CB5514BA', 'Germany', 'Mercedes ', 2009, 2, 4, NULL, 'Very good', 0),
('CB2817BA', 'Germany', 'OPEL ASTRA', 2008, 3, 4, NULL, 'Excellent', 1)

INSERT INTO Employees(FirstName,LastName,Title,Notes)
VALUES
('Alex','Georgiev','SEO',NULL),
('Georgi','Ivanov','Team Leader',NULL),
('Alexandra','Atanasova','HR',NULL)

INSERT INTO Customers 
VALUES 
('2133C322S','Liliya Tsvetkova','Varna,Rakovski 154 str.','VARNA',9000,NULL),
('43533FF333','Evgenia Zaneva','Sofia,Rakovski 154 str.','SOFIA',1000,NULL),
('FDFD333444','Kristina Kirilova','Plovdiv,Rakovski 154 str.','PLOVDIV',4000,NULL)

 INSERT INTO RentalOrders(EmployeeId, CustomerId, CarId, TankLevel, KilometrageStart, KilometrageEnd, TotalKilometrage, StartDate, EndDate, TotalDays, RateApplied, TaxRate, OrderStatus, Notes)
 VALUES
 (1,1,1,25,0,500,800,'2017-8-23','2017-8-30',7,5,4,'Completed',NULL),
  (2,2,2,25,0,600,850,'2017-8-22','2017-8-25',3,5,4,'Completed',NULL),
   (3,3,3,25,0,700,900,'2017-8-23','2017-8-26',3,5,4,'Completed',NULL)