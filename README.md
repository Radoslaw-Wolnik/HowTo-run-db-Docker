# HowTo-run-db-in-container

Small, course-inspired database playgrounds that run in normal Docker container mode. The repo is meant for learning how different databases feel in practice: how they model data, how you connect to them, and what kind of commands you use once the container is running.

The raw `temp-uni` folder was used as source material. The curated folders keep representative schemas, seed data, client scripts, transactions, joins, graph queries, document queries, and analytical examples without the repeated coursework dump files.

## Quick Start

Each database folder is independent. Enter one folder, create a local `.env` from the example, then start Docker Compose:

```powershell
cd postgres
copy .env.example .env
docker compose up -d
```

The same pattern works for `mongo`, `sqlserver`, `neo4j`, `sqlite`, `clickhouse`, `oracle`, and `redis`.

## Databases In This Repo

| Folder | Database | Type | Best For |
| --- | --- | --- | --- |
| `postgres/` | PostgreSQL | relational OLTP SQL | application data, constraints, joins, transactions, reporting queries |
| `mongo/` | MongoDB | document database | flexible JSON-like documents, nested data, evolving schemas |
| `sqlserver/` | Microsoft SQL Server | relational OLTP SQL | enterprise apps, stored procedures, triggers, BI integrations |
| `neo4j/` | Neo4j | property graph | highly connected data, paths, relationships, recommendations |
| `sqlite/` | SQLite | embedded relational SQL | local apps, small tools, test fixtures, simple file-based databases |
| `clickhouse/` | ClickHouse | columnar analytical SQL | event data, metrics, large aggregations, fast analytical scans |
| `oracle/` | Oracle XE | relational OLTP SQL | enterprise-style schemas, users, constraints, PL/SQL-oriented workflows |
| `redis/` | Redis | in-memory key-value / data structures | cache, counters, queues, sessions, locks, fast ephemeral state |

## Connecting From Docker Terminal

Run these from the database folder after `docker compose up -d`.

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

If you change values in `.env`, use your changed username/password/database in the commands above.

## What To Try

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

Every database folder has a `.env.example`. Copy it to `.env` before starting the container. The `.env` file is ignored by git, so local credentials stay out of commits.

These examples are intentionally simple teaching credentials. For anything outside local learning, change them.

## Cleanup

Stop a database:

```powershell
docker compose down
```

Remove the database volume too:

```powershell
docker compose down -v
```

Using `-v` deletes the stored data for that database, which is useful when you want init scripts to run from a clean state again.

## Notes From The Cleanup

- Docker Swarm material was removed; this repo now focuses on normal single-host containers.
- Scripts are split by purpose: schema/init files, seed data, and query examples.
- Each database README explains whether the database is schema-first, schema-optional, or schemaless.
- Screenshots are not included because the most useful workflow here is terminal-based and copyable.
