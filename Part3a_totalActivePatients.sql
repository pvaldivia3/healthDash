SELECT COUNT(DISTINCT COALESCE(a.patient_id, e.patient_id)) AS active_patients
FROM Appointments a
FULL OUTER JOIN EngagementData e
    ON a.patient_id = e.patient_id
WHERE (a.appointment_date >= CURRENT_DATE - INTERVAL '30 days'
       OR e.last_message_date >= CURRENT_DATE - INTERVAL '30 days');