SELECT 
    c.clinician_id,
    c.name,
    COUNT(a.appointment_id) AS totalAppts
FROM Clinicians c
JOIN Appointments a 
    ON c.clinician_id = a.clinician_id
WHERE a.appointment_date > CURRENT_DATE-INTERVAL  '60 days'
GROUP BY c.clinician_id, c.name
ORDER BY totalAppts DESC;
