# HowTo-run-db-in-container

A beginner-friendly tutorial for running database servers in Docker instead of installing them locally.

At university, database servers are often installed directly on lab machines. That works, but it can be slow to reproduce on your own computer and annoying to clean up later.

This repository shows a faster alternative: run the database in a Docker container, connect to it from the terminal or your favorite database client, and remove or rebuild it whenever you are done.

The examples are based on database work from a university course. The raw course files were reviewed and reduced into smaller, cleaner playgrounds with representative schemas, seed data, client scripts, transactions, joins, graph queries, document queries, and analytical examples.

## Why Use Docker For Databases?

- No local database server installation needed
- Faster setup when you want to test or learn something
- Easy reset by removing the container volume
- Reproducible environment for everyone using the repository
- Keeps different database engines isolated from each other
- Works well for learning, labs, short-term projects, and experiments

## Requirements

Before you start, make sure you have:

- Docker
- Docker Compose
- A terminal
- A database client, if you want a GUI

Suggested GUI clients:

- pgAdmin, DBeaver, or DataGrip for PostgreSQL
- MongoDB Compass for MongoDB
- Azure Data Studio or SQL Server Management Studio for SQL Server
- Neo4j Browser for Neo4j
- DB Browser for SQLite
- DBeaver or ClickHouse-compatible clients for ClickHouse
- Oracle SQL Developer for Oracle
- Redis Insight for Redis

You can also use only the terminal commands shown in this README and in each database folder.

## What Is In This Repository?

Each folder is one self-contained database example. Every database folder includes a `README.md`, a `docker-compose.yml`, an `.env.example`, and a small set of scripts or initialization files.

| Folder | Database | Type | What It Teaches |
| --- | --- | --- | --- |
| `postgres/` | PostgreSQL | relational SQL | tables, constraints, joins, transactions, and a small `libpq` C client |
| `mongo/` | MongoDB | document database | collections, JSON schema validation, document queries, and aggregation |
| `sqlserver/` | Microsoft SQL Server | relational SQL | T-SQL schema, stored procedures, functions, triggers, and transactions |
| `neo4j/` | Neo4j | property graph | nodes, relationships, constraints, and Cypher traversal |
| `sqlite/` | SQLite | embedded relational SQL | local file database, tables, joins, and simple transactions |
| `clickhouse/` | ClickHouse | columnar analytical SQL | event-style data, NDJSON loading, and analytical aggregation |
| `oracle/` | Oracle XE | relational SQL | users/schemas, constraints, SQL*Plus connection, and transactions |
| `redis/` | Redis | key-value / data structures | strings, lists, sets, hashes, and atomic counters |

## Project Structure

Most folders follow the same shape:

```text
database-name/
  .env.example          # example credentials and settings
  docker-compose.yml    # container setup
  README.md             # database-specific explanation
  init/                 # schema and seed files, when supported by the image
  scripts/              # example queries or helper scripts
```

Some databases use slightly different names, for example Oracle uses `init-scripts/` because that is what its Docker image expects.

## Quick Start

Go into the database folder you want to try, copy the environment example, then start Docker Compose.

```powershell
cd postgres
copy .env.example .env
docker compose up -d
```

On Linux/macOS, use:

```bash
cp .env.example .env
docker compose up -d
```

The same idea works for `mongo`, `sqlserver`, `neo4j`, `sqlite`, `clickhouse`, `oracle`, and `redis`.

For SQL Server and Neo4j, run the extra load/init script mentioned in their folder README after the container starts.

## Connecting From Docker Terminal

Run these from the matching database folder after `docker compose up -d`.

```powershell
# PostgreSQL
docker exec -it uni-postgres psql -U uni -d university

# MongoDB
docker exec -it uni-mongo mongosh -u uni -p uni_password university

# SQL Server
docker exec -it uni-sqlserver /opt/mssql-tools18/bin/sqlcmd -S localhost -U sa -P Uni_Strong_Password_123 -C -d BirdCourse

# Neo4j
docker exec -it uni-neo4j cypher-shell -u neo4j -p uni_password

# SQLite
docker compose run --rm sqlite
docker run --rm -it -v ${PWD}:/workspace -w /workspace keinos/sqlite3 sqlite3 university.sqlite

# ClickHouse
docker exec -it uni-clickhouse clickhouse-client -u uni --password uni_password -d university

# Oracle XE
docker exec -it uni-oracle sqlplus app/uni_password@//localhost:1521/XEPDB1

# Redis
docker exec -it uni-redis redis-cli -a uni_password
```

If you change values in `.env`, use your changed username, password, and database name in the commands above.

## What To Try First

Relational databases are good places to practice transactions:

```sql
BEGIN;
UPDATE employees SET salary = salary + 100 WHERE position = 'asystent';
SELECT last_name, salary FROM employees WHERE position = 'asystent';
ROLLBACK;
```

MongoDB is good for document filters and aggregation pipelines:

```javascript
db.employees.find({ position: "profesor" });
db.employees.aggregate([{ $group: { _id: "$team_id", avgSalary: { $avg: "$salary" } } }]);
```

Neo4j is good for relationship traversal:

```cypher
MATCH (painting:Painting)-[:PAINTED_BY]->(painter:Painter)
RETURN painting.title, painter.name;
```

Redis is good for fast state operations:

```text
SET course:status running
INCR course:visits
GET course:visits
```

## Environment Files

Every database folder has a `.env.example`. Copy it to `.env` before starting the container.

The `.env` file is ignored by git, so local credentials stay out of commits. The included credentials are intentionally simple teaching values. Change them if you use this outside local learning.

## Resetting A Database

Stop a database:

```powershell
docker compose down
```

Remove the database volume too:

```powershell
docker compose down -v
```

Deleting the volume removes stored data. This is useful when you want the initialization scripts to run again from a clean state.

## Notes

- Docker Swarm material was removed; this repository uses normal single-container Docker Compose examples.
- Data is usually stored in Docker volumes, so deleting only the container does not necessarily delete the database files.
- Each database folder explains whether that database is schema-first, schema-optional, or schemaless.
- The examples are for learning, not production hardening.

## License

MIT
