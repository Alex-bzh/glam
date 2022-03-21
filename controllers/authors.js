//controllers/authors.js

// add an author
async function addAuthor(author) {

	const results = await db.query(
		`INSERT INTO authors (firstname, lastname)
		VALUES (?, ?);`,
		[author.firstname, author.lastname]
	);

}

// map authors' firstnames, lastnames and roles
async function buildAuthors(firstnames, lastnames, ref_roles) {

	// object with 2 keys: firstname & lastname
	const authors = firstnames.map(function(item, idx) {
		return {
			"firstname": item,
			"lastname": lastnames[idx],
			"ref_role": ref_roles[idx]
		};
	});

	return authors;
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
	buildAuthors,
	getAuthorId,
	isAuthor
};
