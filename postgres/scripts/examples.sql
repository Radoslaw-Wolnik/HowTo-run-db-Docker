-- Run with:
-- docker exec -i uni-postgres psql -U uni -d university < scripts/examples.sql

-- INNER JOIN: show employees with their team names.
SELECT e.employee_id, e.last_name, e.position, t.name AS team
FROM employees e
JOIN teams t ON t.team_id = e.team_id
ORDER BY e.employee_id;

-- Self join: show each employee and their manager.
SELECT e.last_name AS employee, m.last_name AS manager
FROM employees e
LEFT JOIN employees m ON m.employee_id = e.manager_id
ORDER BY employee;

-- GROUP BY: average salary by team.
SELECT t.name AS team, ROUND(AVG(e.salary), 2) AS average_salary
FROM teams t
JOIN employees e ON e.team_id = t.team_id
GROUP BY t.name
ORDER BY average_salary DESC;

-- Transaction example: update, inspect, then roll back.
BEGIN;
UPDATE employees
SET bonus = COALESCE(bonus, 0) + 100
WHERE position = 'asystent';
SELECT last_name, bonus FROM employees WHERE position = 'asystent';
ROLLBACK;
