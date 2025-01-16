-- View showing a restaurants menu
CREATE VIEW restaurant_menu_view AS
SELECT 
    u.user_name as restaurant_name,
    i.item_title,
    i.item_price,
    COUNT(oi.item_fk) as times_ordered
FROM users u
JOIN items i ON u.user_pk = i.user_fk
LEFT JOIN order_items oi ON i.item_pk = oi.item_fk
GROUP BY u.user_name, i.item_title, i.item_price;

-- View customer order history (customer with over 0 orders)
CREATE VIEW customer_order_history_view AS
SELECT 
    u.user_name AS customer,
    COUNT(o.order_pk) AS total_orders,
    AVG(o.order_total_price) AS average_order_spent,
    SUM(o.order_total_price) AS total_spent
FROM users u
JOIN users_roles ur ON u.user_pk = ur.user_role_user_fk
JOIN roles r ON ur.user_role_role_fk = r.role_pk
LEFT JOIN orders o ON u.user_pk = o.user_fk
WHERE r.role_name = 'customer'
GROUP BY u.user_name
HAVING total_orders > 0;

-- View showing menu items with their order counts
CREATE VIEW items_statistics_view AS
SELECT 
    i.item_title,
    i.item_price,
    COUNT(oi.item_fk) as times_ordered
FROM items i
LEFT JOIN order_items oi ON i.item_pk = oi.item_fk
GROUP BY i.item_title, i.item_price;






















--- not in db
-- View showing active delivery partners
CREATE VIEW active_drivers_view AS
SELECT 
    u.user_name,
    v.vehicle_name,
    COUNT(o.order_pk) as current_orders
FROM users u
JOIN users_vehicles uv ON u.user_pk = uv.user_fk
JOIN vehicles v ON uv.vehicle_fk = v.vehicle_pk
LEFT JOIN orders o ON u.user_pk = o.user_fk
WHERE o.order_status = 'in_progress'
GROUP BY u.user_name, v.vehicle_name;

-- view current orders in progress
CREATE VIEW active_deliveries AS
SELECT o.order_pk,
    u.user_name as customer_name,
    v.vehicle_name,
    o.delivery_address
FROM orders o
JOIN users u ON o.user_fk = u.user_pk
LEFT JOIN users_vehicles uv ON u.user_pk = uv.user_fk
LEFT JOIN vehicles v ON uv.vehicle_fk = v.vehicle_pk
WHERE o.order_status IN ('pending', 'in_progress');


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