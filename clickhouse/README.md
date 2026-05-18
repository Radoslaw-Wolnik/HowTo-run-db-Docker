# ClickHouse

ClickHouse is an analytical, column-oriented SQL database. It has schemas and tables, but it is tuned for scanning, grouping, and aggregating large datasets rather than transaction-heavy application workloads.

## Run

```powershell
docker compose up -d
docker exec -it uni-clickhouse clickhouse-client
```

## Most Used Words

- `MergeTree`: common ClickHouse table engine.
- `ORDER BY`: storage and primary sorting key.
- `JSONEachRow`: line-delimited JSON input format.
- `toDate`: convert timestamps for grouping.
- `count`, `min`, `max`, `avg`: analytical aggregates.
- `multiIf`: conditional expression.

## Scripts

- `data/items.ndjson`: small course-style item event dataset.
- `init/01_items.sql`: creates the table and loads NDJSON.
- `scripts/examples.sql`: event reads, daily aggregation, and price bucketing.
