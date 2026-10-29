CREATE TABLE CUSTOMER_ALL
(
    ORDERID INT PRIMARY KEY,
    CNAME VARCHAR(50),
    PRODUCT VARCHAR(50),
    CATEGORY VARCHAR(50),
    AMOUNT INT,
    ORDERYEAR INT,
    CITY VARCHAR(50)
)
INSERT INTO CUSTOMER_ALL VALUES
(101,'RAHUL','LAPTOP','ELECTRONICS',65000,2024,'RAJKOT'),
(102,'PRIYA','MOBILE','ELECTRONICS',25000,2023,'SURAT'),
(103,'AMIT','TABLE','FURNITURE',12000,2022,'AHMEDABAD'),
(104,'NEHA','CHAIR','FURNITURE',8000,2024,'BARODA'),
(105,'VISHAL','TV','ELECTRONICS',45000,2025,'MORBI'),
(106,'RIYA','SOFA','FURNITURE',30000,2023,'SURAT'),
(107,'MEHUL','AC','ELECTRONICS',40000,2022,'RAJKOT'),
(108,'KRUNAL','BED','FURNITURE',40000,2025,'JAMNAGAR')

SELECT * FROM CUSTOMER_ALL
--Part – A: 
--1. Display top 3 highest amount orders.
WITH CTE AS
(
    SELECT TOP 3 *
    FROM CUSTOMER_ALL
    ORDER BY AMOUNT DESC
)
SELECT * FROM CTE


--2. Display second highest order amount. 
WITH CTE AS
(
    SELECT AMOUNT,
           DENSE_RANK() OVER(ORDER BY AMOUNT DESC) AS RN
    FROM CUSTOMER_ALL
)
SELECT AMOUNT
FROM CTE
WHERE RN=2


--3. Display customers whose order amount is greater than category average amount.
WITH CTE AS
(
    SELECT *,
    AVG(AMOUNT) OVER(PARTITION BY CATEGORY) AS AVG_AMT
    FROM CUSTOMER_ALL
)
SELECT *
FROM CTE
WHERE AMOUNT > AVG_AMT


--4. Display categories having average amount greater than 30000. 
WITH CTE AS
(
    SELECT CATEGORY,AVG(AMOUNT) AS AVG_AMT
    FROM CUSTOMER_ALL
    GROUP BY CATEGORY
)
SELECT *
FROM CTE
WHERE AVG_AMT > 30000
--5. Display highest amount order from each category.
WITH CTE AS
(
    SELECT *,
ROW_NUMBER() OVER(PARTITION BY CATEGORY ORDER BY AMOUNT DESC) RN
FROM CUSTOMER_ALL
)
SELECT *
FROM CTE
WHERE RN=1

--6. Display lowest amount order from each category.
WITH CTE AS
(
    SELECT *,ROW_NUMBER() OVER (PARTITION BY CATEGORY ORDER BY AMOUNT ASC) RN
    FROM CUSTOMER_ALL
)
SELECT *
FROM CTE
WHERE RN=1

--7. Display categories having more than 3 orders. 
WITH CTE AS
(
    SELECT CATEGORY,COUNT(*)AS  CNT
    FROM CUSTOMER_ALL
    GROUP BY CATEGORY
)
SELECT *
FROM CTE
WHERE CNT > 3

--8. Display city-wise total order amount. 
WITH CTE AS
(
    SELECT CITY,SUM(AMOUNT) TOTAL_AMOUNT
    FROM CUSTOMER_ALL
    GROUP BY CITY
)
SELECT * FROM CTE

--9. Display category having highest average order amount. 
WITH CTE AS
(
    SELECT CATEGORY,AVG(AMOUNT) AVG_AMT,RANK() OVER(ORDER BY AVG(AMOUNT) DESC) RN
    FROM CUSTOMER_ALL
    GROUP BY CATEGORY
)
SELECT *
FROM CTE
WHERE RN=1


--10. Display cumulative order amount in ascending order of amount. 
 WITH CTE AS
(
    SELECT *,SUM(AMOUNT) OVER (ORDER BY AMOUNT) AS CUMULATIVE_AMOUNT
    FROM CUSTOMER_ALL
)
SELECT * FROM CTE

