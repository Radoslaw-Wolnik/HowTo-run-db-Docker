// Neo4j property graph adapted from the course painter/museum exercise.
// Constraints are optional, but useful when a property should be unique.

CREATE CONSTRAINT painter_name IF NOT EXISTS
FOR (p:Painter) REQUIRE p.name IS UNIQUE;

CREATE CONSTRAINT museum_name IF NOT EXISTS
FOR (m:Museum) REQUIRE m.name IS UNIQUE;

CREATE CONSTRAINT painting_title IF NOT EXISTS
FOR (p:Painting) REQUIRE p.title IS UNIQUE;

MERGE (vanGogh:Painter {name: 'Van Gogh'})
  SET vanGogh.birthYear = 1853, vanGogh.nationality = 'Dutch'
MERGE (picasso:Painter {name: 'Picasso'})
  SET picasso.birthYear = 1881, picasso.nationality = 'Spanish'
MERGE (monet:Painter {name: 'Claude Monet'})
  SET monet.birthYear = 1840, monet.nationality = 'French';

MERGE (louvre:Museum {name: 'Louvre'})
  SET louvre.city = 'Paris', louvre.establishedYear = 1793
MERGE (moma:Museum {name: 'MOMA'})
  SET moma.city = 'New York', moma.establishedYear = 1929;

MERGE (starry:Painting {title: 'Starry Night'})
  SET starry.year = 1889, starry.style = 'Post-Impressionism', starry.price = 100000000
MERGE (demoiselles:Painting {title: 'Les Demoiselles d''Avignon'})
  SET demoiselles.year = 1907, demoiselles.style = 'Cubism', demoiselles.price = 200000000
MERGE (water:Painting {title: 'Water Lilies'})
  SET water.year = 1916, water.style = 'Impressionism', water.price = 150000000;

MERGE (starry)-[:PAINTED_BY]->(vanGogh);
MERGE (demoiselles)-[:PAINTED_BY]->(picasso);
MERGE (water)-[:PAINTED_BY]->(monet);
MERGE (starry)-[:HELD_AT]->(moma);
MERGE (demoiselles)-[:HELD_AT]->(moma);
MERGE (water)-[:HELD_AT]->(louvre);
