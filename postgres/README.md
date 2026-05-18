# PostgreSQL

PostgreSQL is a relational SQL database with a strict schema. Tables define columns, types, constraints, keys, and relationships before data is inserted.

## Run

```powershell
docker compose up -d
docker exec -it uni-postgres psql -U uni -d university
```

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

## Scripts

- `init/01_schema.sql`: creates `teams` and `employees`.
- `init/02_seed.sql`: inserts sample course-style data.
- `scripts/examples.sql`: join, self-join, grouping, and transaction examples.
- `libpq/sample_query.c`: compact C client example using PostgreSQL's `libpq`.
