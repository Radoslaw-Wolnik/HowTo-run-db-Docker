# MongoDB

MongoDB is a document database. It does not require a fixed schema, but this setup uses JSON Schema validators to show how course data can still be checked.

## Run

```powershell
docker compose up -d
docker exec -it uni-mongo mongosh -u uni -p uni_password university
```

## Most Used Words

- `db.collection.find()`: query documents.
- `insertMany`: insert many documents.
- `createCollection`: create a collection, optionally with validation.
- `$jsonSchema`: validation rules for document shape.
- `$lookup`: aggregation join between collections.
- `$match`: filter inside aggregation.
- `$project`: choose/rename output fields.
- `$group`: aggregate values.
- `createIndex`: speed up common queries.

## Scripts

- `init/01_university.mongodb.js`: creates the database user, validated collections, indexes, and seed data.
- `scripts/examples.mongodb.js`: filter, lookup, projection, and grouping examples.
