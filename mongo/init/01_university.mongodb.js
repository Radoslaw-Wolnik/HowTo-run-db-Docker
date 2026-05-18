// MongoDB document setup adapted from the course employee/team exercises.
// MongoDB is schemaless by default, but collection validators can enforce shape.

db = db.getSiblingDB("university");

db.createUser({
  user: "uni",
  pwd: "uni_password",
  roles: [{ role: "readWrite", db: "university" }]
});

db.teams.drop();
db.employees.drop();

db.createCollection("teams", {
  validator: {
    $jsonSchema: {
      bsonType: "object",
      required: ["team_id", "name", "street", "city"],
      properties: {
        team_id: { bsonType: "int" },
        name: { bsonType: "string" },
        street: { bsonType: "string" },
        city: { bsonType: "string" },
        description: { bsonType: "string" }
      }
    }
  }
});

db.createCollection("employees", {
  validator: {
    $jsonSchema: {
      bsonType: "object",
      required: ["employee_id", "last_name", "position", "hired_at", "salary", "team_id"],
      properties: {
        employee_id: { bsonType: "int" },
        last_name: { bsonType: "string" },
        position: { bsonType: "string" },
        manager_id: { bsonType: ["int", "null"] },
        hired_at: { bsonType: "date" },
        salary: { bsonType: ["int", "double", "decimal"] },
        bonus: { bsonType: ["int", "double", "decimal", "null"] },
        team_id: { bsonType: "int" }
      }
    }
  }
});

db.teams.insertMany([
  { team_id: 100, name: "Administracja", street: "Rzeczna 114", city: "Gdansk", description: "siedziba" },
  { team_id: 200, name: "Sztuczna inteligencja", street: "Mokra 6", city: "Gdynia" },
  { team_id: 300, name: "Algorytmy", street: "Alpejska 19", city: "Gdansk" },
  { team_id: 400, name: "Systemy operacyjne", street: "Woronicza 3a", city: "Warszawa" }
]);

db.employees.insertMany([
  { employee_id: 11, last_name: "Kowalski", position: "dyrektor", manager_id: null, hired_at: new Date("1989-03-12"), salary: 15000, bonus: 520.50, team_id: 100 },
  { employee_id: 12, last_name: "Nowak", position: "profesor", manager_id: 11, hired_at: new Date("1993-08-11"), salary: 9000, bonus: 310, team_id: 400 },
  { employee_id: 15, last_name: "Marzec", position: "asystent", manager_id: 12, hired_at: new Date("1999-12-06"), salary: 4480, team_id: 200 },
  { employee_id: 16, last_name: "Burczyk", position: "profesor", manager_id: 11, hired_at: new Date("1998-06-09"), salary: 8960, team_id: 200 },
  { employee_id: 17, last_name: "Kwiatkowski", position: "adiunkt", manager_id: 16, hired_at: new Date("1997-01-19"), salary: 6645.50, team_id: 200 }
]);

db.employees.createIndex({ team_id: 1 });
db.employees.createIndex({ position: 1 });
