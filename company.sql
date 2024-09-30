PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS users;
CREATE TABLE users(
    user_pk             TEXT,
    user_username       TEXT UNIQUE,
    user_name           TEXT,
    user_last_name      TEXT,
    user_email          TEXT UNIQUE,
    user_password       TEXT,
    user_created_at     TEXT,
    user_updated_at     TEXT,
    PRIMARY KEY(user_pk)
) WITHOUT ROWID;

-- Insert values into users table
INSERT INTO users (user_pk, user_username, user_name, user_last_name, user_email, user_password, user_created_at, user_updated_at)
VALUES
    ('user_1', 'alice', 'Alice', 'Jensen', 'alice@example.com', 'password123', datetime('now'), 0),
    ('user_2', 'bob', 'Bob', 'Eriksen', 'bob@example.com', 'password456', datetime('now'), 0),
    ('user_3', 'charlie', 'Charlie', 'Larsen', 'charlie@example.com', 'password789', datetime('now'), 0),
    ('user_4', 'diana', 'Diana', 'Sørensen','diana@example.com', 'password101', datetime('now'), 0);

SELECT * FROM users;

----------------------------

DROP TABLE IF EXISTS phones;
-- lookup table
CREATE TABLE phones(
    phone_number        TEXT,
    user_fk             TEXT, 
    PRIMARY KEY(user_fk, phone_number), --composite key
    FOREIGN KEY(user_fk) REFERENCES users(user_pk) ON DELETE CASCADE 
)WITHOUT ROWID;

-- Insert values into phones table
INSERT INTO phones (user_fk, phone_number)
VALUES
    ('user_1', '+4512345678'),
    ('user_2', '+4523456789'),
    ('user_3', '+4534567890'),
    ('user_4', '+4545678901');

SELECT * FROM phones;

----------------------------

DROP TABLE IF EXISTS roles;
-- lookup table
CREATE TABLE roles(
    role_pk        TEXT,
    role_name      TEXT UNIQUE, 
    PRIMARY KEY(role_pk)
)WITHOUT ROWID;

-- Insert values into roles table
INSERT INTO roles (role_pk, role_name)
VALUES
    ('role_1', 'Admin'),
    ('role_2', 'Costumer'),
    ('role_3', 'Partner'),
    ('role_4', 'Restaurent');

SELECT * FROM roles;

----------------------------

DROP TABLE IF EXISTS users_roles;
-- junction table
CREATE TABLE users_roles(
    user_fk        TEXT,
    role_fk        TEXT,
    PRIMARY KEY(user_fk, role_fk), -- compound key
    FOREIGN KEY(user_fk) REFERENCES users(user_pk) ON DELETE CASCADE,
    FOREIGN KEY(role_fk) REFERENCES roles(role_pk) ON DELETE CASCADE 
)WITHOUT ROWID;

-- Insert values into users_roles table
INSERT INTO users_roles (user_fk, role_fk)
VALUES
    ('user_1', 'role_1'),
    ('user_2', 'role_2'),
    ('user_3', 'role_3'),
    ('user_4', 'role_4');

SELECT * FROM users_roles;

----------------------------

DROP TABLE IF EXISTS vehicles;
-- lookup table
CREATE TABLE vehicles(
    vehicle_pk        TEXT,
    vehicle_name      TEXT UNIQUE, 
    PRIMARY KEY(vehicle_pk)
)WITHOUT ROWID;

-- Insert values into vehicles table
INSERT INTO vehicles (vehicle_pk, vehicle_name)
VALUES
    ('vehicle_1', 'Bicycle'),
    ('vehicle_2', 'Scooter'),
    ('vehicle_3', 'Car');

SELECT * FROM vehicles;

----------------------------

DROP TABLE IF EXISTS users_vehicles;
-- junction table
CREATE TABLE users_vehicles(
    user_fk           TEXT,
    vehicle_fk        TEXT,
    PRIMARY KEY(user_fk, vehicle_fk), -- compound key
    FOREIGN KEY(user_fk) REFERENCES users(user_pk) ON DELETE CASCADE,
    FOREIGN KEY(vehicle_fk) REFERENCES vehicles(vehicle_pk) ON DELETE CASCADE 
)WITHOUT ROWID;

-- Insert values into users_vehicles table
INSERT INTO users_vehicles (user_fk, vehicle_fk)
VALUES
    ('user_1', 'vehicle_1'),
    ('user_2', 'vehicle_2'),
    ('user_3', 'vehicle_3'),
    ('user_4', 'vehicle_4');

SELECT * FROM users_vehicles;

----------------------------

DROP TABLE IF EXISTS users_addresses;
-- lookup table
CREATE TABLE users_addresses(
    user_fk           TEXT,
    address_line       TEXT, 
    postal_code       TEXT, 
    primary_address    TEXT,
    PRIMARY KEY(user_fk, address_line, postal_code), -- composite key
    FOREIGN KEY(user_fk) REFERENCES users(user_pk) ON DELETE CASCADE
)WITHOUT ROWID;

-- Insert values into users_addresses table
INSERT INTO users_addresses (user_fk, address_line, postal_code, primary_address)
VALUES
    ('user_1', 'Street 1, City A', '1000', 0),
    ('user_2', 'Street 2, City B', '2000', 1),
    ('user_3', 'Street 3, City C', '3000', 1),
    ('user_4', 'Street 4, City D', '4000', 1);

SELECT * FROM users_addresses;

----------------------------