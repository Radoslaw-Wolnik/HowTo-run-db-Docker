// Run with:
// docker exec -i uni-neo4j cypher-shell -u neo4j -p uni_password < scripts/examples.cypher

// MATCH: paintings with their painters.
MATCH (painting:Painting)-[:PAINTED_BY]->(painter:Painter)
RETURN painting.title AS title, painter.name AS painter
ORDER BY title;

// SET: update a property.
MATCH (painting:Painting {title: 'Starry Night'})
SET painting.price = 120000000
RETURN painting.title, painting.price;

// CASE: derive a readable category.
MATCH (painter:Painter)
RETURN painter.name AS painter,
       CASE WHEN painter.birthYear < 1900 THEN 'Classical Era' ELSE 'Modern Era' END AS era;

// Aggregation: count paintings held by each museum.
MATCH (painting:Painting)-[:HELD_AT]->(museum:Museum)
RETURN museum.name AS museum, count(painting) AS paintings
ORDER BY paintings DESC;
