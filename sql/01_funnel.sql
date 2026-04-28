-- Funnel users by step.
WITH funnel AS (
    SELECT event_name, COUNT(DISTINCT user_id) AS users
    FROM events
    WHERE event_name IN ('session_start','view_item','add_to_cart','begin_checkout','purchase')
    GROUP BY event_name
)
SELECT event_name, users
FROM funnel
ORDER BY CASE event_name
    WHEN 'session_start' THEN 1
    WHEN 'view_item' THEN 2
    WHEN 'add_to_cart' THEN 3
    WHEN 'begin_checkout' THEN 4
    WHEN 'purchase' THEN 5
END;
