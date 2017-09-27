CREATE DATABASE Hotel

CREATE TABLE Employees
 (Id INT PRIMARY KEY IDENTITY,
  FirstName VARCHAR(20) NOT NULL,
  LastName VARCHAR(20) NOT NULL,
  Title VARCHAR (20) NOT NULL,
  Notes NTEXT )


  CREATE TABLE Customers (
  AccountNumber INT PRIMARY KEY IDENTITY,
  FirstName VARCHAR(20) NOT NULL,
  LastName VARCHAR(20) NOT NULL,
  PhoneNumber INT NOT NULL,
  EmergencyName VARCHAR (20)NOT NULL,
  EmergencyNumber INT NOT NULL,
  Notes NTEXT)

 CREATE TABLE RoomStatus
 (
 RoomStatus VARCHAR(20)NOT NULL PRIMARY KEY,
 Notes NTEXT 
 )

 CREATE TABLE RoomTypes
 (
 RoomType VARCHAR(20)NOT NULL PRIMARY KEY,
 Notes NTEXT 
 )
 CREATE TABLE BedTypes (
 BedType VARCHAR(20) NOT NULL PRIMARY KEY, 
 Notes NTEXT)

CREATE TABLE Rooms 
(RoomNumber INT NOT NULL PRIMARY KEY IDENTITY, 
RoomType VARCHAR(20) FOREIGN KEY REFERENCES RoomTypes(RoomType) NOT NULL,
BedType VARCHAR(20) FOREIGN KEY REFERENCES BedTypes(BedType) NOT NULL,
Rate DECIMAL NOT NULL,
RoomStatus VARCHAR(20) FOREIGN KEY REFERENCES RoomStatus(RoomStatus) NOT NULL,
Notes NTEXT )

 CREATE TABLE Payments (
 Id INT PRIMARY KEY IDENTITY,
 EmployeeId INT NOT NULL FOREIGN KEY REFERENCES Employees(Id),
 PaymentDate DATE NOT NULL,
 AccountNumber INT NOT NULL FOREIGN KEY REFERENCES Customers(AccountNumber),
 FirstDateOccupied DATE NOT NULL,
 LastDateOccupied DATE NOT NULL,
 TotalDays INT NOT NULL,
 AmountCharged DECIMAL NOT NULL,
TaxRate DECIMAL NOT NULL,
 TaxAmount DECIMAL NOT NULL,
 PaymentTotal DECIMAL NOT NULL,
 Notes NTEXT )

 CREATE TABLE Occupancies (
 Id INT PRIMARY KEY IDENTITY,
 EmployeeId INT NOT NULL FOREIGN KEY REFERENCES Employees(Id),
 DateOccupied DATE NOT NULL ,
 AccountNumber INT FOREIGN KEY REFERENCES Customers(AccountNumber),
 RoomNumber INT FOREIGN KEY REFERENCES Rooms(RoomNumber),
 RateApplied MONEY NOT NULL,
 PhoneCharge MONEY,
 Notes NTEXT)
 



  INSERT INTO Employees(FirstName,LastName,Title,Notes)
  VALUES
  ('Evgenia','Zaneva','Business Analyst',NULL),
  ('Maria','Genova','Manager',NULL),
  ('Kristian','Zanev','Graphic Designer',NULL)

   INSERT INTO Customers(FirstName,LastName,PhoneNumber,EmergencyName,EmergencyNumber,Notes)
  VALUES
('Alex','Georgiev',0894333221,'AG',12,NULL),
('Georgi','Ivanov',0893636621,'GI',23,NULL),
('Alexandra','Atanasova',0893677621,'AA',34,NULL)

INSERT INTO RoomStatus(RoomStatus,Notes)
 VALUES
 ('Available',NULL),
 ('Busy',NULL),
 ('Not Available',NULL)

 INSERT INTO RoomTypes(RoomType,Notes)
 VALUES
 ('Double room','Two single beds'),
 ('Apartment',NULL),
 ('Single room','One single bed')
 INSERT INTO BedTypes(BedType,Notes)
 VALUES
 ('Double',NULL),
 ('Glosbe',NULL),
 ('Single',NULL)

 INSERT INTO Rooms(RoomType,BedType,Rate,RoomStatus,Notes)
VALUES
('Apartment','Glosbe',5,'Busy','Busy until 25-09-2017'),
('Single room','Single',5,'Available','Available until 25-09-2017'),
('Double room','Double',5,'Not available','Under construction')

INSERT INTO Payments(EmployeeId,PaymentDate,AccountNumber,FirstDateOccupied,LastDateOccupied,TotalDays,AmountCharged,TaxRate,TaxAmount,PaymentTotal,Notes)
 VALUES
 (1,'2017-09-09',1,'2017-09-24','2017-09-29',5,200,5,40,500,'Completed'),
 (2,'2017-09-04',2,'2017-09-24','2017-09-28',4,150,5,40,450,'Completed'),
 (3,'2017-09-05',3,'2017-09-24','2017-09-30',6,250,5,40,550,'Completed')

  INSERT INTO Occupancies(EmployeeId,DateOccupied,AccountNumber,RoomNumber,RateApplied,PhoneCharge,Notes)
 VALUES 
 (1,GETDATE(),1,1,10,NULL,NULL),
 (2,GETDATE(),2,2,10,2,NULL),
 (3,GETDATE(),3,3,10,3,NULL)