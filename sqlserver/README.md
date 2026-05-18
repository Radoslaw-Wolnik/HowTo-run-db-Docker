# Microsoft SQL Server

SQL Server is a relational SQL database with a strict schema. This example is distilled from the course bird spotting project: users create bird posts, posts have places and likes, and moderators can flag posts.

## Run

```powershell
docker compose up -d
.\scripts\init-db.ps1
```

Connect:

```powershell
docker exec -it uni-sqlserver /opt/mssql-tools18/bin/sqlcmd -S localhost -U sa -P Uni_Strong_Password_123 -C -d BirdCourse
```

## Most Used Words

- `GO`: SQL Server batch separator.
- `IDENTITY`: auto-incrementing number.
- `UNIQUEIDENTIFIER`: UUID type.
- `CHECK`: allowed values.
- `CREATE OR ALTER FUNCTION`: reusable scalar/table logic.
- `CREATE OR ALTER PROCEDURE`: named operation.
- `TRIGGER`: automatic action after table changes.
- `GETDATE()`: current timestamp.

## Scripts

- `init/01_schema.sql`: compact bird spotting schema.
- `init/02_seed.sql`: example users, profiles, birds, posts, and likes.
- `init/03_routines.sql`: one function, one trigger, one procedure.
- `scripts/init-db.ps1`: applies init SQL to the running container.
- `scripts/examples.sql`: joins, computed like count, and procedure call.
