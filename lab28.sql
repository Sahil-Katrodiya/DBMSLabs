LAB 28

CREATE TABLE EMPLOYEE_LOG
(
    LOGID INT IDENTITY(1,1),
    EID INT,
    OLDVALUE VARCHAR(100),
    NEWVALUE VARCHAR(100),
    FIELDNAME VARCHAR(50),
    OPERATIONTYPE VARCHAR(20),
    LOGDATE DATETIME
);
--Part – A: 
--1. Create trigger for printing message after employee record insertion. 
    CREATE TRIGGER TRG_EMP_INSERT
    ON EMPLOYEE
    AFTER INSERT
    AS
    BEGIN
    PRINT 'Employee record inserted ';
    END;

--2. Create trigger for printing message after employee record update.
    CREATE TRIGGER TRG_EMP_UPDATE
    ON EMPLOYEE
    AFTER UPDATE
    AS
    BEGIN
    PRINT 'Employee record updated ';
    END;

--3. Create trigger for printing message after employee record deletion. 
    CREATE TRIGGER TRG_EMP_DELETE
    ON EMPLOYEE
    AFTER DELETE
    AS
    BEGIN
    PRINT 'Employee record deleted ';
    END;

--4. Create trigger for printing message after employee salary increment.
    CREATE TRIGGER TRG_SALARY_INCREMENT
    ON EMPLOYEE
    AFTER UPDATE
    AS
    BEGIN
        IF UPDATE(SALARY)
        BEGIN
        PRINT 'Employee salary updated';
        END
    END;

--5. Create trigger for automatically converting CITY names into uppercase during insertion.
    CREATE TRIGGER TRG_CITY_UPPERCASE
    ON EMPLOYEE
    AFTER INSERT
    AS
    BEGIN
            DECLARE @ID INT,@CITY VARCHAR(50);
        SELECT 
        @ID = EID,
        @CITY = CITY
        FROM INSERTED;

        UPDATE EMPLOYEE
        SET CITY = UPPER(@CITY)
        WHERE EID = @ID;
    END;
    
 
--Part – B: 
--6. Create trigger for updating employee city and printing old city and new city name. 

    CREATE TRIGGER TRG_CITY_UPDATE
    ON EMPLOYEE
    AFTER UPDATE
AS
BEGIN
    DECLARE @OLDCITY VARCHAR(50),
            @NEWCITY VARCHAR(50);

    SELECT @OLDCITY = CITY
    FROM DELETED;

    SELECT @NEWCITY = CITY
    FROM INSERTED;

    PRINT 'OLD CITY = ' + @OLDCITY;
    PRINT 'NEW CITY = ' + @NEWCITY;
END;

--7. Create trigger for automatically setting CITY as 'RAJKOT' if no city value is entered during employee insertion.
    CREATE TRIGGER TRG_DEFAULT_CITY
    ON EMPLOYEE
    AFTER INSERT
    AS
    BEGIN
        DECLARE @ID INT,
            @CITY VARCHAR(50);
    SELECT 
        @ID = EID,
        @CITY = CITY
    FROM INSERTED;

    IF @CITY IS NULL
    BEGIN
        UPDATE EMPLOYEE
        SET CITY = 'RAJKOT'
        WHERE EID = @ID;
    END
END;
--8. Create trigger for automatically adding current year in JOININGYEAR if no value is entered. 
    CREATE TRIGGER TRG_JOINYEAR
    ON EMPLOYEE
    AFTER INSERT
    AS
    BEGIN
        DECLARE @ID INT,@YEAR INT;

    SELECT 
        @ID = EID,
        @YEAR = JOININGYEAR
    FROM INSERTED;

    IF @YEAR IS NULL
    BEGIN
        UPDATE EMPLOYEE
        SET JOININGYEAR = YEAR(GETDATE())
        WHERE EID = @ID;
    END
END;

    

--9. Create trigger for printing employee full name after new employee insertion. 
    CREATE TRIGGER TRG_FULLNAME
    ON EMPLOYEE
    AFTER INSERT
    AS
    BEGIN
        DECLARE @FNAME VARCHAR(50), @LNAME VARCHAR(50);

    SELECT 
        @FNAME = FIRSTNAME,
        @LNAME = LASTNAME
    FROM INSERTED;

    PRINT @FNAME + ' ' + @LNAME;
END;


--10. Create trigger for automatically assigning department as ‘GENERAL’ if DEPARTMENT value is NULL.4
    CREATE TRIGGER TRG_DEPARTMENT
    ON EMPLOYEE
    AFTER INSERT
    AS
    BEGIN
        DECLARE @ID INT,@DEPT VARCHAR(50);
    SELECT 
        @ID = EID,
        @DEPT = DEPARTMENT
    FROM INSERTED;

    IF @DEPT IS NULL
    BEGIN
        UPDATE EMPLOYEE
        SET DEPARTMENT = 'GENERAL'
        WHERE EID = @ID;
    END