--Part – B: 
--11. Display category-wise top 2 highest amount orders.
WITH CTE AS
(
    SELECT *,ROW_NUMBER() OVER (PARTITION BY CATEGORY ORDER BY AMOUNT DESC) RN
    FROM CUSTOMER_ALL
)
SELECT *
FROM CTE
WHERE RN<=2


--12. Display customers whose amount is closest to category average amount. 
WITH CTE AS
(
    SELECT *,AVG(AMOUNT) OVER(PARTITION BY CATEGORY) AVG_AMT
    FROM CUSTOMER_ALL
),
CTE2 AS
(
SELECT *,ABS(AMOUNT-AVG_AMT) AS DIFF,ROW_NUMBER() OVER(PARTITION BY CATEGORY ORDER BY ABS(AMOUNT-AVG_AMT)) RN
FROM CTE
)
SELECT *
FROM CTE2
WHERE RN=1

--13. Display previous, current and next order amount together. 
WITH CTE AS
(
    SELECT CNAME,
           LAG(AMOUNT) OVER(ORDER BY AMOUNT) PREVIOUS_AMOUNT,
           AS AMOUNT CURRENT_AMOUNT,
           LEAD(AMOUNT) OVER(ORDER BY AMOUNT) AS NEXT_AMOUNT
    FROM CUSTOMER_ALL
)
SELECT * FROM CTE


--14. Display customers whose amount is greater than previous customer's amount.
WITH CTE AS
(
    SELECT *,
           LAG(AMOUNT) OVER(ORDER BY AMOUNT) PREV_AMT
    FROM CUSTOMER_ALL
)
SELECT *
FROM CTE
WHERE AMOUNT > PREV_AMT
--15. Display customers whose rank and dense rank are different. 
 WITH CTE AS
(
    SELECT *,RANK() OVER(ORDER BY AMOUNT DESC) AS R1,DENSE_RANK() OVER(ORDER BY AMOUNT DESC) AS  R2
    FROM CUSTOMER_ALL
)
SELECT *
FROM CTE
WHERE R1!=R2

--Part – C: 
--16. Display orders whose amount is neither highest nor lowest in their category.
WITH CTE AS
(
    SELECT *,
           MAX(AMOUNT) OVER(PARTITION BY CATEGORY) MAX_AMT,
           MIN(AMOUNT) OVER(PARTITION BY CATEGORY) MIN_AMT
    FROM CUSTOMER_ALL
)
SELECT *
FROM CTE
WHERE AMOUNT!=MAX_AMT AND AMOUNT!=MIN_AMT

--17. Display category-wise difference between highest and lowest amount.
WITH CTE AS
(
    SELECT CATEGORY,MAX(AMOUNT)-MIN(AMOUNT) AS DIFFERENCE
    FROM CUSTOMER_ALL
    GROUP BY CATEGORY
)
SELECT * FROM CTE
--18. Display customers whose amount is greater than all FURNITURE category orders.
WITH CTE AS
(
    SELECT *
    FROM CUSTOMER_ALL
    WHERE AMOUNT >(SELECT MAX(AMOUNT)
        FROM CUSTOMER_ALL
        WHERE CATEGORY='FURNITURE')
)
SELECT * FROM CTE


--19. Display categories where all orders are above 10000.
WITH CTE AS
(
    SELECT CATEGORY,MIN(AMOUNT) AS MIN_AMT
    FROM CUSTOMER_ALL
    GROUP BY CATEGORY
)
SELECT *
FROM CTE
WHERE MIN_AMT > 10000



--20. Display customers whose amount difference from category topper is minimum.
WITH CTE AS
(
    SELECT *,MAX(AMOUNT) OVER(PARTITION BY CATEGORY) TOP_AMOUNT
    FROM CUSTOMER_ALL
),
CTE2 AS
(
    SELECT *,TOP_AMOUNT-AMOUNT AS DIFF ,ROW_NUMBER() OVER(PARTITION BY CATEGORY ORDER BY TOP_AMOUNT-AMOUNT) RN
    FROM CTE
)
SELECT *
FROM CTE2
WHERE RN=2

