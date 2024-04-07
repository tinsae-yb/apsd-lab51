CREATE TABLE Dentist (
    dentist_id INT PRIMARY KEY,
    first_name VARCHAR(30),
    last_name VARCHAR(30),
    contact_phone VARCHAR(20),
    email VARCHAR(100),
    specialization VARCHAR(100)
);


CREATE TABLE Patient (
    patient_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(30),
    last_name VARCHAR(30),
    contact_phone VARCHAR(20),
    email VARCHAR(100),
    mailing_address VARCHAR(100),
    date_of_birth DATE
);

CREATE TABLE Surgery_Location (
    location_id INT PRIMARY KEY,
    location_name VARCHAR(100),
    address VARCHAR(100)
);

CREATE TABLE Appointment (
    appointment_id INT AUTO_INCREMENT PRIMARY KEY,
    appointment_date_time DATETIME,
    dentist_id INT,
    patient_id INT,
    location_id INT,
    status ENUM('scheduled', 'cancelled', 'completed'),
    FOREIGN KEY (dentist_id) REFERENCES Dentist(dentist_id),
    FOREIGN KEY (patient_id) REFERENCES Patient(patient_id),
    FOREIGN KEY (location_id) REFERENCES Surgery_Location(location_id)
);

-- Insert data into Dentist table
INSERT INTO Dentist (dentist_id, first_name, last_name, contact_phone, email, specialization)
VALUES
    (1, 'John', 'Smith', '123-456-7890', 'john.smith@example.com', 'General Dentistry'),
    (2, 'Alice', 'Johnson', '456-789-0123', 'alice.johnson@example.com', 'Orthodontics'),
    (3, 'Michael', 'Williams', '789-012-3456', 'michael.williams@example.com', 'Endodontics'),
    (4, 'Emily', 'Brown', '234-567-8901', 'emily.brown@example.com', 'Pediatric Dentistry'),
    (5, 'James', 'Jones', '567-890-1234', 'james.jones@example.com', 'Oral Surgery'),
    (6, 'Sarah', 'Davis', '890-123-4567', 'sarah.davis@example.com', 'Periodontics'),
    (7, 'David', 'Miller', '345-678-9012', 'david.miller@example.com', 'Prosthodontics'),
    (8, 'Jennifer', 'Wilson', '678-901-2345', 'jennifer.wilson@example.com', 'Cosmetic Dentistry'),
    (9, 'Matthew', 'Taylor', '901-234-5678', 'matthew.taylor@example.com', 'Implant Dentistry'),
    (10, 'Emma', 'Anderson', '123-456-7890', 'emma.anderson@example.com', 'Oral Pathology');

-- Insert data into Patient table

INSERT INTO Patient (first_name, last_name, contact_phone, email, mailing_address, date_of_birth)
VALUES
    ('John', 'Doe', '123-456-7890', 'john.doe@example.com', '123 Main St, Anytown, USA', '1980-05-15'),
    ('Alice', 'Smith', '456-789-0123', 'alice.smith@example.com', '456 Elm St, Anytown, USA', '1992-10-25'),
    ('Michael', 'Johnson', '789-012-3456', 'michael.johnson@example.com', '789 Oak St, Anytown, USA', '1975-03-12'),
    ('Emily', 'Williams', '234-567-8901', 'emily.williams@example.com', '234 Pine St, Anytown, USA', '1988-07-08'),
    ('James', 'Brown', '567-890-1234', 'james.brown@example.com', '567 Maple St, Anytown, USA', '1995-09-30'),
    ('Sarah', 'Jones', '890-123-4567', 'sarah.jones@example.com', '890 Cedar St, Anytown, USA', '1983-12-18'),
    ('David', 'Davis', '345-678-9012', 'david.davis@example.com', '345 Birch St, Anytown, USA', '1990-02-22'),
    ('Jennifer', 'Miller', '678-901-2345', 'jennifer.miller@example.com', '678 Walnut St, Anytown, USA', '1986-06-05'),
    ('Matthew', 'Wilson', '901-234-5678', 'matthew.wilson@example.com', '901 Ash St, Anytown, USA', '1970-11-20'),
    ('Emma', 'Taylor', '123-456-7890', 'emma.taylor@example.com', '123 Cedar St, Anytown, USA', '1989-04-17');

-- Insert data into Surgery_Location table
INSERT INTO Surgery_Location (location_id, location_name, address)
VALUES
    (1, 'ABC Hospital Surgery Center', '123 Main St, Anytown, USA'),
    (2, 'XYZ Dental Clinic', '456 Elm St, Anytown, USA'),
    (3, 'City Medical Center', '789 Oak St, Anytown, USA'),
    (4, 'Sunrise Surgical Institute', '234 Pine St, Anytown, USA');


-- Insert data into Appointment table

INSERT INTO Appointment (appointment_date_time, dentist_id, patient_id, location_id, status)
VALUES
    ('2024-04-07 10:00:00', 1, 1, 1, 'scheduled'),
    ('2024-04-08 11:30:00', 2, 2, 2, 'scheduled'),
    ('2024-04-09 13:45:00', 3, 3, 3, 'scheduled'),
    ('2024-04-10 15:00:00', 4, 4, 4, 'scheduled'),
    ('2024-04-11 09:30:00', 5, 5, 1, 'scheduled'),
    ('2024-04-12 14:15:00', 6, 6, 2, 'scheduled'),
    ('2024-04-13 16:30:00', 7, 7, 3, 'scheduled'),
    ('2024-04-14 08:45:00', 8, 8, 4, 'scheduled'),
    ('2024-04-15 12:00:00', 9, 9, 1, 'scheduled'),
    ('2024-04-16 10:45:00', 10, 10, 2, 'scheduled');



-- Query to retrieve all dentists in alphabetical order by last name
SELECT * 
FROM Dentist 
ORDER BY last_name ASC;

-- Query to retrieve all appointments scheduled for a specific dentist (e.g., dentist_id = 1)

SELECT A.appointment_id, A.appointment_date_time, D.dentist_id, D.first_name AS dentist_first_name, D.last_name AS dentist_last_name,
       P.patient_id, P.first_name AS patient_first_name, P.last_name AS patient_last_name
FROM Appointment A
JOIN Dentist D ON A.dentist_id = D.dentist_id
JOIN Patient P ON A.patient_id = P.patient_id
WHERE A.dentist_id = 1;

-- Query to retrieve all appointments scheduled at a specific location (e.g., location_name = 'ABC Hospital Surgery Center')

SELECT A.appointment_id, A.appointment_date_time, D.first_name AS dentist_first_name, D.last_name AS dentist_last_name,
       P.first_name AS patient_first_name, P.last_name AS patient_last_name
FROM Appointment A
JOIN Dentist D ON A.dentist_id = D.dentist_id
JOIN Patient P ON A.patient_id = P.patient_id
JOIN Surgery_Location S ON A.location_id = S.location_id
WHERE S.location_name = 'ABC Hospital Surgery Center';


-- Query to retrieve all appointments scheduled for a specific patient (e.g., patient_id = 2) at a specific date (e.g., '2024-04-08')

SELECT A.appointment_id, A.appointment_date_time, D.first_name AS dentist_first_name, D.last_name AS dentist_last_name,
       S.location_name AS surgery_location
FROM Appointment A
JOIN Dentist D ON A.dentist_id = D.dentist_id
JOIN Surgery_Location S ON A.location_id = S.location_id
WHERE A.patient_id = 2
AND DATE(A.appointment_date_time) = '2024-04-08';

