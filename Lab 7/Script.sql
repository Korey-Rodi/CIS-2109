-- Question 1
Create table Staff_old_Records
(Staff_Id   Number(11,0) PRIMARY KEY,
First_Name Varchar(25) NOT NULL,
Last_Name Varchar(25),
SSN        Number(9,0) Constraint Social UNIQUE,
Birth_Date Date Default Date '1900-01-01',
Hire_Date Date,
CONSTRAINT hire_date_check CHECK (hire_date > Birth_date));

comment on column staff_old_records.hire_date IS 'This corresponds to the day the employee was hired';

ALTER TABLE STAFF 
add(Salary Number(11,0) , SSN Number(9,0));


-- TO ALLOW FOR NULL TO BE ENTERED
ALTER TABLE Staff MODIFY (ADDRESS_ID NULL);
ALTER TABLE Staff MODIFY (STORE_ID NULL);
ALTER TABLE Staff MODIFY (USERNAME NULL);
ALTER TABLE Staff MODIFY (PASSWORD NULL);


MERGE INTO Staff s
USING staff_old_records so
ON (s.staff_ID = so.staff_id)
WHEN MATCHED THEN
    UPDATE SET
    s.ssn = so.ssn,
    s.salary = so.salary
WHEN NOT MATCHED THEN
    INSERT (
    Staff_ID,
    First_Name,
    Last_Name,
    ADDRESS_ID,
    PICTURE,
    EMAIL,
    STORE_ID,
    ACTIVE,
    USERNAME,
    PASSWORD,
    LAST_UPDATE,
    SSN,
    SALARY
) VALUES 
(so.staff_id,so.first_name,so.last_name,
NULL,NULL,NULL,NULL,0,NULL,NULL,SYSDATE,so.ssn,so.salary);

UPDATE Staff
Set Salary = 30000
Where staff_id = 2;

-- Question 2
Create or replace view Non_Active_Staff AS
SELECT *
FROM STAFF s
WHERE Active = 0;

UPDATE Non_Active_Staff -- BOTH THE TABLE AND VIEW ARE AFFECTED
SET First_Name = 'Korey'
Where staff_id = 2;

UPDATE Non_Active_Staff -- BOTH THE TABLE AND VIEW ARE AFFECTED
SET Active = 0
Where staff_id = 2;


CREATE OR REPLACE VIEW Non_Active_Staff AS
SELECT *
FROM STAFF
WHERE Active = 0
WITH CHECK OPTION;

UPDATE Non_Active_Staff -- BOTH THE TABLE AND VIEW ARE AFFECTED
SET First_Name = 'John'
WHERE staff_id = 2;

UPDATE Non_Active_Staff -- THIS FAILS
SET Active = 1
WHERE staff_id = 2;


CREATE MATERIALIZED VIEW Non_Active_Staff_MV AS
SELECT *
FROM Staff
where active = 0;

UPDATE Non_Active_Staff_mv -- THIS FAILS
SET First_Name = 'Jane'
WHERE staff_id = 2;

UPDATE Non_Active_Staff_mv -- THIS FAILS
SET Active = 1
WHERE staff_id = 2;


SELECT * FROM Non_Active_Staff;
select * from non_active_staff_mv;
select * from staff;


-- Question 3
CREATE FUNCTION Staff_total (Staff_ID in NUMBER)
    RETURN NUMBER
    IS Staff_nbr NUMBER(11,2);
    BEGIN
        SELECT COUNT(*)
        INTO Staff_Nbr
        FROM Staff s
        WHERE s.Salary < (Select salary from staff where staff_id = staff_total.staff_id);
        return(Staff_nbr);
    END;
    
SELECT staff_total(2) from dual;

SELECT staff_id, salary, staff_total(Staff_id)
from staff;

-- Question 4
CREATE OR REPLACE PROCEDURE Salary_Increase (p_store NUMBER) AS
BEGIN
    UPDATE Staff
    SET Salary = Salary + 1000
    WHERE Store_ID = p_store;
END;

execute salary_increase(1);
rollback; -- It reverts the changes from the procedure 



