//models/authors.js
const db = require('../services/db');

// add an author
async function addAuthor(author) {

	await db.query(
		`INSERT INTO authors (firstname, lastname)
		VALUES (?, ?);`,
		[author.firstname, author.lastname]
	);

}

// add doc & authors
async function addDocumentAuthor(ref_document, ref_author, ref_role) {

  await db.query(
    `INSERT INTO documents_authors (ref_document, ref_author, ref_role)
    VALUES (?, ?, ?);`,
    [ref_document, ref_author, ref_role]
  );

}

// get author id
async function getAuthorId(author) {

	const results = await db.query(
		`SELECT id_author
		FROM authors
		WHERE firstname = ? AND lastname = ?;`,
		[author.firstname, author.lastname]
	);

	return results[0].id_author;
}

// author exists?
async function isAuthor(author) {

	const results = await db.query(
		`SELECT id_author
		FROM authors
		WHERE firstname = ? AND lastname = ?;`,
		[author.firstname, author.lastname]
	);
	if (results.length) return true;
	else return false;

}

module.exports = {
	addAuthor,
	addDocumentAuthor,
	getAuthorId,
	isAuthor
};
