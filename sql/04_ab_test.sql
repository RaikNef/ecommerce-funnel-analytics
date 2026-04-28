-- Conversion view_item -> add_to_cart by A/B group.
WITH viewed AS (
    SELECT ab_group, COUNT(DISTINCT user_id) AS view_users
    FROM events
    WHERE event_name = 'view_item'
    GROUP BY ab_group
),
carted AS (
    SELECT ab_group, COUNT(DISTINCT user_id) AS cart_users
    FROM events
    WHERE event_name = 'add_to_cart'
    GROUP BY ab_group
)
SELECT v.ab_group, v.view_users, c.cart_users,
    c.cart_users::float / v.view_users AS conversion
FROM viewed v
JOIN carted c ON v.ab_group = c.ab_group
ORDER BY v.ab_group;
