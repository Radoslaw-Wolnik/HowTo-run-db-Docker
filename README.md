# HowTo-run-db-in-container

Small, course-inspired database playgrounds that run in normal Docker container mode.

The `temp-uni` folder was reviewed and the useful parts were distilled into clean examples. I kept representative schemas, seed data, query examples, and small client scripts, while leaving out repeated reports, generated dependencies, virtual environments, node modules, and bulky one-file dumps.

## Databases

| Folder | Database | Model | What is inside |
| --- | --- | --- | --- |
| `postgres/` | PostgreSQL | relational SQL schema | university teams/employees schema, seed data, queries, and a libpq example |
| `mongo/` | MongoDB | document database with optional JSON schema validation | university teams/employees collections and aggregation examples |
| `sqlserver/` | Microsoft SQL Server | relational SQL schema | simplified bird spotting schema with procedures/triggers examples |
| `neo4j/` | Neo4j | property graph, schema optional | painters, paintings, museums, constraints, and Cypher queries |
| `sqlite/` | SQLite | relational SQL schema in one file | small books/transactions database and query examples |
| `clickhouse/` | ClickHouse | columnar analytical tables | item price event table loaded from NDJSON |
| `oracle/` | Oracle XE | relational SQL schema | app user setup and basic user table with constraints |
| `redis/` | Redis | key-value / in-memory structures, no fixed schema | Python scripts for lists, sets, hashes, and atomic counters |

## Running

Each database folder has its own `README.md`. In most folders the basic pattern is:

```powershell
docker compose up -d
```

Some databases, such as SQL Server and Neo4j, need a follow-up script because their official containers do not automatically run every local teaching script in the same way as PostgreSQL or MongoDB.

## Notes From The Cleanup

- Docker Swarm material was removed; this repo now focuses on normal single-host containers.
- Coursework files were kept only when they make a good, reusable example.
- Scripts are split by purpose: schema/init files, seed data, and query examples.
- Comments were added to explain the database feature being demonstrated.
