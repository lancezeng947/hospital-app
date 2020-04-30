CREATE DATABASE IF NOT EXISTS hospital;

USE hospital;

DROP TABLE IF EXISTS insurance;
CREATE TABLE insurance (
    id int(11) NOT NULL,
    type varchar(255),
    name varchar(255),
    CONSTRAINT insurance_pk PRIMARY KEY (id)
    );
LOAD DATA LOCAL INFILE 'C:/Users/lzeng/Documents/GitHub/hospital-app/Data/insurance_table.csv' INTO TABLE insurance FIELDS TERMINATED BY ',' IGNORE 1 LINES;

INSERT INTO insurance (id, type, name) VALUES (0, NULL, 'Uninsured');

DROP TABLE IF EXISTS patients;
CREATE TABLE patients (
    id int(11) NOT NULL AUTO_INCREMENT,
    first_name varchar(255),
    last_name varchar(255),
    email varchar(255),
    gender char(1),
    phone_number varchar(15),
    street varchar(255),
    state char(2),
    zip varchar(9),
    insurance_id int(255) NOT NULL,
    CONSTRAINT patients_pk PRIMARY KEY (id),
    FOREIGN KEY (insurance_id) REFERENCES insurance(id)
                      ON UPDATE CASCADE
    );
LOAD DATA LOCAL INFILE 'C:/Users/lzeng/Documents/GitHub/hospital-app/Data/patients_table.csv' INTO TABLE patients FIELDS TERMINATED BY ',' IGNORE 1 LINES;


DROP TABLE IF EXISTS hospitals;
CREATE TABLE hospitals (
    id int(11) NOT NULL AUTO_INCREMENT,
    name varchar(255),
    type varchar(50),
    speciality varchar(255),
    street varchar(255),
    city varchar(255),
    state char(2),
    zip varchar(9),
    phone_number varchar(15),
    website varchar(255),
    CONSTRAINT hospitals_pk PRIMARY KEY (id)
    );
LOAD DATA LOCAL INFILE 'C:/Users/lzeng/Documents/GitHub/hospital-app/Data/hospital_table.csv' INTO TABLE hospitals FIELDS TERMINATED BY ',' IGNORE 1 LINES;

DROP TABLE IF EXISTS physicians;
CREATE TABLE physicians (
    id int(11) NOT NULL AUTO_INCREMENT,
    hospital_id int(11) NOT NULL,
    last_name varchar(255),
    first_name varchar(255),
    email varchar(255),
    department varchar(255),
    CONSTRAINT physicians_pk PRIMARY KEY (id),
    FOREIGN KEY (hospital_id) REFERENCES hospitals(id)
                      ON UPDATE CASCADE
    );
LOAD DATA LOCAL INFILE 'C:/Users/lzeng/Documents/GitHub/hospital-app/Data/physicians_table.csv' INTO TABLE physicians FIELDS TERMINATED BY ',' IGNORE 1 LINES;

DROP TABLE IF EXISTS nurses;
CREATE TABLE nurses (
    id int(11) NOT NULL AUTO_INCREMENT,
    hospital_id int(11) NOT NULL,
    last_name varchar(255),
    first_name varchar(255),
    department varchar(255),
    CONSTRAINT nurses_pk PRIMARY KEY (id),
    FOREIGN KEY (hospital_id) REFERENCES hospitals(id)
                      ON UPDATE CASCADE
    );
LOAD DATA LOCAL INFILE 'C:/Users/lzeng/Documents/GitHub/hospital-app/Data/nurse_table.csv' INTO TABLE nurses FIELDS TERMINATED BY ',' IGNORE 1 LINES;

DROP TABLE IF EXISTS drugs;
CREATE TABLE drugs (
    id int(11) NOT NULL AUTO_INCREMENT,
    name varchar(255),
    CONSTRAINT drugs_pk PRIMARY KEY (id)
    );
LOAD DATA LOCAL INFILE 'C:/Users/lzeng/Documents/GitHub/hospital-app/Data/drugs_table.csv' INTO TABLE drugs FIELDS TERMINATED BY ',' IGNORE 1 LINES;

