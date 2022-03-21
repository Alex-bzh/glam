// db.js
const dotenv = require('dotenv');
const mysql = require('mysql2/promise');

// get config vars
dotenv.config();

// bdd connection config
const config = {
	host: process.env.BDD_HOST,
	user: process.env.BDD_USER,
	password: process.env.BDD_PWD,
	database: process.env.BDD_NAME
}

async function query(sql, params) {
	// create the connection
	const connection = await mysql.createConnection(config);
	// query database
	const [rows, fields] = await connection.execute(sql, params);

	return rows;
}

module.exports = { query };
