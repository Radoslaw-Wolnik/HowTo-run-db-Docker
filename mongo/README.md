# MongoDB

MongoDB is a document database. It stores JSON-like BSON documents inside collections. It is schema-optional: a collection can accept differently shaped documents, but validators can be added when you want stricter rules.

This example uses validators so the course employee/team data stays readable and predictable while still showing a document-database workflow.

## Type And Usage

- Type: document database.
- Schema style: optional, with JSON Schema validation available.
- Query language: MongoDB query documents and aggregation pipelines.
- Best for: nested records, flexible application data, rapidly changing models, document-oriented APIs.
- Not ideal for: heavy multi-table relational constraints, complex cross-document transactions as a default modeling style, or graph path traversal.

## Run

```powershell
copy .env.example .env
docker compose up -d
```

## Connect In Docker Terminal

```powershell
docker exec -it uni-mongo mongosh -u uni -p uni_password university
```

Useful `mongosh` commands:

```javascript
show collections
db.employees.findOne()
db.employees.find().pretty()
exit
```

## Try A Small Change

```javascript
db.employees.updateOne(
  { last_name: "Marzec" },
  { $set: { bonus: 250 } }
);

db.employees.find({ bonus: { $exists: true } }, { _id: 0, last_name: 1, bonus: 1 });
```

MongoDB supports transactions on replica sets, but for this teaching setup the examples focus on ordinary document operations and aggregation.

## Most Used Words

- `db.collection.find()`: query documents.
- `insertMany`: insert many documents.
- `updateOne`: update one document.
- `createCollection`: create a collection, optionally with validation.
- `$jsonSchema`: validation rules for document shape.
- `$lookup`: aggregation join between collections.
- `$match`: filter inside aggregation.
- `$project`: choose or rename output fields.
- `$group`: aggregate values.
- `createIndex`: speed up common queries.

## Scripts

- `init/01_university.mongodb.js`: creates the app user, validated collections, indexes, and seed data.
- `scripts/examples.mongodb.js`: filter, lookup, projection, and grouping examples.

Run the examples:

```powershell
docker exec -i uni-mongo mongosh -u uni -p uni_password university < scripts/examples.mongodb.js
```
