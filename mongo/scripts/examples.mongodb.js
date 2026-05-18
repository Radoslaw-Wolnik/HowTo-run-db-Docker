// Run with:
// docker exec -i uni-mongo mongosh -u uni -p uni_password university < scripts/examples.mongodb.js

// Find: filter and project selected fields.
db.employees.find(
  { position: { $ne: "asystent" }, team_id: { $in: [200, 300] } },
  { _id: 0, last_name: 1, position: 1, team_id: 1 }
);

// Aggregation: join employees with teams using $lookup.
db.employees.aggregate([
  {
    $lookup: {
      from: "teams",
      localField: "team_id",
      foreignField: "team_id",
      as: "team"
    }
  },
  { $unwind: "$team" },
  { $match: { "team.street": /Mokra/ } },
  { $project: { _id: 0, employee_id: 1, last_name: 1, team: "$team.name" } },
  { $sort: { last_name: 1 } }
]);

// Grouping: average salary by position.
db.employees.aggregate([
  {
    $group: {
      _id: "$position",
      employees: { $sum: 1 },
      average_salary: { $avg: "$salary" }
    }
  },
  { $sort: { average_salary: -1 } }
]);
