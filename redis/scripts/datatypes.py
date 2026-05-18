"""Small Redis data structure examples from the course notes.

Run:
    pip install redis
    python scripts/datatypes.py
"""

import redis


def connect() -> redis.Redis:
    """Create a Redis client using the local Docker container defaults."""
    return redis.Redis(host="localhost", port=6379, decode_responses=True)


def demo_lists(client: redis.Redis) -> None:
    """Lists keep ordered values and are useful for queues/stacks."""
    client.delete("course:list")
    client.lpush("course:list", "element1", "element2", "element3")
    print("List:", client.lrange("course:list", 0, -1))


def demo_sets(client: redis.Redis) -> None:
    """Sets keep unique values and make membership checks cheap."""
    client.delete("course:set")
    client.sadd("course:set", "member1", "member2", "member3", "member1")
    print("Set:", sorted(client.smembers("course:set")))


def demo_hashes(client: redis.Redis) -> None:
    """Hashes store small field/value maps under one Redis key."""
    client.delete("course:hash")
    client.hset("course:hash", mapping={"key1": "value1", "key2": "value2"})
    print("Hash:", client.hgetall("course:hash"))


if __name__ == "__main__":
    redis_client = connect()
    demo_lists(redis_client)
    demo_sets(redis_client)
    demo_hashes(redis_client)
