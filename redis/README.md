# Redis

Redis is an in-memory key-value database with rich data structures. It does not use a fixed schema. The shape of data is decided by key names, values, and data types such as strings, lists, sets, hashes, sorted sets, and streams.

This example keeps Redis password-protected and includes Python scripts for common data types and atomic counters.

## Type And Usage

- Type: in-memory key-value and data-structure server.
- Schema style: schemaless.
- Query language: Redis commands.
- Best for: cache, sessions, counters, queues, rate limits, leaderboards, locks, short-lived state.
- Not ideal for: relational joins, durable primary records without careful persistence planning, ad hoc analytical querying.

## Run

```powershell
copy .env.example .env
docker compose up -d
```

## Connect In Docker Terminal

```powershell
docker exec -it uni-redis redis-cli -a uni_password
```

Useful commands:

```text
PING
KEYS course:*
TYPE course:counter
QUIT
```

## Try Common Operations

```text
SET course:status running
GET course:status
INCR course:visits
LPUSH course:queue first second
LRANGE course:queue 0 -1
```

Redis commands are atomic per command, which is why `INCR` is safe for counters even when many clients call it at the same time.

## Most Used Words

- `GET`, `SET`: string keys.
- `LPUSH`, `LRANGE`: lists.
- `SADD`, `SMEMBERS`: sets.
- `HSET`, `HGETALL`: hashes.
- `INCR`: atomic integer increment.
- `DEL`: remove keys.
- `EXPIRE`: set time-to-live.
- `TTL`: inspect remaining time-to-live.

## Scripts

- `scripts/datatypes.py`: examples for lists, sets, and hashes.
- `scripts/atomic_counter.py`: concurrent counter using atomic `INCR`.

Run Python examples:

```powershell
pip install -r requirements.txt
$env:REDIS_PASSWORD="uni_password"
python scripts/datatypes.py
python scripts/atomic_counter.py
```
