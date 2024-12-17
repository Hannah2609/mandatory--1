
-- INNER JOIN: Get all orders with their corresponding user details
SELECT o.order_pk, u.user_name, u.user_email, o.delivery_address
FROM orders o
INNER JOIN users u ON o.user_fk = u.user_pk
WHERE o.order_status = 'pending';

-- LEFT JOIN: Find all users and their orders (including users with no orders)
SELECT u.user_name, u.user_email, COUNT(o.order_pk) as order_count
FROM users u
LEFT JOIN orders o ON u.user_pk = o.user_fk
GROUP BY u.user_pk, u.user_name, u.user_email;

-- RIGHT JOIN: Show all menu items and their orders (including unordered items)
SELECT i.item_title, i.item_price, COUNT(oi.order_fk) as times_ordered
FROM order_items oi
RIGHT JOIN items i ON oi.item_fk = i.item_pk
GROUP BY i.item_pk, i.item_title, i.item_price;

-- SELF JOIN: Find users who share the same last name
SELECT u1.user_name AS user1, u2.user_name AS user2, u1.user_last_name
FROM users u1
JOIN users u2 ON u1.user_last_name = u2.user_last_name
WHERE u1.user_pk < u2.user_pk;

-- CROSS JOIN: Generate all possible vehicle-role combinations
SELECT v.vehicle_name, r.role_name
FROM vehicles v
CROSS JOIN roles r;

-- Multiple JOINs: finding restaurants with their menu items and order statistics
SELECT u.user_name AS restaurant_name,
    i.item_title,
    COUNT(o.order_pk) as order_count
FROM users u
JOIN users_roles ur ON u.user_pk = ur.user_role_user_fk
JOIN roles r ON ur.user_role_role_fk = r.role_pk
LEFT JOIN items i ON u.user_pk = i.user_fk
LEFT JOIN order_items oi ON i.item_pk = oi.item_fk
LEFT JOIN orders o ON oi.order_fk = o.order_pk
WHERE r.role_name = 'restaurant'
GROUP BY u.user_name, i.item_title;


/*
TABLE ALIASES IN SQL
-------------------
Aliases are temporary nicknames for tables that exist only within a single query.
They make queries shorter and more readable, especially with multiple table joins.

Common alias patterns:
- users → u
- orders → o
- order_items → oi
- products → p

Example:
FROM users u         -- Now 'u' means 'users' in this query
JOIN orders o        -- 'o' means 'orders'
ON u.user_pk = o.user_fk

Must define alias when you first reference the table (usually in FROM or JOIN).
Different queries need their own alias definitions - they don't persist.

Remember: The database doesn't remember aliases between queries!
*/