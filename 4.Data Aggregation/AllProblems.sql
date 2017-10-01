---Problem 1.	Records’ Count
SELECT COUNT(Id) AS Count
FROM WizzardDeposits;

---Problem 2.	Longest Magic Wand

SELECT MAX(MagicWandSize) AS LongestMagicWand
FROM WizzardDeposits
---Problem 3.	Longest Magic Wand per Deposit Groups
SELECT DepositGroup,
MAX (MagicWandSize) AS LongestMagicWand
FROM WizzardDeposits
GROUP BY DepositGroup

---Problem 4.Smallest Deposit Group per Magic Wand Size
SELECT TOP(2)
WITH TIES DepositGroup
FROM WizzardDeposits
GROUP BY DepositGroup
ORDER BY AVG(MagicWandSize)

---Problem 5.	Deposits Sum
SELECT DepositGroup, SUM(DepositAmount)AS TotalSum
FROM WizzardDeposits
GROUP BY DepositGroup
---Problem 6.	Deposits Sum for Ollivander Family
SELECT DepositGroup, SUM(DepositAmount)AS TotalSum
FROM WizzardDeposits
WHERE MagicWandCreator ='Ollivander family'
GROUP BY DepositGroup
---Problem 7.	Deposits Filter
SELECT DepositGroup, SUM(DepositAmount)AS TotalSum
FROM WizzardDeposits
WHERE MagicWandCreator ='Ollivander family'
GROUP BY DepositGroup
HAVING SUM(DepositAmount)<150000
ORDER BY SUM(DepositAmount)DESC

---Problem 8.Deposit Charge
SELECT DepositGroup,MagicWandCreator,
MIN(DepositCharge) AS MinDepositCharge
FROM WizzardDeposits
GROUP BY DepositGroup,MagicWandCreator
ORDER BY MagicWandCreator,DepositGroup
---Problem 9.	Age Groups
---FirstWay
SELECT ageGroups.AgeGroup,COUNT(*)AS [Wizzard Count]FROM
(
SELECT
CASE 
WHEN Age BETWEEN 0 AND 10 THEN '[0-10]'
WHEN Age BETWEEN 11 AND 20 THEN '[11-20]'
WHEN Age BETWEEN 21 AND 30 THEN '[21-30]'
WHEN Age BETWEEN 31 AND 40 THEN '[31-40]'
WHEN Age BETWEEN 41 AND 50 THEN '[41-50]'
WHEN Age BETWEEN 51 AND 60 THEN '[51-60]'
ELSE '[61+]'
END AS[AgeGroup]
FROM WizzardDeposits
) AS ageGroups
GROUP BY ageGroups.AgeGroup

---SecondWay
SELECT 
CASE
 WHEN  Age >= 0 AND Age < 11 THEN '[0-10]'
 WHEN  Age >= 11 AND Age < 21  THEN '[11-20]'
 WHEN  Age >= 21 AND Age < 31  THEN '[21-30]'
 WHEN  Age >= 31 AND Age < 41  THEN '[31-40]'
 WHEN  Age >= 41 AND Age < 51  THEN '[41-50]'
 WHEN  Age >= 51 AND Age < 61  THEN '[51-60]'
 WHEN  Age > 60  THEN '[61+]'
 END AS AgeGroup, COUNT(Id) AS WizzardCount
FROM WizzardDeposits
GROUP BY
CASE
 WHEN  Age >= 0 AND Age < 11 THEN '[0-10]'
 WHEN  Age >= 11 AND Age < 21  THEN '[11-20]'
 WHEN  Age >= 21 AND Age < 31  THEN '[21-30]'
 WHEN  Age >= 31 AND Age < 41  THEN '[31-40]'
 WHEN  Age >= 41 AND Age < 51  THEN '[41-50]'
 WHEN  Age >= 51 AND Age < 61  THEN '[51-60]'
 WHEN  Age > 60  THEN '[61+]'
 END
 ---Problem 10.	First Letter
