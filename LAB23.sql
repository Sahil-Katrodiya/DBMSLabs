--From the table STUDENT perform the following queries:  
--Part – A:  
--1. INSERT Procedures: Create stored procedures to insert records into STUDENT tables 
--(SP_INSERT_STUDENT) 
CREATE PROCEDURE SP_INSERT_STUDENT
    @STDID INT,
    @SNAME VARCHAR(50),
    @CITY VARCHAR(50),
    @SPI DECIMAL(4,2),
    @BRANCH VARCHAR(50),
    @AGE INT
AS
BEGIN
    INSERT INTO STUDENT
    VALUES(@STDID,@SNAME,@CITY,@SPI,@BRANCH,@AGE);
END

SELECT * FROM Deposit
EXEC SP_INSERT_STUDENT 116,'RAVI','RAJKOT',9.48,'COMPUTER',NULL

--2. INSERT Procedures: Create stored procedures to insert records into DEPOSIT tables  
--(SP_INSERT_DEPOSIT) 
CREATE PROCEDURE SP_INSERT_DEPOSIT
    @ACTNO INT,
    @CNAME VARCHAR(50),
    @BNAME VARCHAR(50),
    @AMOUNT INT,
    @ADATE DATE
AS
BEGIN
    INSERT INTO DEPOSIT
    VALUES(@ACTNO,@CNAME,@BNAME,@AMOUNT,@ADATE);
END
EXEC SP_INSERT_DEPOSIT 118,'HEMENT','BEDI',16000,'2025-05-05'

--3. UPDATE Procedures: Create stored procedure SP_UPDATE_STUDENT to update Branch in STUDENT 
--table. (Update using studentID)
CREATE PROCEDURE SP_UPDATE_STUDENT
    @STDID INT,
    @BRANCH VARCHAR(50)
AS
BEGIN
    UPDATE STUDENT
    SET BRANCH=@BRANCH
    WHERE STDID=@STDID;
END

EXEC SP_UPDATE_STUDENT 115,'ELECTRICAL'

--4. DELETE Procedures: Create stored procedure SP_DELETE_STUDENT to delete records from STUDENT 
--where Student Name is RAVI. 
CREATE PROCEDURE SP_DELETE_STUDENT
AS
BEGIN
    DELETE FROM STUDENT
    WHERE SNAME='RAVI';
END

EXEC SP_DELETE_STUDENT

--5. SELECT BY PRIMARY KEY: Create stored procedures to select records by primary key 
--(SP_SELECT_STUDENT_BY_ID) from Student table. (Display All Columns)
CREATE PROCEDURE SP_SELECT_STUDENT_BY_ID
    @STDID INT
AS
BEGIN
    SELECT *
    FROM STUDENT
    WHERE STDID=@STDID;
END

EXEC SP_SELECT_STUDENT_BY_ID 115

--6. Create a stored procedure that shows details of the first 5 students ordered by SPI (Highest First). 
CREATE PROCEDURE SP_TOP5_STUDENT
AS
BEGIN
    SELECT TOP 5 *
    FROM STUDENT
    ORDER BY SPI DESC;
END

EXEC SP_TOP5_STUDENT


--From the table EMPLOYEE perform the following queries:  
--Part – B:   
--7. Create a stored procedure which displays all employee details.
CREATE PROCEDURE SP_ALL_EMPLOYEE
AS
BEGIN
    SELECT *
    FROM EMPLOYEE;
END

EXEC SP_ALL_EMPLOYEE

--8. Create a stored procedure that takes department name as input and returns all the employee in that 
--department. 
CREATE PROCEDURE SP_EMPLOYEE_DEPT
    @DEPARTMENT VARCHAR(50)
AS
BEGIN
    SELECT *
    FROM EMPLOYEE
    WHERE DEPARTMENT=@DEPARTMENT;
END

EXEC SP_EMPLOYEE_DEPT 'IT'

--Part – C:  
--9. Create a stored procedure which displays department-wise maximum, minimum, and average salary of 
--employee. 
CREATE PROCEDURE SP_SALARY_STATISTICS
AS
BEGIN
    SELECT DEPARTMENT,
           MAX(SALARY) AS MAX_SALARY,
           MIN(SALARY) AS MIN_SALARY,
           AVG(SALARY) AS AVG_SALARY
    FROM EMPLOYEE
    GROUP BY DEPARTMENT;
END


EXEC SP_SALARY_STATISTICS

--10. Create a stored procedure that accepts department name as parameter and returns total salary of their 
--department.
CREATE PROCEDURE SP_TOTAL_SALARY
    @DEPARTMENT VARCHAR(50)
AS
BEGIN
    SELECT DEPARTMENT,SUM(SALARY) AS TOTAL_SALARY
    FROM EMPLOYEE
    WHERE DEPARTMENT=@DEPARTMENT
    GROUP BY DEPARTMENT;
END


EXEC SP_TOTAL_SALARY 'IT'

