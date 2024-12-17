
-- UNION: combines admins and restaurants into a single result set, showing the first and last names of users along with their roles 
SELECT u.user_name, u.user_last_name, r.role_name
FROM users u
JOIN users_roles ur ON u.user_pk = ur.user_role_user_fk
JOIN roles r ON ur.user_role_role_fk = r.role_pk
WHERE r.role_name = 'admin'
UNION
SELECT u.user_name, u.user_last_name, r.role_name
FROM users u
JOIN users_roles ur ON u.user_pk = ur.user_role_user_fk
JOIN roles r ON ur.user_role_role_fk = r.role_pk
WHERE r.role_name = 'restaurant';


-- HAVING: Find restaurants with more than 10 orders
SELECT 
    u.user_name,
    COUNT(o.order_pk) as order_count
FROM users u
JOIN orders o ON u.user_pk = o.user_fk
GROUP BY u.user_name
HAVING order_count > 10;



-- GROUP BY: Find total order count and total spent of customers with orders
SELECT o.user_fk AS customer_user_pk, 
    u.user_name AS customer_name,
    COUNT(o.order_pk) AS total_orders,
    SUM(o.order_total_price) AS total_spent
FROM orders o
JOIN users u ON o.user_fk = u.user_pk
GROUP BY o.user_fk, u.user_name;