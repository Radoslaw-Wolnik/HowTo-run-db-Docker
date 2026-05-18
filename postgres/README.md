# PostgreSQL

PostgreSQL is a relational SQL database. It is schema-first: tables, columns, types, primary keys, foreign keys, checks, and indexes describe what valid data looks like before rows are inserted.

PostgreSQL is a good default database for many applications because it balances correctness, SQL power, indexing, transactions, JSON support, and operational maturity.

## Type And Usage

- Type: relational OLTP database.
- Schema style: strict SQL schema.
- Query language: SQL.
- Best for: web apps, internal tools, transactional systems, reports over normalized data, data that needs constraints.
- Not ideal for: pure in-memory caching, relationship path searches with many hops, or huge append-only analytics where a columnar database is better.

## Run

```powershell
copy .env.example .env
docker compose up -d
```

## Connect In Docker Terminal

```powershell
docker exec -it uni-postgres psql -U uni -d university
```

Useful `psql` commands:

```text
\dt          -- list tables
\d employees -- describe one table
\q           -- quit
```

## Try A Transaction

```sql
BEGIN;
UPDATE employees
SET bonus = COALESCE(bonus, 0) + 100
WHERE position = 'asystent';

SELECT last_name, bonus FROM employees WHERE position = 'asystent';
ROLLBACK;
```

Use `COMMIT` instead of `ROLLBACK` when you want to keep the changes.

## Most Used Words

- `CREATE TABLE`: defines schema.
- `PRIMARY KEY`: unique row identifier.
- `FOREIGN KEY`: relationship between tables.
- `CHECK`: validates allowed values.
- `INSERT`: adds rows.
- `SELECT`: reads rows.
- `JOIN`: combines tables.
- `GROUP BY`: aggregates rows by category.
- `BEGIN`, `COMMIT`, `ROLLBACK`: transaction control.
- `INDEX`: speeds up common filters and joins.

## Scripts

- `init/01_schema.sql`: creates `teams` and `employees` with constraints.
- `init/02_seed.sql`: inserts sample course-style data.
- `scripts/examples.sql`: joins, self-join, grouping, and transaction examples.
- `libpq/sample_query.c`: compact C client example using PostgreSQL's `libpq`.

Run the examples:

```powershell
docker exec -i uni-postgres psql -U uni -d university < scripts/examples.sql
```
