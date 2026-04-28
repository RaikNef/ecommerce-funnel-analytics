-- Retention by days after first activity.
WITH first_seen AS (
    SELECT user_id, MIN(event_date) AS first_date
    FROM events
    GROUP BY user_id
),
activity AS (
    SELECT DISTINCT e.user_id, e.event_date, f.first_date,
        DATE_PART('day', e.event_date::timestamp - f.first_date::timestamp) AS day_number
    FROM events e
    JOIN first_seen f ON e.user_id = f.user_id
)
SELECT day_number, COUNT(DISTINCT user_id) AS retained_users
FROM activity
WHERE day_number IN (0, 1, 7, 14, 30)
GROUP BY day_number
ORDER BY day_number;
