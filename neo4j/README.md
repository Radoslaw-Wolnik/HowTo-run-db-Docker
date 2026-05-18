# Neo4j

Neo4j is a property graph database. Data is modeled as nodes and relationships, both of which can hold properties. It is schema-optional, but constraints and indexes can be added for important labels and properties.

This example uses painters, paintings, and museums because that kind of data is naturally relationship-focused: paintings are painted by painters and held at museums.

## Type And Usage

- Type: graph database.
- Schema style: optional labels/properties, with constraints available.
- Query language: Cypher.
- Best for: relationship traversal, path finding, recommendations, dependency maps, fraud rings, knowledge graphs.
- Not ideal for: simple tabular reporting, high-volume append-only analytics, or workloads that mainly need cache-like key lookup.

## Run

```powershell
copy .env.example .env
docker compose up -d
.\scripts\load.ps1
```

Neo4j Browser is also available at:

```text
http://localhost:7474
user: neo4j
password: uni_password
```

## Connect In Docker Terminal

```powershell
docker exec -it uni-neo4j cypher-shell -u neo4j -p uni_password
```

## Try A Graph Query

```cypher
MATCH (painting:Painting)-[:PAINTED_BY]->(painter:Painter),
      (painting)-[:HELD_AT]->(museum:Museum)
RETURN painting.title, painter.name, museum.name;
```

Delete safely while learning:

```cypher
MATCH (p:Painting {title: 'Water Lilies'})
DETACH DELETE p;
```

`DETACH DELETE` removes the node and its relationships.

## Most Used Words

- `MATCH`: find graph patterns.
- `CREATE`: create nodes or relationships.
- `MERGE`: create if missing, otherwise reuse.
- `SET`: update properties.
- `RETURN`: output values.
- `DETACH DELETE`: remove a node and its relationships.
- `CONSTRAINT`: enforce uniqueness or existence.
- `count`: aggregate results.

## Scripts

- `init/01_art_graph.cypher`: constraints and painter/museum/painting graph.
- `scripts/load.ps1`: loads the graph into the running container.
- `scripts/examples.cypher`: common Cypher operations from the course notes.

Run the examples:

```powershell
docker exec -i uni-neo4j cypher-shell -u neo4j -p uni_password < scripts/examples.cypher
```
