CREATE TABLE address (
    address_type         CHAR(10) NOT NULL,
    street               VARCHAR2(20),
    "Number"             NUMBER(11),
    city                 VARCHAR2(20),
    state                CHAR(2),
    zip                  VARCHAR2(10),
    customer_customer_id INTEGER NOT NULL
);

ALTER TABLE address ADD CONSTRAINT address_pk PRIMARY KEY ( address_type,
                                                            customer_customer_id );

CREATE TABLE car (
    vin                  INTEGER NOT NULL,
    make                 VARCHAR2(20),
    model                VARCHAR2(20) NOT NULL,
    car_type_car_type_id INTEGER NOT NULL
);

ALTER TABLE car ADD CONSTRAINT car_pk PRIMARY KEY ( vin );

CREATE TABLE car_type (
    car_type_id INTEGER NOT NULL,
    "Desc"      CHAR(100)
);

ALTER TABLE car_type ADD CONSTRAINT car_type_pk PRIMARY KEY ( car_type_id );

CREATE TABLE customer (
    customer_id INTEGER NOT NULL,
    name        CHAR(50)
);

ALTER TABLE customer ADD CONSTRAINT customer_pk PRIMARY KEY ( customer_id );

CREATE TABLE feature (
    feature_id INTEGER NOT NULL,
    feature    VARCHAR2(100),
    car_vin    INTEGER NOT NULL
);

ALTER TABLE feature ADD CONSTRAINT feature_pk PRIMARY KEY ( feature_id,
                                                            car_vin );

CREATE TABLE payment (
    payment_id       INTEGER NOT NULL,
    pay_date         DATE,
    pay_time         TIMESTAMP WITH LOCAL TIME ZONE,
    pay_amount       NUMBER(11, 2),
    rental_rental_id INTEGER
);

ALTER TABLE payment ADD CONSTRAINT payment_pk PRIMARY KEY ( payment_id );

CREATE TABLE preference (
    car_type_car_type_id INTEGER NOT NULL,
    customer_customer_id INTEGER NOT NULL,
    rank                 INTEGER
);

ALTER TABLE preference ADD CONSTRAINT preference_pk PRIMARY KEY ( car_type_car_type_id,
                                                                  customer_customer_id );

CREATE TABLE rental (
    rental_id            INTEGER NOT NULL,
    start_date           DATE,
    return_date          DATE,
    total_cost           NUMBER(11, 2),
    customer_customer_id INTEGER NOT NULL,
    car_vin              INTEGER NOT NULL
);

ALTER TABLE rental ADD CONSTRAINT rental_pk PRIMARY KEY ( rental_id );

ALTER TABLE address
    ADD CONSTRAINT address_customer_fk FOREIGN KEY ( customer_customer_id )
        REFERENCES customer ( customer_id );

ALTER TABLE car
    ADD CONSTRAINT car_car_type_fk FOREIGN KEY ( car_type_car_type_id )
        REFERENCES car_type ( car_type_id );

ALTER TABLE feature
    ADD CONSTRAINT feature_car_fk FOREIGN KEY ( car_vin )
        REFERENCES car ( vin );

ALTER TABLE payment
    ADD CONSTRAINT payment_rental_fk FOREIGN KEY ( rental_rental_id )
        REFERENCES rental ( rental_id );

ALTER TABLE preference
    ADD CONSTRAINT preference_car_type_fk FOREIGN KEY ( car_type_car_type_id )
        REFERENCES car_type ( car_type_id );

ALTER TABLE preference
    ADD CONSTRAINT preference_customer_fk FOREIGN KEY ( customer_customer_id )
        REFERENCES customer ( customer_id );

ALTER TABLE rental
    ADD CONSTRAINT rental_car_fk FOREIGN KEY ( car_vin )
        REFERENCES car ( vin );

ALTER TABLE rental
    ADD CONSTRAINT rental_customer_fk FOREIGN KEY ( customer_customer_id )
        REFERENCES customer ( customer_id );

alter table address
    Rename Column "Number" to House_Number;
COMMIT;