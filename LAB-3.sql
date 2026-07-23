--1. Retrieve all data from table DEPOSIT.  
	Select * from Deposit

--2. Retrieve all data from table STUDENT.
	Select * from STUDENT

--3. Display Account No, Customer Name & Amount from DEPOSIT.
	Select ActNo,cname,amount
	from Deposit

--4. Display Student Name and City from STUDENT. 
	SELECT SNAME, CITY FROM STUDENT;

--5. Display student details of all students who belongs to COMPUTER branch from student table.
	SELECT * FROM STUDENT
	WHERE BRANCH = 'COMPUTER';

--6. Give Student Name, City and SPI of student whose SPI is greater than 6.50.
	SELECT SNAME, CITY, SPI FROM STUDENT
	WHERE SPI > 6.50;

--7. Give name of Student whose branch is COMPUTER and SPI is greater than 8.00. 
	SELECT SNAME FROM STUDENT
	WHERE BRANCH = 'COMPUTER' AND SPI > 8.00;

--8. Give names of students whose ID is greater than 103 and belongs to kutch from STUDENT table. 
	SELECT SNAME FROM STUDENT
	WHERE STDID > 103 AND CITY = 'Kutch';

--9. Display names of students whose ID is less than 105 from STUDENT table. 
	SELECT SNAME FROM STUDENT
	WHERE STDID <105

--10. Display names of students who belong to either ‘RAJKOT’ or ‘SURAT’ from STUDENT table (USE OR & IN). 
	SELECT SNAME FROM STUDENT
	WHERE CITY = 'RAJKOT' OR CITY = 'SURAT';

	SELECT SNAME FROM STUDENT
	WHERE CITY IN ('RAJKOT', 'SURAT');

--11. Display names of students with branch whose SPI is greater than 8.0 and ID is less than 105 from 
--STUDENT table. 
	SELECT SNAME, BRANCH FROM STUDENT
	WHERE SPI > 8.0 AND STDID < 105;

--12. Find all students whose SPI is greater than or equal to 7.0 and less than or equal to 9.0 from STUDENT 
--table (USE AND & BETWEEN).
	SELECT * FROM STUDENT
	WHERE SPI >= 7.0 AND SPI <= 9.0;

	SELECT * FROM STUDENT
	WHERE SPI BETWEEN 7.0 AND 9.0;

--13. Find all students who do not belong to ‘COMPUTER’ branch from STUDENT table. 
	SELECT * FROM STUDENT
	WHERE BRANCH <> 'COMPUTER';

--14. Display Student ID, Name & SPI of students who belong to ‘COMPUTER’, ‘CIVIL’ or ‘CHEMICAL’ branch and ID is less than 104 from STUDENT table. 
	SELECT STDID, SNAME, SPI FROM STUDENT
	WHERE BRANCH IN ('COMPUTER', 'CIVIL', 'CHEMICAL')
	AND STDID < 104;

--15. Display all student IDs and names who do not belong to ‘COMPUTER’ or ‘CIVIL’ branch from STUDENT table (USE NOT IN). 
	SELECT STDID, SNAME FROM STUDENT
	WHERE BRANCH NOT IN ('COMPUTER', 'CIVIL');

--16. Display all student names other than ‘DEEP’ from STUDENT table (USE NOT, <>, !=). 
	SELECT * FROM STUDENT
	WHERE NOT SNAME = 'DEEP';

	SELECT * FROM STUDENT
	WHERE SNAME <> 'DEEP';

	SELECT * FROM STUDENT
	WHERE SNAME != 'DEEP';

--17. Display student names whose branch is not available (NULL) in STUDENT table.
	SELECT SNAME FROM STUDENT
	WHERE BRANCH IS NULL;

	--NO OUTPUT
	INSERT INTO STUDENT VALUES(111,'RAHUL','AHMEDABAD',7.6,NULL,NULL)
--18. Retrieve all unique branches using DISTINCT from STUDENT table. 
	SELECT DISTINCT BRANCH FROM STUDENT;

--19. Retrieve first 50% records from STUDENT table.
	SELECT TOP 50 PERCENT * FROM STUDENT;

--20. Retrieve first five student IDs from STUDENT table.
	SELECT TOP 5 STDID FROM STUDENT;

--PART–B 
--1. Display all the details of first five students from STUDENT table. 
	SELECT TOP 5 * FROM STUDENT;

--2. Display all the details of first three students whose SPI is greater than 8.0 from STUDENT table.
	SELECT TOP 3 * FROM STUDENT
	WHERE SPI > 8.0;

--3. Display Student ID, Name of first five students whose branch does not belong to ‘COMPUTER’ from 
--STUDENT table. 
	SELECT TOP 5 STDID, SNAME FROM STUDENT
	WHERE BRANCH <> 'COMPUTER';
--4. Select all details with student IDs not in the range 105 to 109 from STUDENT table. 
	SELECT * FROM STUDENT
	WHERE STDID NOT BETWEEN 105 AND 109;

--5. Select all records from STUDENT where SPI is greater than 7.0 and less than or equal to 9.0, and student ID is between 102 and 108. 
	SELECT * FROM STUDENT
	WHERE SPI > 7.0 AND SPI <= 9.0 AND STDID BETWEEN 102 AND 108;

--Part – C 

--1. Display all details of students who have SPI more than 8.5 without using * from STUDENT table.
	SELECT STDID, SNAME, CITY, SPI, BRANCH, AGE
	FROM STUDENT
	WHERE SPI > 8.5;

--2. Retrieve names of students whose city is ‘RAJKOT’ and SPI is less than 8.00.
	SELECT SNAME FROM STUDENT
	WHERE CITY = 'RAJKOT' AND SPI < 8.00;

--3. Retrieve records from STUDENT table where SPI is greater than 8.0 and student ID is less than 105.
	SELECT * FROM STUDENT
	WHERE SPI > 8.0 AND STDID < 105;

--4. Retrieve records from STUDENT table where SPI is greater than 7.5 and student ID is between 100 and 
--110 and city is ‘RAJKOT’ or ‘SURAT’. 
	SELECT * FROM STUDENT
	WHERE SPI > 7.5 AND STDID BETWEEN 100 AND 110 AND (CITY = 'RAJKOT' OR CITY = 'SURAT');

--5. Display details of students who belong to ‘CIVIL’ or ‘MECHANICAL’ branch and SPI is greater than 8.0. 
	SELECT * FROM STUDENT
	WHERE BRANCH IN ('CIVIL', 'MECHANICAL') AND SPI > 8.0;
