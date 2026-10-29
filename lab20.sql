--From the table STUDENT perform the following queries:  
--Part – A: 
--1. Display rank of students based on SPI. 
	SELECT SNAME,SPI,
	RANK()OVER(ORDER BY SPI DESC) AS RANK_NO
	FROM STUDENT

--2. Display dense rank of students based on SPI.
SELECT SNAME, SPI,
       DENSE_RANK() OVER(ORDER BY SPI DESC) AS DENSE_RANKING
FROM STUDENT

--3. Display sequential number for each student record.
SELECT *,
       ROW_NUMBER() OVER(ORDER BY STDID) AS SRNO
FROM STUDENT

--4. Display branch-wise rank of students.
SELECT SNAME, BRANCH, SPI,
       RANK() OVER(PARTITION BY BRANCH ORDER BY SPI DESC) AS RANKING
FROM STUDENT


--5. Display branch-wise dense ranking of students.
SELECT SNAME, BRANCH, SPI,
       DENSE_RANK() OVER(PARTITION BY BRANCH ORDER BY SPI DESC) AS DENSE_RANKING
FROM STUDENT


--6. Display branch-wise sequential numbering of students. 
SELECT SNAME, BRANCH,
       ROW_NUMBER() OVER(PARTITION BY BRANCH ORDER BY STDID) AS ROW_NO
FROM STUDENT


--7. Display SNAME, Current SPI, Previous SPI and SPI Difference with previous student in ascending order of 
--SPI. 
SELECT SNAME,
       SPI AS CURRENT_SPI,
       LAG(SPI) OVER(ORDER BY SPI) AS PREVIOUS_SPI,
       SPI - LAG(SPI) OVER(ORDER BY SPI) AS DIFFERENCE
FROM STUDENT


--8. Display SNAME, Current SPI, Next SPI and SPI Difference with next student in descending order of SPI.  
SELECT SNAME,
       SPI AS CURRENT_SPI,
       LEAD(SPI) OVER(ORDER BY SPI DESC) AS NEXT_SPI,
       SPI - LEAD(SPI) OVER(ORDER BY SPI DESC) AS DIFFERENCE
FROM STUDENT

--9. Display top 3 students based on SPI. 
SELECT TOP 3 *
FROM STUDENT
ORDER BY SPI DESC

--10. Display top 2 students from each branch. 
WITH TOP_STUDENT AS
(SELECT *,
ROW_NUMBER() OVER (PARTITION BY BRANCH ORDER BY SPI DESC) AS ROLLNO
FROM STUDENT
)
SELECT *
FROM TOP_STUDENT
WHERE ROLLNO <= 2


--Part – B: 
--11. Display 5th highest SPI.
WITH SPI_RANK AS
(
SELECT SNAME,SPI,
RANK() OVER (ORDER BY SPI DESC) AS RNO
FROM STUDENT
)

SELECT *
FROM SPI_RANK
WHERE RNO = 5
--12. Display 6th highest SPI. 
WITH CTE AS
(
    SELECT SPI,
           DENSE_RANK() OVER(ORDER BY SPI DESC) AS DR
    FROM STUDENT
)
SELECT SPI
FROM CTE
WHERE DR = 6


--13. Display students having same ranking. 
SELECT SNAME, SPI,
       RANK() OVER(ORDER BY SPI DESC) AS RANK_NO
FROM STUDENT
WHERE SPI IN
(
    SELECT SPI
    FROM STUDENT
    GROUP BY SPI
    HAVING COUNT(*) > 1
)
--NO OUTPUT 

--MAKE THIS 
UPDATE STUDENT
SET SPI = 9.50
WHERE SNAME = 'KRUNAL'



--14. Display SNAME, Previous SPI, Current SPI and Next SPI based on ascending order of SPI.
SELECT SNAME,
       LAG(SPI) OVER(ORDER BY SPI) AS PREVIOUS_SPI,
       SPI AS CURRENT_SPI,
       LEAD(SPI) OVER(ORDER BY SPI) AS NEXT_SPI
FROM STUDENT

--15. Display topper of each branch. 
WITH CTE AS
(
    SELECT *,
           RANK() OVER(PARTITION BY BRANCH ORDER BY SPI DESC) AS RK
    FROM STUDENT
)
SELECT *
FROM CTE
WHERE RK = 1


--Part – C: 
--16. Display students whose SPI is greater than the previous student and less than the next student.
WITH CTE AS
(
    SELECT SNAME, SPI,
           LAG(SPI) OVER(ORDER BY SPI) AS PREV_SPI,
           LEAD(SPI) OVER(ORDER BY SPI) AS NEXT_SPI
    FROM STUDENT
)
SELECT *
FROM CTE
WHERE SPI > PREV_SPI AND SPI < NEXT_SPI

--17. Display branch-wise second topper students.
WITH CTE AS
(
    SELECT *,
           DENSE_RANK() OVER(PARTITION BY BRANCH ORDER BY SPI DESC) AS DR
    FROM STUDENT
)
SELECT *
FROM CTE
WHERE DR = 2
--18. Display students whose rank and dense rank are different.
WITH CTE AS
(
    SELECT SNAME,
           SPI,
           RANK() OVER(ORDER BY SPI DESC) AS RK,
           DENSE_RANK() OVER(ORDER BY SPI DESC) AS DR
    FROM STUDENT
)
SELECT *
FROM CTE
WHERE RK <> DR;


--19. Display consecutive students having same branch ordered by SPI.
WITH CTE AS
(
    SELECT SNAME,
           BRANCH,
           SPI,
           LAG(BRANCH) OVER(ORDER BY SPI) AS PREV_BRANCH
    FROM STUDENT
)
SELECT *
FROM CTE
WHERE BRANCH = PREV_BRANCH


--20. Display students whose SPI difference with previous student is maximum. 
WITH CTE AS
(
    SELECT SNAME,
           SPI,
           SPI - LAG(SPI) OVER(ORDER BY SPI) AS DIFF
    FROM STUDENT
)
SELECT TOP 1 *
FROM CTE
ORDER BY DIFF DESC



