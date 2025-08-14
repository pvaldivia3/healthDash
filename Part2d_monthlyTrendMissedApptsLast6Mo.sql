WITH monthly_rates AS (
    SELECT
        DATE_TRUNC('month', a.appointment_date) AS month_start,
        ROUND(
            (SUM(CASE WHEN a.status = 'Missed' THEN 1 ELSE 0 END)::DECIMAL / COUNT(*)) * 100, 
            2
        ) AS missed_rate_percent
    FROM Appointments a
    WHERE a.appointment_date >= DATE_TRUNC('month', CURRENT_DATE) - INTERVAL '6 months'
      AND a.appointment_date < DATE_TRUNC('month', CURRENT_DATE)
    GROUP BY DATE_TRUNC('month', a.appointment_date)
    ORDER BY month_start
),
numbered AS (
    SELECT
        month_start,
        missed_rate_percent,
        ROW_NUMBER() OVER (ORDER BY month_start) AS x
    FROM monthly_rates
),
stats AS (
    SELECT
        COUNT(*) AS n,
        SUM(x) AS sum_x,
        SUM(missed_rate_percent) AS sum_y,
        SUM(x * missed_rate_percent) AS sum_xy,
        SUM(x * x) AS sum_xx
    FROM numbered
),
coefficients AS (
    SELECT
        (n * sum_xy - sum_x * sum_y) / (n * sum_xx - sum_x * sum_x) AS slope,
        (sum_y - ((n * sum_xy - sum_x * sum_y) / (n * sum_xx - sum_x * sum_x)) * sum_x) / n AS intercept
    FROM stats
)
SELECT
    TO_CHAR(n.month_start, 'YYYY-MM') AS month,
    n.missed_rate_percent,
    ROUND(c.slope * n.x + c.intercept, 2) AS trendline_value
FROM numbered n
CROSS JOIN coefficients c
ORDER BY n.month_start;