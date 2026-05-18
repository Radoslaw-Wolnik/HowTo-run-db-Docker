# Microsoft SQL Server

SQL Server is a relational SQL database used heavily in enterprise and Microsoft-oriented environments. It is schema-first and supports constraints, stored procedures, triggers, functions, transactions, and a large operational tooling ecosystem.

This example is distilled from the course bird spotting project: users create posts, posts reference birds and places, users like posts, and moderation can flag content.

## Type And Usage

- Type: relational OLTP database.
- Schema style: strict SQL schema.
- Query language: T-SQL.
- Best for: enterprise applications, stored procedure-heavy systems, reporting with Microsoft tooling, transactional business systems.
- Not ideal for: lightweight embedded apps, purely schemaless data, or graph-first traversal.

## Run

```powershell
copy .env.example .env
docker compose up -d
.\scripts\init-db.ps1
```

SQL Server containers take a little while to become ready. The init script waits, copies the SQL files into the container, and runs them with `sqlcmd`.

## Connect In Docker Terminal

```powershell
docker exec -it uni-sqlserver /opt/mssql-tools18/bin/sqlcmd -S localhost -U sa -P Uni_Strong_Password_123 -C -d BirdCourse
```

Useful `sqlcmd` notes:

```text
GO      -- execute the current batch
QUIT    -- leave sqlcmd
```

## Try A Transaction

```sql
BEGIN TRANSACTION;
UPDATE posts SET description = 'Updated in a test transaction' WHERE id = 1;
SELECT id, description FROM posts WHERE id = 1;
ROLLBACK;
GO
```

## Most Used Words

- `GO`: SQL Server batch separator.
- `IDENTITY`: auto-incrementing number.
- `UNIQUEIDENTIFIER`: UUID type.
- `CHECK`: allowed values.
- `CREATE OR ALTER FUNCTION`: reusable scalar or table logic.
- `CREATE OR ALTER PROCEDURE`: named operation.
- `TRIGGER`: automatic action after table changes.
- `GETDATE()`: current timestamp.
- `BEGIN TRANSACTION`, `COMMIT`, `ROLLBACK`: transaction control.

## Scripts

- `init/01_schema.sql`: compact bird spotting schema.
- `init/02_seed.sql`: example users, profiles, birds, posts, and likes.
- `init/03_routines.sql`: one function, one trigger, one procedure.
- `scripts/init-db.ps1`: applies init SQL to the running container.
- `scripts/examples.sql`: joins, computed like count, and procedure call.

Run the examples:

```powershell
docker cp .\scripts\examples.sql uni-sqlserver:/tmp/examples.sql
docker exec -it uni-sqlserver /opt/mssql-tools18/bin/sqlcmd -S localhost -U sa -P Uni_Strong_Password_123 -C -d BirdCourse -i /tmp/examples.sql
```
