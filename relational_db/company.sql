-- Drop tables 
DROP TABLE IF EXISTS item_images;
DROP TABLE IF EXISTS order_items;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS items;
DROP TABLE IF EXISTS users_roles;
DROP TABLE IF EXISTS roles;
DROP TABLE IF EXISTS phones;
DROP TABLE IF EXISTS users_addresses;
DROP TABLE IF EXISTS users_vehicles;
DROP TABLE IF EXISTS vehicles;
DROP TABLE IF EXISTS users;



-- Users Table
CREATE TABLE users (
    user_pk serial PRIMARY KEY,
    user_name VARCHAR(20) NOT NULL,
    user_last_name VARCHAR(20) NOT NULL,
    user_email VARCHAR(100) NOT NULL UNIQUE,
    user_password VARCHAR(255) NOT NULL,
    user_created_at INTEGER UNSIGNED,
    user_deleted_at INTEGER UNSIGNED,
    user_blocked_at INTEGER UNSIGNED,
    user_updated_at INTEGER UNSIGNED,
    user_verified_at INTEGER UNSIGNED,
    user_verification_key CHAR(36) DEFAULT NULL
) ENGINE=InnoDB;


-- Insert initial users data
INSERT INTO users (user_pk, user_name, user_last_name, user_email, user_password, user_created_at, user_deleted_at, user_blocked_at, user_updated_at, user_verified_at, user_verification_key)
VALUES
    ('1', 'A', 'Aa', 'a@example.com', 'password1', UNIX_TIMESTAMP(), 0, 0, 0, UNIX_TIMESTAMP(), UUID()),
    ('2', 'B', 'Bb', 'b@example.com', 'password2', UNIX_TIMESTAMP(), 0, 0, 0, UNIX_TIMESTAMP(), UUID()),
    ('3', 'C', 'Cc', 'c@example.com', 'password3', UNIX_TIMESTAMP(), 0, 0, 0, UNIX_TIMESTAMP(), UUID()),
    ('4', 'D', 'Dd', 'd@example.com', 'password4', UNIX_TIMESTAMP(), 0, 0, 0, UNIX_TIMESTAMP(), UUID());



-- Phones Table
CREATE TABLE phones (
    user_fk BIGINT UNSIGNED NOT NULL,
    phone_number VARCHAR(20) UNIQUE,
    PRIMARY KEY (user_fk, phone_number),
    FOREIGN KEY (user_fk) REFERENCES users(user_pk) ON DELETE CASCADE
) ENGINE=InnoDB;

-- Insert phones data
INSERT INTO phones (user_fk, phone_number)
VALUES
    ('1', '+4512345678'),
    ('1', '+4512567833'),
    ('2', '+4523456789'),
    ('3', '+4534567890'),
    ('4', '+4545678901');



-- Roles Table
CREATE TABLE roles (
    role_pk serial PRIMARY KEY,
    role_name VARCHAR(10) UNIQUE
) ENGINE=InnoDB;

-- Insert roles data
INSERT INTO roles (role_pk, role_name)
VALUES
    ('1', 'admin'),
    ('2', 'customer'),
    ('3', 'partner'),
    ('4', 'restaurant');



