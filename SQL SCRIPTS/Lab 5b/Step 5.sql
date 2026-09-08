UPDATE CAR SET MAKE = 'Honda' WHERE CAR_TYPE_CAR_TYPE_ID = 1;

-- Adding data to delete
INSERT INTO CAR_TYPE VALUES(2,'This is a truck');
INSERT INTO CAR VALUES(98765, 'Ford','Tacoma',2);

-- Delete data
DELETE FROM CAR WHERE VIN = 98765;


--Update Payments
UPDATE PAYMENTS SET PAY_AMOUNT = PAY_AMOUNT * 1.10;



SELECT * FROM payment;
SELECT * FROM CAR;

commit;