-- Oracle XE relational example.
-- The gvenzl/oracle-xe image creates APP_USER from environment variables.

ALTER SESSION SET CURRENT_SCHEMA = APP;

CREATE TABLE app_users (
    user_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    username VARCHAR2(50) NOT NULL UNIQUE,
    email VARCHAR2(100) NOT NULL UNIQUE,
    password_hash VARCHAR2(100) NOT NULL,
    age NUMBER(3),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    CONSTRAINT app_users_email_chk CHECK (REGEXP_LIKE(email, '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$')),
    CONSTRAINT app_users_password_chk CHECK (LENGTH(password_hash) >= 8),
    CONSTRAINT app_users_age_chk CHECK (age BETWEEN 18 AND 99)
);

INSERT INTO app_users (username, email, password_hash, age) VALUES
    ('admin', 'admin@example.com', 'password123', 30);

INSERT INTO app_users (username, email, password_hash, age) VALUES
    ('student', 'student@example.com', 'password456', 22);

COMMIT;
