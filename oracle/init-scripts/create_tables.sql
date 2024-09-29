-- init-scripts/01_create_tables.sql

-- Connect as the application user
ALTER SESSION SET CURRENT_SCHEMA = &APP_USER;

-- Create users table
CREATE TABLE users (
    user_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    username VARCHAR2(50) NOT NULL UNIQUE,
    email VARCHAR2(100) NOT NULL UNIQUE,
    password VARCHAR2(100) NOT NULL,
    age NUMBER(3)
);

-- Add constraints
ALTER TABLE users ADD CONSTRAINT check_email 
    CHECK (REGEXP_LIKE(email, '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$'));

ALTER TABLE users ADD CONSTRAINT check_password 
    CHECK (LENGTH(password) >= 8);

ALTER TABLE users ADD CONSTRAINT check_age 
    CHECK (age >= 18 AND age <= 99);

-- Create a sequence for user_id (optional, as we're using IDENTITY)
CREATE SEQUENCE user_id_seq START WITH 1 INCREMENT BY 1;

COMMIT;

-- Output success message
SELECT 'Tables and constraints created successfully.' AS status FROM dual;