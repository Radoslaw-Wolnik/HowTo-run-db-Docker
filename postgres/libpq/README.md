# libpq Example

`libpq` is PostgreSQL's C client library. It is not a separate database, so it lives under the PostgreSQL folder.

The original course folder had both single-file and modular C examples. This repo keeps one compact modular example that demonstrates the important part: connect, run a query, print rows, and clean up.

Compile on a machine that has PostgreSQL development headers installed:

```bash
cc sample_query.c -lpq -o sample_query
PG_CONNINFO="host=localhost port=5432 dbname=university user=uni password=uni_password" ./sample_query
```
