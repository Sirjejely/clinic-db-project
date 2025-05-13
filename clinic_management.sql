-- Clinic Appointment and Patient Management System
-- Author: [Your Name]
-- Date: [Insert Date]
-- Description: SQL script to create tables for managing patients, doctors, appointments, treatments, and billing in a clinic.

-- Drop tables if they already exist (for clean setup)
DROP TABLE IF EXISTS Billing;
DROP TABLE IF EXISTS Treatments;
DROP TABLE IF EXISTS Appointments;
DROP TABLE IF EXISTS Patients;
DROP TABLE IF EXISTS Doctors;
DROP TABLE IF EXISTS Departments;

-- 1. Departments Table
CREATE TABLE Departments (
    department_id INT AUTO_INCREMENT PRIMARY KEY,
    department_name VARCHAR(100) NOT NULL UNIQUE
);
-- Insert sample departments
INSERT INTO Departments (department_name) VALUES
('General Medicine'),
('Pediatrics'),
('Cardiology'),
('Orthopedics');

-- 2. Doctors Table
CREATE TABLE Doctors (
    doctor_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(15),
    specialization VARCHAR(100),
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES Departments(department_id)
);

-- Insert sample doctors
INSERT INTO Doctors (full_name, email, phone, specialization, department_id) VALUES
('Dr. John Doe', 'john.doe@clinic.com', '08031234567', 'Cardiologist', 3),
('Dr. Jane Smith', 'jane.smith@clinic.com', '08037654321', 'Pediatrician', 2),
('Dr. Mike Brown', 'mike.brown@clinic.com', '07011223344', 'General Physician', 1);


-- 3. Patients Table
CREATE TABLE Patients (
    patient_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    gender ENUM('Male', 'Female', 'Other') NOT NULL,
    date_of_birth DATE NOT NULL,
    phone VARCHAR(15) UNIQUE,
    email VARCHAR(100) UNIQUE,
    address TEXT
);

-- Insert sample patients
INSERT INTO Patients (full_name, gender, date_of_birth, phone, email, address) VALUES
('Alice Johnson', 'Female', '1990-05-10', '09012345678', 'alice.johnson@email.com', '123 Main St'),
('Bob Williams', 'Male', '1985-03-22', '08087654321', 'bob.williams@email.com', '456 Second St'),
('Cynthia Adamu', 'Female', '1998-08-15', '08123456789', 'cynthia.adamu@email.com', '789 Third St');

-- 4. Appointments Table
CREATE TABLE Appointments (
    appointment_id INT AUTO_INCREMENT PRIMARY KEY,
    appointment_date DATETIME NOT NULL,
    status ENUM('Scheduled', 'Completed', 'Cancelled') DEFAULT 'Scheduled',
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id)
);

-- Insert sample appointments
INSERT INTO Appointments (appointment_date, status, patient_id, doctor_id) VALUES
('2025-05-14 09:00:00', 'Scheduled', 1, 1),
('2025-05-15 10:30:00', 'Completed', 2, 2),
('2025-05-16 12:00:00', 'Scheduled', 3, 3);

-- 5. Treatments Table
CREATE TABLE Treatments (
    treatment_id INT AUTO_INCREMENT PRIMARY KEY,
    appointment_id INT NOT NULL,
    diagnosis TEXT NOT NULL,
    prescription TEXT,
    treatment_notes TEXT,
    FOREIGN KEY (appointment_id) REFERENCES Appointments(appointment_id)
);

-- Insert sample treatments
INSERT INTO Treatments (appointment_id, diagnosis, prescription, treatment_notes) VALUES
(1, 'Hypertension', 'Amlodipine 5mg daily', 'Patient to monitor BP daily'),
(2, 'Flu', 'Paracetamol and rest', 'Patient improving, follow-up in 3 days');

-- 6. Billing Table
CREATE TABLE Billing (
    billing_id INT AUTO_INCREMENT PRIMARY KEY,
    appointment_id INT NOT NULL UNIQUE,
    amount DECIMAL(10, 2) NOT NULL,
    payment_status ENUM('Pending', 'Paid', 'Cancelled') DEFAULT 'Pending',
    payment_method ENUM('Cash', 'Card', 'Transfer') DEFAULT 'Cash',
    billing_date DATE DEFAULT (CURRENT_DATE),
    FOREIGN KEY (appointment_id) REFERENCES Appointments(appointment_id)
);

-- Insert sample billing records
INSERT INTO Billing (appointment_id, amount, payment_status, payment_method) VALUES
(1, 15000.00, 'Pending', 'Transfer'),
(2, 10000.00, 'Paid', 'Cash');
