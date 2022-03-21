// models/users.js
const db = require('../services/db');

// GET all users
async function getAllUsers() {

  const results = await db.query(
    `SELECT id, firstname, lastname, email
    FROM users
    ORDER BY lastname ASC;`
  );

  return results;
}

// GET one user by Id
async function getUserById(id_user) {

  const results = await db.query(
    `SELECT id, firstname, lastname, email
    FROM users
    WHERE id = ?;`,
    [id_user]
  );

  return results[0];

}

// GET one user by Email
async function getUserByEmail(email) {

  const results = await db.query(
    `SELECT id, password
    FROM users
    WHERE email = ?;`,
    [email]
  );

  return results[0];

}

// POST one user
async function addOneUser(firstname, lastname, email, password) {

  await db.query(
    `INSERT INTO users (firstname, lastname, email, password)
    VALUES (?, ?, ?, ?);`,
    [firstname, lastname, email, password]
  );

}

module.exports = {
	getAllUsers,
  getUserById,
  getUserByEmail,
  addOneUser
};
