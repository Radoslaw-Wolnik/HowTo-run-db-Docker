# Neo4j

Neo4j is a graph database. It stores nodes, relationships, labels, and properties. A schema is optional, but constraints and indexes can be added for important properties.

## Run

```powershell
docker compose up -d
.\scripts\load.ps1
```

Neo4j Browser:

```text
http://localhost:7474
user: neo4j
password: uni_password
```

## Most Used Words

- `MATCH`: find graph patterns.
- `CREATE`: create nodes/relationships.
- `MERGE`: create if missing, otherwise reuse.
- `SET`: update properties.
- `RETURN`: output values.
- `DETACH DELETE`: remove a node and its relationships.
- `CONSTRAINT`: enforce uniqueness/existence.
- `count`: aggregate results.

## Scripts

- `init/01_art_graph.cypher`: constraints and painter/museum/painting graph.
- `scripts/load.ps1`: loads the graph into the running container.
- `scripts/examples.cypher`: common Cypher operations from the course notes.