-- Users Roles Junction Table
CREATE TABLE users_roles (
    user_role_user_fk BIGINT UNSIGNED NOT NULL,
    user_role_role_fk BIGINT UNSIGNED NOT NULL,
    PRIMARY KEY (user_role_user_fk, user_role_role_fk),
    FOREIGN KEY (user_role_user_fk) REFERENCES users(user_pk) ON DELETE CASCADE ON UPDATE RESTRICT,
    FOREIGN KEY (user_role_role_fk) REFERENCES roles(role_pk) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB;

-- Insert users_roles data
INSERT INTO users_roles (user_role_user_fk, user_role_role_fk)
VALUES
    ('1', '1'),
    ('2', '2'),
    ('3', '3'),
    ('4', '4');



-- Vehicles Table
CREATE TABLE vehicles (
    vehicle_pk serial PRIMARY KEY,
    vehicle_name VARCHAR(50) UNIQUE
) ENGINE=InnoDB;

-- Insert vehicles data
INSERT INTO vehicles (vehicle_pk, vehicle_name)
VALUES
    ('1', 'Bicycle'),
    ('2', 'Scooter'),
    ('3', 'Car');



-- Users Vehicles Junction Table
CREATE TABLE users_vehicles (
    user_fk serial,
    vehicle_fk BIGINT UNSIGNED NOT NULL,
    PRIMARY KEY (user_fk, vehicle_fk),
    FOREIGN KEY (user_fk) REFERENCES users(user_pk) ON DELETE CASCADE,
    FOREIGN KEY (vehicle_fk) REFERENCES vehicles(vehicle_pk) ON DELETE CASCADE
) ENGINE=InnoDB;

-- Insert users_vehicles data
INSERT INTO users_vehicles (user_fk, vehicle_fk)
VALUES
    ('1', '1'),
    ('2', '2'),
    ('3', '3'),
    ('4', '1');



-- Users Addresses Table
CREATE TABLE users_addresses (
    user_fk serial,
    address_line VARCHAR(255),
    postal_code VARCHAR(20),
    primary_address BOOLEAN DEFAULT FALSE,
    PRIMARY KEY (user_fk, address_line, postal_code),
    FOREIGN KEY (user_fk) REFERENCES users(user_pk) ON DELETE CASCADE
) ENGINE=InnoDB;

-- Insert users_addresses data
INSERT INTO users_addresses (user_fk, address_line, postal_code, primary_address)
VALUES
    ('1', 'Street 1, City A', '1000', FALSE),
    ('2', 'Street 2, City B', '2000', TRUE),
    ('3', 'Street 3, City C', '3000', TRUE),
    ('4', 'Street 4, City D', '4000', TRUE);



-- Items Table
CREATE TABLE items (
    item_pk serial PRIMARY KEY,
    user_fk BIGINT UNSIGNED NOT NULL,
    item_title VARCHAR(50) NOT NULL,
    item_price DECIMAL(5,2) NOT NULL,
    item_image VARCHAR(50),
    item_created_at INTEGER UNSIGNED,
    item_deleted_at INTEGER UNSIGNED,
    item_blocked_at INTEGER UNSIGNED,
    item_updated_at INTEGER UNSIGNED,
    FOREIGN KEY (user_fk) REFERENCES users(user_pk) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB;

CREATE INDEX idx_item_title ON items(item_title);

-- Insert food items
INSERT INTO items (item_pk, user_fk, item_title, item_price, item_image, item_created_at, item_deleted_at, item_blocked_at, item_updated_at)
VALUES
    ('1', '4', 'Pizza', 12.99, 'dish_1.jpg', UNIX_TIMESTAMP(), 0, 0, 0),
    ('2', '4', 'Burger', 9.99, 'dish_2.jpg', UNIX_TIMESTAMP(), 0, 0, 0),
    ('3', '4', 'Sushi', 15.99, 'dish_3.jpg', UNIX_TIMESTAMP(), 0, 0, 0),
    ('4', '4', 'Pasta', 11.99, 'dish_4.jpg', UNIX_TIMESTAMP(), 0, 0, 0);




-- Orders Table
CREATE TABLE orders (
    order_pk serial PRIMARY KEY,
    user_fk BIGINT UNSIGNED NOT NULL,
    delivery_address VARCHAR(255) NOT NULL,
    restaurant_name VARCHAR(50) NOT NULL,
    order_total_price DECIMAL(5,2) NOT NULL,
    order_status VARCHAR(20) DEFAULT 'pending',
    order_created_at INTEGER UNSIGNED,
    FOREIGN KEY (user_fk) REFERENCES users(user_pk) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB;

-- Insert orders
INSERT INTO orders (order_pk, user_fk, delivery_address, restaurant_name, order_total_price, order_status, order_created_at )
VALUES
    (
        '1',
        '2',
        'Street 2, City B',
        'Restaurant D',
        32.00,
        'delivered',
        UNIX_TIMESTAMP()
    ),
    (
        '2',
        '1',
        'Street 1, City A',
        'Restaurant B',
        12.00,
        'pending',
        UNIX_TIMESTAMP()
    )
;



-- Order Items Junction Table
CREATE TABLE order_items (
    order_fk BIGINT UNSIGNED NOT NULL,
    item_fk BIGINT UNSIGNED NOT NULL,
    item_quantity INTEGER NOT NULL,
    item_price DECIMAL(5,2) NOT NULL, 
    PRIMARY KEY (order_fk, item_fk),
    FOREIGN KEY (order_fk) REFERENCES orders(order_pk) ON DELETE CASCADE,
    FOREIGN KEY (item_fk) REFERENCES items(item_pk) ON DELETE RESTRICT
) ENGINE=InnoDB;

-- Insert order items
INSERT INTO order_items ( order_fk, item_fk, item_quantity, item_price )
VALUES
    ('1', '1', 2, 12.99),  -- 2 pizzas
    ('1', '2', 1, 9.99),   -- 1 burger
    ('2', '2', 2, 9.99),   -- 2 burgers
    ('2', '3', 1, 15.99);  -- 1 sushi