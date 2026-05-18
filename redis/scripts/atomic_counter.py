"""Redis INCR is atomic, so concurrent clients do not lose increments."""

from concurrent.futures import ThreadPoolExecutor

import redis


def increment_many(client: redis.Redis, times: int) -> None:
    for _ in range(times):
        client.incr("course:counter")


if __name__ == "__main__":
    redis_client = redis.Redis(host="localhost", port=6379, decode_responses=True)
    redis_client.set("course:counter", 0)

    with ThreadPoolExecutor(max_workers=10) as executor:
        for _ in range(10):
            executor.submit(increment_many, redis_client, 1000)

    print("Counter:", redis_client.get("course:counter"))
