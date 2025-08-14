SELECT 
    c.clinician_id,
    c.name,
    ROUND(
        (SUM(CASE WHEN a.status = 'Missed' THEN 1 ELSE 0 END)::DECIMAL / COUNT(*)) * 100, 
        2
    ) AS missed_rate_percent
FROM Clinicians c
JOIN Appointments a 
    ON c.clinician_id = a.clinician_id
GROUP BY c.clinician_id, c.name
ORDER BY missed_rate_percent DESC;