# Loads the Cypher init script into the running Neo4j container.

$ErrorActionPreference = "Stop"

docker cp ./init/01_art_graph.cypher uni-neo4j:/tmp/01_art_graph.cypher
docker exec uni-neo4j cypher-shell -u neo4j -p uni_password -f /tmp/01_art_graph.cypher
