# SQLite

SQLite is a relational SQL database stored as a single file. It uses schemas, tables, constraints, and SQL queries, but it does not run as a long-lived server process.

## Run

```powershell
docker compose run --rm sqlite
```

This creates `university.sqlite` in the folder. You can then open it:

```powershell
docker run --rm -it -v ${PWD}:/workspace -w /workspace keinos/sqlite3 sqlite3 university.sqlite
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

## Scripts

- `init/01_books.sql`: creates a small books and transactions database.
- `scripts/examples.sql`: filtering, joining, and grouping examples.
