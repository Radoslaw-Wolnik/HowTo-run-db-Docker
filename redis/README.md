# Redis

Redis is an in-memory key-value database. It does not use a fixed schema. The "shape" is chosen by key naming and data type: strings, lists, sets, hashes, sorted sets, streams, and more.

## Run

```powershell
docker compose up -d
docker exec -it uni-redis redis-cli
```

Python examples:

```powershell
pip install -r requirements.txt
python scripts/datatypes.py
python scripts/atomic_counter.py
```

## Most Used Words

- `GET`, `SET`: string keys.
- `LPUSH`, `LRANGE`: lists.
- `SADD`, `SMEMBERS`: sets.
- `HSET`, `HGETALL`: hashes.
- `INCR`: atomic integer increment.
- `DEL`: remove keys.
- `EXPIRE`: set time-to-live.

## Scripts

- `scripts/datatypes.py`: examples for lists, sets, and hashes.
- `scripts/atomic_counter.py`: concurrent counter using atomic `INCR`.
