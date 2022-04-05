//models/fields.js
const db = require('../services/db');

// add document related field
async function addDocumentField(ref_document, ref_field) {

	await db.query(
    `INSERT INTO documents_related_fields (ref_document, ref_field)
    VALUES (?, ?);`,
    [ref_document, ref_field]
  );

}

// get fields related to another field
async function getFields(ref_parent = 0) {

	const results = await db.query(
		`SELECT id_field, field
		FROM related_fields
		WHERE ref_parent = ?
		ORDER BY id_field;`,
		[ref_parent]
	);

	return results;

}

module.exports = {
	addDocumentField,
	getFields
}
