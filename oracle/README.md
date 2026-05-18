# Oracle XE

Oracle XE is a relational SQL database with a strict schema. It uses users/schemas heavily: an Oracle user owns database objects such as tables, indexes, and procedures.

## Run

```powershell
copy .env.example .env
docker compose up -d
```

Connect:

```powershell
docker exec -it uni-oracle sqlplus app/uni_password@//localhost:1521/XEPDB1
```

## Most Used Words

- `ALTER SESSION SET CURRENT_SCHEMA`: choose the active schema.
- `NUMBER`, `VARCHAR2`, `TIMESTAMP`: common Oracle types.
- `GENERATED ALWAYS AS IDENTITY`: auto-generated id.
- `CONSTRAINT`: validation rule.
- `REGEXP_LIKE`: regex validation.
- `COMMIT`: persist transaction changes.

## Scripts

- `init-scripts/01_users.sql`: creates a small `app_users` table and seed data.
- `scripts/examples.sql`: basic reads and Oracle function examples.
