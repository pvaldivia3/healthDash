-- Insert 50 Clinicians
INSERT INTO Clinicians (name, role)
SELECT
    'Clinician ' || gs,
    CASE (gs % 3)
        WHEN 0 THEN 'Psychiatrist'
        WHEN 1 THEN 'Therapist'
        ELSE 'Health Coach'
    END
FROM generate_series(1, 50) AS gs;

-- Insert 50 Patients
INSERT INTO Patients (name, age, gender, cancer_type, diagnosis_date)
SELECT
    'Patient ' || gs,
    (18 + (random() * 62))::INT,  -- ages 18–80
    CASE (gs % 3)
        WHEN 0 THEN 'Male'
        WHEN 1 THEN 'Female'
        ELSE 'Other'
    END,
    CASE (gs % 4)
        WHEN 0 THEN 'Breast Cancer'
        WHEN 1 THEN 'Lung Cancer'
        WHEN 2 THEN 'Prostate Cancer'
        ELSE 'Leukemia'
    END,
    (CURRENT_DATE - (random() * 365 * 5)::INT)  -- within last 5 years
FROM generate_series(1, 50) AS gs;

-- Insert 50 Appointments
INSERT INTO Appointments (patient_id, clinician_id, appointment_date, appointment_type, status)
SELECT
    (random() * 49 + 1)::INT,  -- patient_id between 1 and 50
    (random() * 49 + 1)::INT,  -- clinician_id between 1 and 50
    (CURRENT_DATE - (random() * 365)::INT), -- within last year
    CASE (gs % 3)
        WHEN 0 THEN 'Initial Consult'
        WHEN 1 THEN 'Follow-up'
        ELSE 'Coaching Session'
    END,
    CASE (gs % 3)
        WHEN 0 THEN 'Completed'
        WHEN 1 THEN 'Missed'
        ELSE 'Cancelled'
    END
FROM generate_series(1, 50) AS gs;

-- Insert 50 EngagementData rows
INSERT INTO EngagementData (patient_id, messages_exchanged, last_message_date)
SELECT
    gs,  -- patient_id 1–50
    (random() * 100)::INT,  -- messages between 0 and 100
    (CURRENT_DATE - (random() * 180)::INT) -- within last 6 months
FROM generate_series(1, 50) AS gs;
