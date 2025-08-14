SELECT 
    p.patient_id,
    p.name,
    COUNT(a.appointment_id) AS completed_appointments
FROM Patients p
JOIN Appointments a 
    ON p.patient_id = a.patient_id
WHERE a.status = 'Completed'
  AND a.appointment_date >= DATE_TRUNC('month', CURRENT_DATE) - INTERVAL '3 months'
  AND a.appointment_date < DATE_TRUNC('month', CURRENT_DATE)
GROUP BY p.patient_id, p.name
ORDER BY completed_appointments DESC
LIMIT 5;