END;

 
--Part – C: 
--11. Create trigger for storing updated employee details such as EID, old salary, new salary, old department, 
--new department, and update date into EMPLOYEE_UPDATE_LOG table.
    CREATE TRIGGER TRG_UPDATE_LOG
    ON EMPLOYEE
    AFTER UPDATE
    AS
    BEGIN
    DECLARE @EID INT,
            @OLDSALARY VARCHAR(50),
            @NEWSALARY VARCHAR(50),
            @OLDDEPT VARCHAR(50),
            @NEWDEPT VARCHAR(50);

    SELECT 
        @EID = I.EID,
        @OLDSALARY = D.SALARY,
        @NEWSALARY = I.SALARY,
        @OLDDEPT = D.DEPARTMENT,
        @NEWDEPT = I.DEPARTMENT
    FROM INSERTED I, DELETED D;

    INSERT INTO EMPLOYEE_LOG( EID, OLDVALUE, NEWVALUE,FIELDNAME, OPERATIONTYPE, LOGDATE)
    VALUES(@EID, @OLDSALARY, @NEWSALARY, 'SALARY', 'UPDATE', GETDATE());

    INSERT INTO EMPLOYEE_LOG (EID, OLDVALUE, NEWVALUE, FIELDNAME, OPERATIONTYPE, LOGDATE )
    VALUES(@EID, @OLDDEPT, @NEWDEPT, 'DEPARTMENT', 'UPDATE', GETDATE());
END;


--12. Create trigger for storing newly inserted employee details with insertion date into 
--EMPLOYEE_INSERT_LOG table.
CREATE TRIGGER TRG_INSERT_LOG
ON EMPLOYEE
AFTER INSERT
AS
BEGIN
    DECLARE @EID INT,@NAME VARCHAR(100);

    SELECT @EID = EID FROM INSERTED;
    SELECT @NAME = FIRSTNAME FROM INSERTED;

    INSERT INTO EMPLOYEE_LOG
    (EID,OLDVALUE,NEWVALUE,FIELDNAME,OPERATIONTYPE,LOGDATE)
    VALUES
    (@EID,NULL,@NAME,'FIRSTNAME','INSERT',GETDATE());
END;


--13. Create trigger for storing old and new FIRSTNAME values after employee name update into 
--NAME_CHANGE_LOG table.
CREATE TRIGGER TRG_NAME_CHANGE
ON EMPLOYEE
AFTER UPDATE
AS
BEGIN
    DECLARE @EID INT,
            @OLDNAME VARCHAR(100),
            @NEWNAME VARCHAR(100);

    SELECT @EID = EID FROM INSERTED;
    SELECT @OLDNAME = FIRSTNAME FROM DELETED;
    SELECT @NEWNAME = FIRSTNAME FROM INSERTED;

    INSERT INTO EMPLOYEE_LOG
    (EID,OLDVALUE,NEWVALUE,FIELDNAME,OPERATIONTYPE,LOGDATE)
    VALUES(@EID,@OLDNAME,@NEWNAME,'FIRSTNAME','UPDATE',GETDATE() );
END;


--14. Create trigger for storing old city and new city details into CITY_UPDATE_LOG table after city update. 
CREATE TRIGGER TRG_CITY_CHANGE
ON EMPLOYEE
AFTER UPDATE
AS
BEGIN
    DECLARE @EID INT,
            @OLDCITY VARCHAR(100),
            @NEWCITY VARCHAR(100);

    SELECT @EID = EID FROM INSERTED;
    SELECT @OLDCITY = CITY FROM DELETED;
    SELECT @NEWCITY = CITY FROM INSERTED;

    INSERT INTO EMPLOYEE_LOG
    ( EID,OLDVALUE,NEWVALUE,FIELDNAME,OPERATIONTYPE,LOGDATE)
    VALUES (@EID,@OLDCITY,@NEWCITY,'CITY','UPDATE',GETDATE());
END;



--15. Implement INSTEAD OF INSERT trigger on EMPLOYEE table to automatically remove extra spaces from 
--FIRSTNAME and LASTNAME before insertion.

CREATE TRIGGER TRG_REMOVE_SPACE
ON EMPLOYEE
INSTEAD OF INSERT
AS
BEGIN
    DECLARE @EID INT,
            @FNAME VARCHAR(50),
            @LNAME VARCHAR(50),
            @DEPT VARCHAR(50),
            @SALARY DECIMAL(10,2),
            @CITY VARCHAR(50),
            @GENDER VARCHAR(10),
            @YEAR INT;

    SELECT
        @EID = EID,
        @FNAME = LTRIM(RTRIM(FIRSTNAME)),
        @LNAME = LTRIM(RTRIM(LASTNAME)),
        @DEPT = DEPARTMENT,
        @SALARY = SALARY,
        @CITY = CITY,
        @GENDER = GENDER,
        @YEAR = JOININGYEAR
    FROM INSERTED;

    INSERT INTO EMPLOYEE
    VALUES(@EID,@FNAME,@LNAME,@DEPT,@SALARY,@CITY,@GENDER,@YEAR);
END;