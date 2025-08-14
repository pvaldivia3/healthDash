SELECT 
    p.patient_id,
    p.name
FROM Patients p
LEFT JOIN Appointments a
    ON p.patient_id = a.patient_id 
       AND a.appointment_date >= CURRENT_DATE - INTERVAL '30 days'
LEFT JOIN EngagementData e
    ON p.patient_id = e.patient_id 
       AND e.last_message_date >= CURRENT_DATE - INTERVAL '30 days'
WHERE a.appointment_id IS NULL
  AND e.engagement_id IS NULL;