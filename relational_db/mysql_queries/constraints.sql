-- Users Table with UNIQUE constraint
CREATE TABLE users (
    user_pk serial PRIMARY KEY,
    user_name VARCHAR(20) NOT NULL,
    user_last_name VARCHAR(20) NOT NULL,
    user_email VARCHAR(100) NOT NULL UNIQUE,  -- Prevents duplicate emails
    user_password VARCHAR(255) NOT NULL
);

-- Users Roles Junction Table with ON DELETE CASCADE
CREATE TABLE users_roles (
    user_role_user_fk bigint UNSIGNED NOT NULL,
    user_role_role_fk bigint UNSIGNED NOT NULL,
    PRIMARY KEY (user_role_user_fk, user_role_role_fk),
    FOREIGN KEY (user_role_user_fk) 
        REFERENCES users(user_pk) 
        ON DELETE CASCADE    -- When user is deleted, delete their roles
        ON UPDATE RESTRICT,  -- Prevent changes to user_pk if referenced
    FOREIGN KEY (user_role_role_fk) 
        REFERENCES roles(role_pk) 
        ON DELETE CASCADE 
        ON UPDATE RESTRICT
);

-- Example of composite key in phones table
CREATE TABLE phones (
    user_fk bigint UNSIGNED NOT NULL,
    phone_number VARCHAR(20),
    PRIMARY KEY (user_fk, phone_number),  -- Composite key
    FOREIGN KEY (user_fk) 
        REFERENCES users(user_pk) 
        ON DELETE CASCADE    -- When user is deleted, delete their phone numbers
);