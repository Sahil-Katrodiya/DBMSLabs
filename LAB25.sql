--Part – A:  
--1. Implement scalar function to return "Welcome to DBMS Lab".
CREATE FUNCTION FN_WELCOME()
RETURNS VARCHAR(50)
AS
BEGIN
    RETURN 'Welcome to DBMS Lab'
END

SELECT dbo.FN_WELCOME()

--2. Implement scalar function to calculate simple interest.
CREATE FUNCTION FN_SI
(
    @P FLOAT,
    @R FLOAT,
    @T FLOAT
)
RETURNS FLOAT
AS
BEGIN
    RETURN (@P*@R*@T)/100
END

SELECT dbo.FN_SI(10000,10,2)

--3. Implement scalar function to find difference in days between two dates.
CREATE FUNCTION FN_DAYS
(
    @D1 DATE,
    @D2 DATE
)
RETURNS INT
AS
BEGIN
    RETURN DATEDIFF(DAY,@D1,@D2)
END

SELECT dbo.FN_DAYS('2024-01-01','2024-01-10')

--4. Implement scalar function to check whether number is odd or even.
CREATE FUNCTION FN_ODDEVEN
(
    @N INT
)
RETURNS VARCHAR(10)
AS
BEGIN
    IF @N%2=0
        RETURN 'EVEN'
    RETURN 'ODD'
END

SELECT dbo.FN_ODDEVEN(15)

--5. Implement scalar function to print numbers from 1 to N. 
 CREATE FUNCTION FN_NUMBERS
(
    @N INT
)
RETURNS VARCHAR(200)
AS
BEGIN
    DECLARE @I INT=1
    DECLARE @S VARCHAR(200)=''

    WHILE @I<=@N
    BEGIN
        SET @S=@S+CAST(@I AS VARCHAR)+' '
        SET @I=@I+1
    END

    RETURN @S
END

SELECT dbo.FN_NUMBERS(5)


--Part – B:  
--6. Implement scalar function to calculate factorial of given number.
CREATE FUNCTION FN_FACTORIAL
(
    @N INT
)
RETURNS BIGINT
AS
BEGIN
    DECLARE @F BIGINT=1

    WHILE @N>0
    BEGIN
        SET @F=@F*@N
        SET @N=@N-1
    END

    RETURN @F
END

SELECT dbo.FN_FACTORIAL(5)



--7. Implement scalar function to check palindrome number.
CREATE FUNCTION FN_PALINDROME
(
    @N INT
)
RETURNS VARCHAR(10)
AS
BEGIN
    DECLARE @TEMP INT=@N
    DECLARE @REV INT=0
    DECLARE @REM INT

    WHILE @N>0
    BEGIN
        SET @REM=@N%10
        SET @REV=@REV*10+@REM
        SET @N=@N/10
    END

    IF @TEMP=@REV
        RETURN 'YES'

    RETURN 'NO'
END

SELECT dbo.FN_PALINDROME(121)

--8. Implement scalar function to find maximum of three numbers.
CREATE FUNCTION FN_MAX3
(
    @A INT,
    @B INT,
    @C INT
)
RETURNS INT
AS
BEGIN
    DECLARE @MAX INT

    SET @MAX=@A

    IF @B>@MAX SET @MAX=@B
    IF @C>@MAX SET @MAX=@C

    RETURN @MAX
END

SELECT dbo.FN_MAX3(10,25,15)



--9. Implement scalar function to calculate square and cube of a number. 
CREATE FUNCTION FN_SQUARE
(
    @N INT
)
RETURNS INT
AS
BEGIN
    RETURN @N*@N
END 

CREATE FUNCTION FN_CUBE
(
    @N INT
)
RETURNS INT
AS
BEGIN
    RETURN @N*@N*@N
END

SELECT dbo.FN_SQUARE(5)
SELECT dbo.FN_CUBE(5)


--From the table EMPLOYEE perform the following queries:  
--Part – C:  
--10. Implement scalar function to return employee full details using EID.
CREATE FUNCTION FN_EMPLOYEE_DETAILS
(
    @EID INT
)
RETURNS VARCHAR(500)
AS
BEGIN
    DECLARE @RESULT VARCHAR(500)

    SELECT @RESULT=
    CAST(EID AS VARCHAR)+' '+
    FIRSTNAME+' '+
    LASTNAME+' '+
    DEPARTMENT
    FROM EMPLOYEE
    WHERE EID=@EID

    RETURN @RESULT
END


SELECT dbo.FN_EMPLOYEE_DETAILS(101)


--11. Implement scalar function to return highest salary from a given department.
CREATE FUNCTION FN_HIGHEST_SALARY
(
    @DEPT VARCHAR(50)
)
RETURNS DECIMAL(10,2)
AS
BEGIN
    DECLARE @SAL DECIMAL(10,2)

    SELECT @SAL=MAX(SALARY)
    FROM EMPLOYEE
    WHERE DEPARTMENT=@DEPT

    RETURN @SAL
END

SELECT dbo.FN_HIGHEST_SALARY('IT')

--12. Implement scalar function to count total employees in EMPLOYEE table. 
CREATE FUNCTION FN_TOTAL_EMPLOYEE()
RETURNS INT
AS
BEGIN
    RETURN (SELECT COUNT(*) FROM EMPLOYEE)
END

SELECT dbo.FN_TOTAL_EMPLOYEE()

--13. Implement scalar function to find total experience of employee using JoiningYear.
CREATE FUNCTION FN_EXPERIENCE
(
    @JOININGYEAR INT
)
RETURNS INT
AS
BEGIN
    RETURN YEAR(GETDATE())-@JOININGYEAR
END

SELECT dbo.FN_EXPERIENCE(2022)



--14. Implement scalar function to return total number of employees in a given department. 
CREATE FUNCTION FN_DEPT_COUNT
(
    @DEPT VARCHAR(50)
)
RETURNS INT
AS
BEGIN
    RETURN
    (
        SELECT COUNT(*)
        FROM EMPLOYEE
        WHERE DEPARTMENT=@DEPT
    )
END

SELECT dbo.FN_DEPT_COUNT('IT')

--15. Implement scalar function to count total employees from a given city.
CREATE FUNCTION FN_CITY_COUNT
(
    @CITY VARCHAR(50)
)
RETURNS INT
AS
BEGIN
    RETURN
    (
        SELECT COUNT(*)
        FROM EMPLOYEE
        WHERE CITY=@CITY
    )
END

SELECT dbo.FN_CITY_COUNT('RAJKOT')
