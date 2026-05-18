# ClickHouse

ClickHouse is a column-oriented analytical SQL database. It has schemas and tables, but it stores data by columns and is optimized for scanning, grouping, and aggregating large datasets very quickly.

This example loads a tiny NDJSON event dataset into a `MergeTree` table so the basic analytical workflow is easy to see.

## Type And Usage

- Type: columnar analytical database.
- Schema style: typed SQL tables.
- Query language: ClickHouse SQL.
- Best for: event logs, metrics, dashboards, time-series-like analytics, large `GROUP BY` queries.
- Not ideal for: row-by-row transactional application data, foreign-key-heavy schemas, or frequent single-row updates.

## Run

```powershell
copy .env.example .env
docker compose up -d
```

## Connect In Docker Terminal

```powershell
docker exec -it uni-clickhouse clickhouse-client -u uni --password uni_password -d university
```

## Try An Analytical Query

```sql
SELECT
    toDate(timestamp) AS day,
    count() AS events,
    avg(price) AS avg_price
FROM items
GROUP BY day;
```

ClickHouse is usually used by appending lots of rows and then reading aggregates very quickly.

## Most Used Words

- `MergeTree`: common ClickHouse table engine.
- `ORDER BY`: storage and primary sorting key.
- `JSONEachRow`: line-delimited JSON input format.
- `toDate`: convert timestamps for grouping.
- `count`, `min`, `max`, `avg`: analytical aggregates.
- `multiIf`: conditional expression.
- `PARTITION BY`: optional storage partitioning for large tables.

## Scripts

- `data/items.ndjson`: small course-style item event dataset.
- `init/01_items.sql`: creates the table and loads NDJSON.
- `scripts/examples.sql`: event reads, daily aggregation, and price bucketing.

Run the examples:

```powershell
docker exec -i uni-clickhouse clickhouse-client -u uni --password uni_password -d university < scripts/examples.sql
```
