-- Run with:
-- docker exec -i uni-oracle sqlplus app/uni_password@//localhost:1521/XEPDB1 < scripts/examples.sql

SELECT user_id, username, email, age
FROM app_users
ORDER BY user_id;

-- Oracle string/date functions are commonly used in reports.
SELECT
    UPPER(username) AS username_upper,
    EXTRACT(YEAR FROM created_at) AS created_year
FROM app_users;
