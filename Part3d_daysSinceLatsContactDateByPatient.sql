SELECT
    p.name,
    CURRENT_DATE - GREATEST(
        COALESCE(MAX(a.appointment_date), DATE '1900-01-01'),
        COALESCE(MAX(e.last_message_date), DATE '1900-01-01')
    ) AS days_since_last_contact
FROM Patients p
LEFT JOIN Appointments a
    ON p.patient_id = a.patient_id
LEFT JOIN EngagementData e
    ON p.patient_id = e.patient_id
GROUP BY p.patient_id, p.name
ORDER BY days_since_last_contact ASC;

