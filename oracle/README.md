# Oracle XE

Oracle XE is the free edition of Oracle Database. It is a relational SQL database with a strong schema/user model: a database user owns objects such as tables, indexes, views, and procedures.

This example creates an application user and a small `app_users` table with constraints.

## Type And Usage

- Type: relational OLTP database.
- Schema style: strict SQL schema owned by database users.
- Query language: Oracle SQL, with PL/SQL for procedural code.
- Best for: enterprise-style relational systems, strong schemas, stored logic, Oracle-compatible learning.
- Not ideal for: lightweight local-only apps, schemaless documents, or simple cache use cases.

## Run

```powershell
copy .env.example .env
docker compose up -d
```

Oracle can take a few minutes to initialize on the first run.

## Connect In Docker Terminal

```powershell
docker exec -it uni-oracle sqlplus app/uni_password@//localhost:1521/XEPDB1
```

Useful SQL*Plus commands:

```text
DESC app_users
SELECT table_name FROM user_tables;
EXIT
```

## Try A Transaction

```sql
INSERT INTO app_users (username, email, password_hash, age)
VALUES ('temp_user', 'temp@example.com', 'password789', 25);

SELECT username, email FROM app_users;
ROLLBACK;
```

Oracle transactions are committed explicitly with `COMMIT`; closing a session may also end the transaction depending on client behavior, so be deliberate while learning.

## Most Used Words

- `ALTER SESSION SET CURRENT_SCHEMA`: choose the active schema.
- `NUMBER`, `VARCHAR2`, `TIMESTAMP`: common Oracle types.
- `GENERATED ALWAYS AS IDENTITY`: auto-generated id.
- `CONSTRAINT`: validation rule.
- `REGEXP_LIKE`: regex validation.
- `COMMIT`, `ROLLBACK`: transaction control.
- `DESC`: SQL*Plus command to inspect table structure.

## Scripts

- `init-scripts/01_users.sql`: creates a small `app_users` table and seed data.
- `scripts/examples.sql`: basic reads and Oracle function examples.

Run the examples:

```powershell
docker exec -i uni-oracle sqlplus app/uni_password@//localhost:1521/XEPDB1 < scripts/examples.sql
```
