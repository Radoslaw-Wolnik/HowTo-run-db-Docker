-- SQLite is a relational SQL database stored in a local file.
-- This script is idempotent so it can be re-run while learning.

PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS transactions;
DROP TABLE IF EXISTS books;

CREATE TABLE books (
    id INTEGER PRIMARY KEY,
    author TEXT NOT NULL,
    name TEXT NOT NULL,
    genre TEXT NOT NULL CHECK (genre IN ('fantasy', 'scifi', 'novel', 'old')),
    price REAL NOT NULL CHECK (price >= 0),
    amount INTEGER NOT NULL CHECK (amount >= 0)
);

CREATE TABLE transactions (
    id INTEGER PRIMARY KEY,
    book_id INTEGER NOT NULL,
    quantity INTEGER NOT NULL CHECK (quantity > 0),
    sold_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (book_id) REFERENCES books(id)
);

INSERT INTO books (id, author, name, genre, price, amount) VALUES
    (1, 'J.K. Rowling', 'Harry Potter and the Sorcerer''s Stone', 'fantasy', 20, 200),
    (2, 'J.R.R. Tolkien', 'The Hobbit', 'fantasy', 15, 150),
    (3, 'George Orwell', '1984', 'novel', 18, 180),
    (4, 'Isaac Asimov', 'Foundation', 'scifi', 25, 80),
    (5, 'Ray Bradbury', 'Fahrenheit 451', 'scifi', 18, 120);

INSERT INTO transactions (id, book_id, quantity, sold_at) VALUES
    (1, 1, 2, '2024-12-14 12:00:00'),
    (2, 2, 1, '2024-12-14 12:05:00'),
    (3, 4, 3, '2024-12-14 12:10:00');