DROP TABLE IF EXISTS diseases;
CREATE TABLE diseases (
    id int(11) NOT NULL,
    name varchar(255),
    CONSTRAINT disease_pk PRIMARY KEY (id)
    );
LOAD DATA LOCAL INFILE 'C:/Users/lzeng/Documents/GitHub/hospital-app/Data/disease_table.csv' INTO TABLE diseases FIELDS TERMINATED BY ',' IGNORE 1 LINES;

INSERT INTO diseases (id, name) VALUES (0, NULL);

DROP TABLE IF EXISTS disease_drug;
CREATE TABLE disease_drug (
    disease_id int(11) NOT NULL,
    drug_id int(11) NOT NULL ,
    CONSTRAINT
       FOREIGN KEY (disease_id) REFERENCES diseases(id),
       FOREIGN KEY (drug_id) REFERENCES  drugs(id)
                          ON UPDATE CASCADE

    );
LOAD DATA LOCAL INFILE 'C:/Users/lzeng/Documents/GitHub/hospital-app/Data/disease_drug_table.csv' INTO TABLE disease_drug FIELDS TERMINATED BY ',' IGNORE 1 LINES;

DROP TABLE IF EXISTS treatment;
CREATE TABLE treatment (
    id int(11) NOT NULL,
    activity varchar(255),
    description varchar(255),
    CONSTRAINT treatment_pk PRIMARY KEY (id)
    );
LOAD DATA LOCAL INFILE 'C:/Users/lzeng/Documents/GitHub/hospital-app/Data/treatment_table.csv' INTO TABLE treatment FIELDS TERMINATED BY ',' IGNORE 1 LINES;

DROP TABLE IF EXISTS visits;
CREATE TABLE visits (
    id int(11) NOT NULL AUTO_INCREMENT,
    patient_id int(11) NOT NULL,
    date DATE,
    doctor_id int(11) NOT NULL,
    nurse_id int(11) NOT NULL,
    hospital_id int(11) NOT NULL,
    disease_id int(11) NOT NULL,
    treatment_id int(11) NOT NULL,
    procedure_id int(1),
    CONSTRAINT visits_pk PRIMARY KEY (id),
    FOREIGN KEY (patient_id) REFERENCES patients(id)
                      ON UPDATE CASCADE,
    FOREIGN KEY (doctor_id) REFERENCES physicians(id)
                      ON UPDATE CASCADE,
    FOREIGN KEY (nurse_id) REFERENCES nurses(id)
                      ON UPDATE CASCADE,
    FOREIGN KEY (hospital_id) REFERENCES hospitals(id)
                      ON UPDATE CASCADE,
    FOREIGN KEY (disease_id) REFERENCES diseases(id)
                      ON UPDATE CASCADE,
    FOREIGN KEY (treatment_id) REFERENCES treatment(id)
                      ON UPDATE CASCADE
    );
LOAD DATA LOCAL INFILE 'C:/Users/lzeng/Documents/GitHub/hospital-app/Data/visit_table.csv' INTO TABLE visits FIELDS TERMINATED BY ',' IGNORE 1 LINES;

DROP TABLE IF EXISTS insurance_hospital;
CREATE TABLE insurance_hospital (
    insurance_id int(11) NOT NULL,
    hospital_id int(11) NOT NULL,
    CONSTRAINT
       FOREIGN KEY (hospital_id) REFERENCES hospitals(id),
       FOREIGN KEY (insurance_id) REFERENCES  insurance(id)
                          ON UPDATE CASCADE

    );
LOAD DATA LOCAL INFILE 'C:/Users/lzeng/Documents/GitHub/hospital-app/Data/insurance_hospital_table.csv' INTO TABLE insurance_hospital FIELDS TERMINATED BY ',' IGNORE 1 LINES;


SELECT first_name, last_name, disease_id, d.name
    FROM visits JOIN patients p on visits.patient_id = p.id
        JOIN diseases d on visits.disease_id = d.id
     WHERE p.id = 1 AND visits.treatment_id = 6;