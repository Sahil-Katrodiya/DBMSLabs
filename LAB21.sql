--From the table STUDENT perform the following queries:  
--Part – A: 
--1. Display all students whose SPI is greater than 8.
WITH CTE AS
(
    SELECT *
    FROM STUDENT
)
SELECT *
FROM CTE
WHERE SPI > 8

--2. Display average SPI of all students.
WITH CTE AS
(
    SELECT AVG(SPI) AS AVG_SPI
    FROM STUDENT
)
SELECT *
FROM CTE


--3. Display total number of students in each branch.
WITH CTE AS
(
    SELECT BRANCH, COUNT(*) AS TOTAL_STUDENTS
    FROM STUDENT
    GROUP BY BRANCH
)
SELECT *
FROM CTE


--4. Display students who belong to RAJKOT city. 
WITH CTE AS
(
    SELECT *
    FROM STUDENT
    WHERE CITY='RAJKOT'
)
SELECT *
FROM CTE


--5. Find branch names that appear more than once. 
WITH CTE AS
(
    SELECT BRANCH, COUNT(*) AS CNT
    FROM STUDENT
    GROUP BY BRANCH
)
SELECT BRANCH
FROM CTE
WHERE CNT > 1


--6. Display row number for each student.
WITH CTE AS
(
    SELECT *,ROW_NUMBER() OVER(ORDER BY STDID) AS RN
    FROM STUDENT
)
SELECT *
FROM CTE


--7. Display top 3 students based on SPI.
WITH CTE AS
(
    SELECT *,ROW_NUMBER() OVER(ORDER BY SPI DESC) AS RN
    FROM STUDENT
)
SELECT *
FROM CTE
WHERE RN <= 3


--8. Display students having maximum SPI.
WITH CTE AS
(
    SELECT MAX(SPI) AS MAX_SPI
    FROM STUDENT
)
SELECT *
FROM STUDENT
WHERE SPI = (SELECT MAX_SPI FROM CTE)



--9. Display students having minimum SPI.
WITH CTE AS
(
    SELECT MIN(SPI) AS MIN_SPI
    FROM STUDENT
)
SELECT *
FROM STUDENT
WHERE SPI = (SELECT MIN_SPI FROM CTE)


--10. Display branch -wise rank of students. 
WITH CTE AS
(
    SELECT *,RANK() OVER(PARTITION BY BRANCH ORDER BY SPI DESC) AS RK
    FROM STUDENT
)
SELECT *
FROM CTE 
--Part – B: 
--11. Display students SPI average belonging to Computer branch. 
WITH CTE AS
(
    SELECT AVG(SPI) AS AVG_SPI
    FROM STUDENT
    WHERE BRANCH='COMPUTER'
)
SELECT *
FROM CTE


--12. Display students whose SPI is greater than average SPI of his/her branch. 
WITH CTE AS
(
    SELECT *,
           AVG(SPI) OVER(PARTITION BY BRANCH) AS AVG_SPI
    FROM STUDENT
)
SELECT *
FROM CTE
WHERE SPI > AVG_SPI

--13. Display branch having more than 2 students.
WITH CTE AS
(
    SELECT BRANCH, COUNT(*) AS CNT
    FROM STUDENT
    GROUP BY BRANCH
)
SELECT *
FROM CTE
WHERE CNT > 2


--14. Display branches having average SPI between 7 and 9
WITH CTE AS
(
    SELECT BRANCH, AVG(SPI) AS AVG_SPI
    FROM STUDENT
    GROUP BY BRANCH
)
SELECT *
FROM CTE
WHERE AVG_SPI BETWEEN 7 AND 9


--15. Display students whose SPI is lower than overall average SPI. 
WITH CTE AS
(
    SELECT AVG(SPI) AS AVG_SPI
    FROM STUDENT
)
SELECT *
FROM STUDENT
WHERE SPI < (SELECT AVG_SPI FROM CTE)


--Part – C: 
--16. Display branches having exactly one student. 
WITH CTE AS
(
    SELECT BRANCH, COUNT(*) AS CNT
    FROM STUDENT
    GROUP BY BRANCH
)
SELECT *
FROM CTE
WHERE CNT = 1


--17. Display branch having highest average SPI.
WITH CTE AS
(
    SELECT BRANCH, AVG(SPI) AS AVG_SPI
    FROM STUDENT
    GROUP BY BRANCH
)
SELECT TOP 1 *
FROM CTE
ORDER BY AVG_SPI DESC

--18. Display branch having lowest average SPI.
WITH CTE AS
(
    SELECT BRANCH, AVG(SPI) AS AVG_SPI
    FROM STUDENT
    GROUP BY BRANCH
)
SELECT TOP 1 *
FROM CTE
ORDER BY AVG_SPI


--19. Display students whose SPI is lower than branch average SPI.
WITH CTE AS
(
    SELECT *,AVG(SPI) OVER(PARTITION BY BRANCH) AS AVG_SPI
    FROM STUDENT
)
SELECT *
FROM CTE
WHERE SPI < AVG_SPI


--20. Display branches having maximum number of students. 
WITH CTE AS
(
    SELECT BRANCH,COUNT(*) AS CNT
    FROM STUDENT
    GROUP BY BRANCH
)
SELECT *
FROM CTE
WHERE CNT = (SELECT MAX(CNT) FROM CTE)