SELECT 
    c.clinician_id,
    c.name,
    ROUND(COUNT(a.appointment_id)::DECIMAL / COUNT(DISTINCT a.patient_id), 2) AS avg_appts_per_patient
FROM Clinicians c
JOIN Appointments a 
    ON c.clinician_id = a.clinician_id
GROUP BY c.clinician_id, c.name
ORDER BY avg_appts_per_patient DESC
LIMIT 1;
