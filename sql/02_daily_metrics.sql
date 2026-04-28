-- DAU and daily revenue.
SELECT
    event_date,
    COUNT(DISTINCT user_id) AS dau,
    COUNT(DISTINCT session_id) AS sessions,
    COUNT(DISTINCT CASE WHEN event_name = 'purchase' THEN order_id END) AS orders,
    SUM(CASE WHEN event_name = 'purchase' THEN revenue ELSE 0 END) AS revenue
FROM events
GROUP BY event_date
ORDER BY event_date;
