--From the table EMPLOYEE perform the following queries:  
--Part – A:  
--1. Create a stored procedure to generate department-wise salary statistics like total salary, average 
--salary, minimum salary, and maximum salary. (User enter only department name) 
CREATE PROCEDURE SP_DEPT_SALARY_STATS
    @DEPARTMENT VARCHAR(50)
AS
BEGIN
    SELECT
        SUM(SALARY) AS TOTAL_SALARY,
        AVG(SALARY) AS AVG_SALARY,
        MIN(SALARY) AS MIN_SALARY,
        MAX(SALARY) AS MAX_SALARY
    FROM EMPLOYEE
    WHERE DEPARTMENT=@DEPARTMENT;
END

EXEC SP_DEPT_SALARY_STATS 'IT'


--2. Create a stored procedure that accepts a joining year and displays employees who joined that year.
CREATE PROCEDURE SP_JOINING_YEAR
    @YEAR INT
AS
BEGIN
    SELECT *
    FROM EMPLOYEE
    WHERE JOININGYEAR=@YEAR;
END

EXEC SP_JOINING_YEAR 2024

--3. Create a stored procedure for dynamic employee search using parameters (User may enter partial city 
--name). 
CREATE PROCEDURE SP_CITY_SEARCH
    @CITY VARCHAR(50)
AS
BEGIN
    SELECT *
    FROM EMPLOYEE
    WHERE CITY LIKE '%' + @CITY + '%';
END

EXEC SP_CITY_SEARCH 'RAJ'

--4. Create a stored procedure that accepts a salary amount and displays employees earning more than the 
--entered salary.
CREATE PROCEDURE SP_HIGH_SALARY
    @SALARY INT
AS
BEGIN
    SELECT *
    FROM EMPLOYEE
    WHERE SALARY > @SALARY;
END

EXEC SP_HIGH_SALARY 12000

--5. Create a stored procedure to display top N highest paid employees from each department (Value of N 
--is entered by user).
CREATE PROCEDURE SP_TOP_N_EMPLOYEE
    @N INT
AS
BEGIN
    WITH CTE AS
    (
        SELECT *,ROW_NUMBER() OVER (PARTITION BY DEPARTMENT ORDER BY SALARY DESC) RN
        FROM EMPLOYEE
    )
    SELECT *
    FROM CTE
    WHERE RN <= @N;
END

EXEC SP_TOP_N_EMPLOYEE 3


--6. Create a stored procedure to increase salary department-wise by a given percentage. (User Enter 
--Department Name and %, e.g. Computer 10). 
CREATE PROCEDURE SP_INCREMENT_SALARY
    @DEPARTMENT VARCHAR(50),
    @PERCENTAGE INT
AS
BEGIN
    UPDATE EMPLOYEE
    SET SALARY = SALARY + (SALARY*@PERCENTAGE/100)
    WHERE DEPARTMENT=@DEPARTMENT;
END

EXEC SP_INCREMENT_SALARY 'COMPUTER',10

--7. Create a stored procedure to display employees having experience greater than or equal to the entered 
--years.
CREATE PROCEDURE SP_EXPERIENCE
    @YEARS INT
AS
BEGIN
    SELECT *
    FROM EMPLOYEE
    WHERE YEAR(GETDATE()) - JOININGYEAR >= @YEARS;
END

EXEC SP_EXPERIENCE 5

--8. Create a stored procedure that accepts a number as input and displays details of the last N employees 
--who joined the organization.
CREATE PROCEDURE SP_LAST_N_EMPLOYEE
    @N INT
AS
BEGIN
    SELECT TOP (@N) *
    FROM EMPLOYEE
    ORDER BY JOININGYEAR DESC;
END

EXEC SP_LAST_N_EMPLOYEE 3 
--From the table AUTHOR, PUBLISHER and BOOK perform the following queries:  
--Part – B:  
--9. Create a stored procedure that accepts an author name and displays all books written by that author.
CREATE PROCEDURE SP_BOOK_BY_AUTHOR
    @AUTHORNAME VARCHAR(50)
AS
BEGIN
    SELECT *
    FROM BOOK B
    JOIN AUTHOR A
    ON B.AUTHORID=A.AUTHORID
    WHERE A.AUTHORNAME=@AUTHORNAME;
END

EXEC SP_BOOK_BY_AUTHOR 'Chetan Bhagat'


--10. Create a stored procedure that accepts a publication year and displays books published after that year.
CREATE PROCEDURE SP_BOOK_AFTER_YEAR
    @YEAR INT
AS
BEGIN
    SELECT *
    FROM BOOK
    WHERE PUBLICATIONYEAR > @YEAR;
END

EXEC SP_BOOK_AFTER_YEAR 2015

SELECT * FROM BOOK
--11. Create a stored procedure that accepts a country name and displays all authors from that country with 
--their books. 
CREATE PROCEDURE SP_COUNTRY_AUTHOR
    @COUNTRY VARCHAR(50)
AS
BEGIN
    SELECT A.AUTHORNAME,B.TITLE
    FROM AUTHOR A
    JOIN BOOK B
    ON A.AUTHORID=B.AUTHORID
    WHERE A.COUNTRY=@COUNTRY;
END

EXEC SP_COUNTRY_AUTHOR 'INDIA'


--12. Create a stored procedure that accepts a number as input and displays the top N most expensive books 
--with author and publisher details. 
CREATE PROCEDURE SP_TOP_N_BOOKS
    @N INT
AS
BEGIN
    SELECT TOP (@N)
           B.TITLE,
           B.PRICE,
           A.AUTHORNAME,
           P.PUBLISHERNAME
    FROM BOOK B
    JOIN AUTHOR A
    ON B.AUTHORID=A.AUTHORID
    JOIN PUBLISHER P
    ON B.PUBLISHERID=P.PUBLISHERID
    ORDER BY B.PRICE DESC;
END

EXEC SP_TOP_N_BOOKS 5


 
--Part – C:  
--13. Create a stored procedure that accepts a publisher name and displays the total number of books 
--published by that publisher.
CREATE PROCEDURE SP_TOTAL_BOOKS
    @PUBLISHER VARCHAR(50)
AS
BEGIN
    SELECT COUNT(*) AS TOTAL_BOOKS
    FROM BOOK B
    JOIN PUBLISHER P
    ON B.PUBLISHERID=P.PUBLISHERID
    WHERE P.PUBLISHERNAME=@PUBLISHER;
END

EXEC SP_TOTAL_BOOKS 'RUPA PUBLICATIONS'


--14. Create a stored procedure that accepts a price range (Min Price Max Price) and displays books whose 
--prices fall within that range.
CREATE PROCEDURE SP_BOOK_PRICE_RANGE
    @MINPRICE INT,
    @MAXPRICE INT
AS
BEGIN
    SELECT *
    FROM BOOK
    WHERE PRICE BETWEEN @MINPRICE AND @MAXPRICE;
END

EXEC SP_BOOK_PRICE_RANGE 200,400


--15. Create a stored procedure that accepts an author ID and deletes all books written by that author.
CREATE PROCEDURE SP_DELETE_AUTHOR_BOOKS
    @AUTHOR_ID INT
AS
BEGIN
    DELETE FROM BOOK
    WHERE AUTHORID=@AUTHOR_ID;
END


EXEC SP_DELETE_AUTHOR_BOOKS 101
