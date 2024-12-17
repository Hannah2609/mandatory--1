-- Trigger to set updated_at automatically
CREATE TRIGGER before_user_update
BEFORE UPDATE ON users
FOR EACH ROW
SET NEW.user_updated_at = UNIX_TIMESTAMP();

-- Trigger to log deleted users
CREATE TRIGGER after_user_delete
AFTER DELETE ON users
FOR EACH ROW
INSERT INTO deleted_users_log (user_pk, user_name, user_last_name, user_email, deleted_at)
VALUES (OLD.user_pk, OLD.user_name, OLD.user_last_name, OLD.user_email, UNIX_TIMESTAMP());

    -- creating the deleted_users_log for the trigger to log to
    CREATE TABLE deleted_users_log (
        log_id serial PRIMARY KEY,
        user_pk BIGINT UNSIGNED NOT NULL,
        user_name VARCHAR(20),
        user_last_name VARCHAR(20),
        user_email VARCHAR(100),
        deleted_at INTEGER UNSIGNED
    ) ENGINE=InnoDB;

