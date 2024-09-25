PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS users;

CREATE TABLE users(
    user_pk             TEXT,
    user_username       TEXT UNIQUE,
    user_name           TEXT,
    user_last_name      TEXT,
    user_email          TEXT UNIQUE,
    user_password       TEXT,
    user_blocked_at     TEXT,
    user_updated_at     TEXT,
    PRIMARY KEY(user_pk)
) WITHOUT ROWID;

INSERT INTO users VALUES ("dbd8c79b-1432-4398-a2f8-75dff97bd62b", "santiagodonoso", "Santiago", "Donoso", "sand@kea.dk", "password", 0, 0);
INSERT INTO users VALUES ("a23b1bfc-d090-4848-a1b6-bf60e8c9b352", "peter", "Peter", "Aa", "a@a.com", "password", 0, 0);
INSERT INTO users VALUES ("aadea47c-6255-4db0-b81e-dbc77f697d2e", "marie", "Marie", "Bb", "b@b.com", "password", 0, 0);

