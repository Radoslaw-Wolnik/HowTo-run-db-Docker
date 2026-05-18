-- ClickHouse is column-oriented and optimized for analytical reads.
-- MergeTree tables need an ORDER BY expression for storage/index layout.

CREATE DATABASE IF NOT EXISTS university;

CREATE TABLE IF NOT EXISTS university.items
(
    id UInt32,
    name String,
    price Decimal(10, 2),
    timestamp DateTime
)
ENGINE = MergeTree
ORDER BY (timestamp, id);

INSERT INTO university.items
SELECT
    id,
    name,
    toDecimal64(price, 2) AS price,
    parseDateTimeBestEffort(timestamp) AS timestamp
FROM file('course-data/items.ndjson', 'JSONEachRow');
