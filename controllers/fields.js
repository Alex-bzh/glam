//controllers/fields.js
const fields = require('../models/fields');

async function addDocumentFields(docFields, ref_document) {

	for (field of docFields) {
    await fields.addDocumentField(ref_document, field);
  }

}

// related fields tree
async function buildFieldsTree() {

	let tree = Array();
	const results = await fields.getFields();

	for (const result of results) {

		const field = {
			"id_field": result.id_field,
			"field": result.field,
			"related": Array()
		};

		const subFields = await fields.getFields(field.id_field);

		for (const subField of subFields) {

			const sub = {
				"id_field": subField.id_field,
				"field": subField.field,
				"related": Array()
			};

			const subSubFields = await fields.getFields(subField.id_field);

			for (const subSubField of subSubFields) {

				const subSub = {
					"id_field": subSubField.id_field,
					"field": subSubField.field
				}

				sub["related"].push(subSub);
			}

			field["related"].push(sub);
		}

		tree.push(field);
	}

	return tree;

}

module.exports = {
	addDocumentFields,
	buildFieldsTree
}
