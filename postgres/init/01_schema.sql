-- Relational schema adapted from the university employee/team exercises.
-- PostgreSQL enforces table shape, primary keys, foreign keys, and checks.

CREATE TABLE teams (
    team_id INTEGER PRIMARY KEY,
    name TEXT NOT NULL UNIQUE,
    street TEXT NOT NULL,
    city TEXT NOT NULL,
    description TEXT
);

CREATE TABLE employees (
    employee_id INTEGER PRIMARY KEY,
    last_name TEXT NOT NULL,
    position TEXT NOT NULL CHECK (position IN ('dyrektor', 'profesor', 'asystent', 'sekretarka', 'stazysta', 'adiunkt')),
    manager_id INTEGER REFERENCES employees(employee_id),
    hired_at DATE NOT NULL,
    salary NUMERIC(10, 2) NOT NULL CHECK (salary > 0),
    bonus NUMERIC(10, 2),
    team_id INTEGER NOT NULL REFERENCES teams(team_id)
);

CREATE INDEX employees_team_id_idx ON employees(team_id);
CREATE INDEX employees_position_idx ON employees(position);
