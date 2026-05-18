-- Run with:
-- docker run --rm -v ${PWD}:/workspace -w /workspace keinos/sqlite3 sqlite3 university.sqlite ".read scripts/examples.sql"

PRAGMA foreign_keys = ON;

-- Simple filtering.
SELECT id, author, name, price
FROM books
WHERE genre IN ('fantasy', 'scifi')
ORDER BY price DESC;

-- Join transactions to books.
SELECT t.id, b.name, t.quantity, ROUND(b.price * t.quantity, 2) AS total
FROM transactions t
JOIN books b ON b.id = t.book_id
ORDER BY t.id;

-- Aggregate inventory by genre.
SELECT genre, COUNT(*) AS titles, SUM(amount) AS copies
FROM books
GROUP BY genre
ORDER BY copies DESC;