SELECT DISTINCT (LEFT(FirstName,1))AS FirstLetter 
FROM WizzardDeposits
WHERE DepositGroup='Troll Chest'
GROUP BY FirstName

--SecondWay
SELECT LEFT(FirstName, 1) AS FirstLetter
FROM WizzardDeposits
WHERE DepositGroup = 'Troll Chest'
GROUP BY LEFT(FirstName, 1)
ORDER BY FirstLetter
--ThirdWay

SELECT DISTINCT(LEFT(FirstName, 1)) AS FirstLetter
FROM WizzardDeposits
WHERE DepositGroup = 'Troll Chest'


---Problem 11.	Average Interest


SELECT DepositGroup,IsDepositExpired,
AVG(DepositInterest) AS [AverageInterest]
FROM WizzardDeposits
WHERE DepositStartDate>'01/01/1985'
GROUP BY DepositGroup,IsDepositExpired
ORDER BY DepositGroup DESC,IsDepositExpired 
---Problem 12.	* Rich Wizard, Poor Wizard
SELECT SUM(wizzardDep.Difference) AS [SumDifference]
FROM
(SELECT
FirstName AS [HostWizard],DepositAmount,
LEAD (FirstName) OVER (ORDER BY Id) AS [Guest Wizzard],
LEAD (DepositAmount) OVER (ORDER BY Id)AS [Guest Wizzard Deposit],
(DepositAmount-LEAD(DepositAmount)OVER (ORDER BY Id)) AS[Difference]
 FROM WizzardDeposits
 ) AS wizzardDep

 --Problem 13.	Departments Total Salaries
 USE SoftUni
 SELECT * FROM Employees

 SELECT DepartmentId,
 SUM(Salary) AS TotalSalary
 FROM Employees
 GROUP BY DepartmentID
 --Problem 14.	Employees Minimum Salaries
  SELECT DepartmentId,
 MIN(Salary) AS MinimumSalary
 FROM Employees
 WHERE HireDate>'01/01/2000'
 GROUP BY DepartmentID
 HAVING DepartmentID IN(2,5,7)

 --Problem 15.	Employees Average Salaries
SELECT * INTO EmployeesAvgSalary FROM Employees
WHERE SALARY>30000

DELETE FROM EmployeesAvgSalary
WHERE ManagerID=42

UPDATE EmployeesAvgSalary
SET Salary+=5000
WHERE DepartmentID=1
SELECT DepartmentID,AVG(Salary) AS AverageSalary
FROM EmployeesAvgSalary
GROUP BY DepartmentID

--Problem 16.	Employees Maximum Salaries
SELECT DepartmentID,MAX(Salary)
AS [MaxSalary]
FROM Employees
GROUP BY DepartmentID
HAVING MAX(Salary) NOT BETWEEN 30000 AND 70000

--Problem 17.	Employees Count Salaries

SELECT COUNT(*) AS [Count]
FROM Employees
WHERE ManagerID IS NULL

SELECT * FROM Employees

--Problem 18.	*3rd Highest Salary
SELECT salaries.DepartmentID,salaries.Salary FROM
(
SELECT DepartmentID,
MAX(Salary) AS Salary,
DENSE_RANK() OVER(PARTITION BY DepartmentID ORDER BY Salary DESC) AS Rank
FROM Employees
GROUP BY DepartmentID,Salary) AS salaries
WHERE Rank=3
GROUP BY salaries.DepartmentID,salaries.Salary

--Problem 19.	**Salary Challenge
SELECT TOP (10) FirstName,LastName,DepartmentId FROM Employees AS FirstTable
WHERE Salary>
(SELECT AVG(Salary) FROM Employees AS SecondTable
WHERE FirstTable.DepartmentID=SecondTable.DepartmentID
GROUP BY DepartmentID)
ORDER BY DepartmentID