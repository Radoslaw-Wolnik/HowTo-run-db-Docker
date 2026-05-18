-- Run with:
-- docker exec -i uni-clickhouse clickhouse-client < scripts/examples.sql

-- Read all rows in event order.
SELECT id, name, price, timestamp
FROM university.items
ORDER BY timestamp;

-- Analytical aggregation.
SELECT
    toDate(timestamp) AS day,
    count() AS events,
    min(price) AS min_price,
    max(price) AS max_price,
    avg(price) AS avg_price
FROM university.items
GROUP BY day;

-- Bucket values into price bands.
SELECT
    multiIf(price < 20, 'cheap', price < 40, 'medium', 'expensive') AS price_band,
    count() AS items
FROM university.items
GROUP BY price_band
ORDER BY items DESC;
