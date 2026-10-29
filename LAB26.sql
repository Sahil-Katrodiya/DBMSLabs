--From the table STUDENT perform the following queries:  
--Part – A: 
--1. Create a table valued function to display all student records.
CREATE FUNCTION FN_ALL_STUDENT()
RETURNS TABLE
AS
RETURN
(
    SELECT *
    FROM STUDENT
)

SELECT * FROM FN_ALL_STUDENT()

--2. Create a table valued function that accepts CITY and returns all students from that city.
CREATE FUNCTION FN_CITY
(
    @CITY VARCHAR(50)
)
RETURNS TABLE
AS
RETURN
(
    SELECT *
    FROM STUDENT
    WHERE CITY=@CITY
)

SELECT * FROM FN_CITY('RAJKOT')

--3. Create a table valued function that accepts BRANCH and returns all students of that branch. 

CREATE FUNCTION FN_BRANCH
(
    @BRANCH VARCHAR(50)
)
RETURNS TABLE
AS
RETURN
(
    SELECT *
    FROM STUDENT
    WHERE BRANCH=@BRANCH
)

SELECT * FROM FN_BRANCH('COMPUTER');






--4. Create a table valued function that accepts SPI and returns students whose SPI is greater than entered 
--SPI.
CREATE FUNCTION FN_SPI
(
    @SPI DECIMAL(4,2)
)
RETURNS TABLE
AS
RETURN
(
    SELECT *
    FROM STUDENT
    WHERE SPI>@SPI
)

SELECT * FROM FN_SPI(8)



--5. Create a table valued function that accepts MIN_SPI and MAX_SPI and returns students whose SPI lies 
--between given range. 

CREATE FUNCTION FN_SPI_RANGE
(
    @MIN_SPI DECIMAL(4,2),
    @MAX_SPI DECIMAL(4,2)
)
RETURNS TABLE
AS
RETURN
(
    SELECT *
    FROM STUDENT
    WHERE SPI BETWEEN @MIN_SPI AND @MAX_SPI
)

SELECT * FROM FN_SPI_RANGE(7,9)
 
--Part – B:  
--6. Create a table valued function that accepts STDID and returns details of that student. 
CREATE FUNCTION FN_STDID
(
    @STDID INT
)
RETURNS TABLE
AS
RETURN
(
    SELECT *
    FROM STUDENT
    WHERE STDID=@STDID
)

SELECT * FROM FN_STDID(101)


--7. Create a table valued function that accepts CITY and returns students whose SPI is greater than 7 from 
--that city.
CREATE FUNCTION FN_CITY_SPI
(
    @CITY VARCHAR(50)
)
RETURNS TABLE
AS
RETURN
(
    SELECT *
    FROM STUDENT
    WHERE CITY=@CITY AND SPI>7
)

SELECT * FROM FN_CITY_SPI('RAJKOT')

--8. Create a table valued function that accepts BRANCH and returns students whose SPI is less than 8 from 
--that branch. 
CREATE FUNCTION FN_BRANCH_SPI
(
    @BRANCH VARCHAR(50)
)
RETURNS TABLE
AS
RETURN
(
    SELECT *
    FROM STUDENT
    WHERE BRANCH=@BRANCH AND SPI<8
)

SELECT * FROM FN_BRANCH_SPI('COMPUTER')


--9. Create a table valued function that accepts TOPN and returns top N students based on SPI. 
CREATE FUNCTION FN_TOP_N
(
    @N INT
)
RETURNS TABLE
AS
RETURN
(
    SELECT TOP (@N) *
    FROM STUDENT
    ORDER BY SPI DESC
)

SELECT * FROM FN_TOP_N(3)

--10. Create a table valued function that accepts BRANCH and returns highest SPI student from that branch. 
CREATE FUNCTION FN_BRANCH_TOPPER
(
    @BRANCH VARCHAR(50)
)
RETURNS TABLE
AS
RETURN
(
    SELECT *
    FROM STUDENT
    WHERE BRANCH=@BRANCH AND SPI=(SELECT MAX(SPI)
        FROM STUDENT
        WHERE BRANCH=@BRANCH)
)

SELECT * FROM FN_BRANCH_TOPPER('COMPUTER')


--Part – C:  
--11. Create a table valued function that accepts CITY and returns total students from that city. 
CREATE FUNCTION FN_CITY_COUNT2
(
    @CITY VARCHAR(50)
)
RETURNS TABLE
AS
RETURN
(
    SELECT CITY,COUNT(*) TOTAL_STUDENTS
    FROM STUDENT
    WHERE CITY=@CITY
    GROUP BY CITY
)

SELECT * FROM FN_CITY_COUNT2('RAJKOT')




--12. Create a table valued function that accepts BRANCH and returns students ordered by SPI in descending 
--order.
CREATE FUNCTION FN_BRANCH_ORDER
(
    @BRANCH VARCHAR(50)
)
RETURNS TABLE
AS
RETURN
(
    SELECT *
    FROM STUDENT
    WHERE BRANCH=@BRANCH
)

SELECT *
FROM FN_BRANCH_ORDER('COMPUTER')
ORDER BY SPI DESC



--13. Create a table valued function that accepts CITY and returns top 3 student from that city based on SPI.
CREATE FUNCTION FN_CITY_TOP3
(
    @CITY VARCHAR(50)
)
RETURNS TABLE
AS
RETURN
(
    SELECT TOP 3 *
    FROM STUDENT
    WHERE CITY=@CITY
    ORDER BY SPI DESC
)

SELECT * FROM FN_CITY_TOP3('RAJKOT')



--14. Create a table valued function that accepts STDID and returns student rank based on SPI (RANK).
CREATE FUNCTION FN_STUDENT_RANK
(
    @STDID INT
)
RETURNS TABLE
AS
RETURN
(
    WITH CTE AS
    (
        SELECT STDID,
               SNAME,
               SPI,
               RANK() OVER(ORDER BY SPI DESC) AS RK
        FROM STUDENT
    )
    SELECT *
    FROM CTE
    WHERE STDID=@STDID
)


SELECT * FROM FN_STUDENT_RANK(101)


--15. Create a table valued function that accepts BRANCH and returns students having second highest SPI 
--from that branch.

CREATE FUNCTION FN_SECOND_TOPPER
(
    @BRANCH VARCHAR(50)
)
RETURNS TABLE
AS
RETURN
(
    WITH CTE AS
    (
        SELECT *,DENSE_RANK() OVER(PARTITION BY BRANCH ORDER BY SPI DESC) AS RK
        FROM STUDENT
    )
    SELECT *
    FROM CTE
    WHERE BRANCH=@BRANCH
    AND RK=2
)

