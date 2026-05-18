# SQLite

SQLite is an embedded relational SQL database. It stores the whole database in a local file instead of running as a separate server. It is schema-first like other relational databases, but much simpler to run.

This example creates a `university.sqlite` file with books and transactions.

## Type And Usage

- Type: embedded relational database.
- Schema style: SQL tables in a local file.
- Query language: SQL.
- Best for: small local apps, prototypes, desktop tools, mobile apps, tests, data files that need SQL.
- Not ideal for: many concurrent writers, large client/server deployments, or networked multi-user database servers.

## Run

```powershell
copy .env.example .env
docker compose run --rm sqlite
```

This creates `university.sqlite` in the folder.

## Connect In Docker Terminal

```powershell
docker run --rm -it -v ${PWD}:/workspace -w /workspace keinos/sqlite3 sqlite3 university.sqlite
```

Useful SQLite shell commands:

```text
.tables
.schema books
.quit
```

## Try A Transaction

```sql
BEGIN;
INSERT INTO transactions (book_id, quantity) VALUES (1, 1);
SELECT * FROM transactions;
ROLLBACK;
```

## Most Used Words

- `PRAGMA foreign_keys = ON`: enables foreign key enforcement.
- `CREATE TABLE`: defines schema.
- `INTEGER PRIMARY KEY`: row identifier.
- `CHECK`: simple validation.
- `INSERT`: add rows.
- `SELECT`: query rows.
- `JOIN`: combine tables.
- `GROUP BY`: aggregate rows.
- `.schema`: SQLite shell command to inspect table definitions.

## Scripts

- `init/01_books.sql`: creates a small books and transactions database.
- `scripts/examples.sql`: filtering, joining, and grouping examples.

Run the examples:

```powershell
docker run --rm -v ${PWD}:/workspace -w /workspace keinos/sqlite3 sqlite3 university.sqlite ".read scripts/examples.sql"
```
