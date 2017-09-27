CREATE TABLE People(
Id INT PRIMARY KEY IDENTITY,
[Name] NVARCHAR(200) NOT NULL,
Picture VARBINARY(MAX),
Height DECIMAL(3,2),
[Weight] DECIMAL(5,2),
Gender CHAR(1)NOT NULL,
Birthdate DATE NOT NULL,
Biography VARCHAR(MAX)
)

INSERT INTO People ([Name],Picture,Height,[Weight],Gender,Birthdate,Biography)
VALUES
('Ivan',NULL,1.80,80.00,'m','1992-10-23','Developer'),
('Georgi',NULL,1.90,90.00,'m','1991-9-23','Analyst'),
('Stoyan',NULL,1.70,70.00,'m','1986-9-24','QA'),
('Ivaylo',NULL,1.60,90.00,'m','1995-4-13','Team Leader'),
('Alexandra',NULL,1.70,50.00,'f','1996-3-23','HR')