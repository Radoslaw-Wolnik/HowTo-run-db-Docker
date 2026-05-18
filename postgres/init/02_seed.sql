-- Seed data kept small enough to understand, but varied enough for joins,
-- self-references, grouping, checks, and filtering.

INSERT INTO teams (team_id, name, street, city, description) VALUES
    (100, 'Administracja', 'Rzeczna 114', 'Gdansk', 'siedziba'),
    (200, 'Sztuczna inteligencja', 'Mokra 6', 'Gdynia', NULL),
    (300, 'Algorytmy', 'Alpejska 19', 'Gdansk', NULL),
    (400, 'Systemy operacyjne', 'Woronicza 3a', 'Warszawa', NULL),
    (500, 'Inzynieria oprogramowania', 'Fiolkowa 30', 'Krakow', NULL);

INSERT INTO employees (employee_id, last_name, position, manager_id, hired_at, salary, bonus, team_id) VALUES
    (11, 'Kowalski', 'dyrektor', NULL, '1989-03-12', 15000, 520.50, 100),
    (12, 'Nowak', 'profesor', 11, '1993-08-11', 9000, 310, 400),
    (13, 'Cicha', 'sekretarka', 11, '2000-12-20', 4000.20, NULL, 100),
    (14, 'Misiak', 'profesor', 11, '1997-05-06', 10500, NULL, 300),
    (15, 'Marzec', 'asystent', 12, '1999-12-06', 4480, NULL, 200),
    (16, 'Burczyk', 'profesor', 11, '1998-06-09', 8960, NULL, 200),
    (17, 'Kwiatkowski', 'adiunkt', 16, '1997-01-19', 6645.50, NULL, 200),
    (18, 'Wajda', 'adiunkt', 16, '1995-04-02', 6590, NULL, 200),
    (20, 'Mroz', 'profesor', 16, '1995-03-17', 8830, 405, 200);
