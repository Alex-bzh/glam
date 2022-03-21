//models/docs.js
const authors = require('../controllers/authors');
const db = require('../services/db');

// add doc & authors
async function addDocumentAuthor(ref_document, ref_author, ref_role) {

	await db.query(
		`INSERT INTO documents_authors (ref_document, ref_author, ref_role)
		VALUES (?, ?, ?);`,
		[ref_document, ref_author, ref_role]
	);

}

// POST doc
async function addDoc(data) {

	// optional and special variables
	const date			= data.date.split("-");
	const online		= (typeof(data.online) == "undefined") ? 0 : 1;
	const metadata	= (typeof(data.metadata) == "undefined") ? 0 : 1;

	const result = await db.query(
		`INSERT INTO documents (
			ref_type,
			ref_lang,
			online,
			metadata
		)
		VALUES (?, ?, ?, ?);`,
		[
			data.ref_type,
			data.ref_lang,
			online,
			metadata
		]
	);
	/*
	const result = await db.query(
		`INSERT INTO documents (
			ref_type,
			ref_lang,
			online,
			metadata,
			title,
			title_alternate,
			abstract,
			edition,
			volume,
			nb_volumes,
			issue,
			pages,
			pages_from,
			pages_to,
			date_year,
			date_month,
			date_day,
			date_alternate,
			place,
			support,
			media_type,
			format,
			doi,
			issn,
			url
		)
		VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);`,
		[
			data.ref_type,
			data.ref_lang,
			data.online,
			data.metadata,
			data.title,
			data.title_alternate,
			data.abstract,
			data.edition,
			data.volume,
			data.nb_volumes,
			data.issue,
			data.pages,
			data.pages_from,
			data.pages_to,
			date[0],
			date[1],
			date[2],
			data.date_alternate,
			data.place,
			data.support,
			data.media_type,
			data.format,
			data.doi,
			data.issn,
			data.url]
	);
	*/

	// doc id
	const ref_document = results[0].insertId;

	// make an array of authors w/ roles
	const authorsList = await authors.buildAuthors(data.firstnames, data.lastnames, data.ref_roles);

	for (author of authorsList) {
		// insert unknown authors
		if (!await authors.isAuthor(author)) await authors.addAuthor(author);
		// id authors
		const ref_author = await authors.getAuthorId(author);
		// link between doc and authors
		await addDocumentAuthor(ref_document, ref_author, ref_role);
	}

	return "Doc created";

}

// GET all docs
async function getAllDocs() {

	const results = await db.query(
		`SELECT 
			id_document,
			ref_type,
			ref_lang,
			online,
			metadata,
			title,
			title_alternate,
			abstract,
			edition,
			volume,
			nb_volumes,
			issue,
			pages,
			pages_from,
			pages_to,
			date_year,
			date_month,
			date_day,
			date_alternate,
			place,
			support,
			media_type,
			format,
			doi,
			issn,
			url
		FROM users
		ORDER BY lastname ASC;`
	);

	return results;
}

// all languages
async function getLanguages() {

	const results = await db.query(
		`SELECT id_language, language, iso
		FROM languages
		ORDER BY language ASC;`
	);

	return results;
}

module.exports = {
	addDoc,
	getAllDocs,
	getLanguages
};
