CREATE TABLE Patients (
    patient_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    age INT CHECK (age >= 0),
    gender VARCHAR(20) CHECK (gender IN ('Male', 'Female', 'Other')),
    cancer_type VARCHAR(100),
    diagnosis_date DATE NOT NULL
);
CREATE TABLE Clinicians (
    clinician_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    role VARCHAR(50) CHECK (role IN ('Psychiatrist', 'Therapist', 'Health Coach'))
);
CREATE TABLE Appointments (
    appointment_id SERIAL PRIMARY KEY,
    patient_id INT NOT NULL REFERENCES Patients(patient_id) ON DELETE CASCADE,
    clinician_id INT NOT NULL REFERENCES Clinicians(clinician_id) ON DELETE SET NULL,
    appointment_date DATE NOT NULL,
    appointment_type VARCHAR(50) CHECK (
        appointment_type IN ('Initial Consult', 'Follow-up', 'Coaching Session')
    ),
    status VARCHAR(20) CHECK (status IN ('Completed', 'Missed', 'Cancelled'))
);
CREATE TABLE EngagementData (
    engagement_id SERIAL PRIMARY KEY,
    patient_id INT NOT NULL REFERENCES Patients(patient_id) ON DELETE CASCADE,
    messages_exchanged INT DEFAULT 0,
    last_message_date DATE
);