-- adding a new column to car table
ALTER TABLE CAR
ADD PRICE VARCHAR(20);


-- changing the datatype of a column
ALTER TABLE CAR
MODIFY PRICE NUMBER(10,2);

--Modify a column of your choice and make it not null
UPDATE CAR SET PRICE = 4500 WHERE VIN = 123456; 
ALTER TABLE CAR
MODIFY PRICE Number(10,2) NOT NULL;


-- Modify a table and make one of the columns have a default value of 0
ALTER TABLE PAYMENT
MODIFY PAY_AMOUNT DEFAULT 0;


-- Truncate a table and and views its table def
TRUNCATE TABLE FEATURE;
DESC FEATURE;

-- Dropping a table; then trying to drop cars
DROP TABLE FEATURE;
DESC FEATURE;
DROP TABLE CAR;
DESC CAR;



commit;
SELECT * FROM CAR;
SELECT * FROM PAYMENT;
--SELECT * FROM FEATURE;