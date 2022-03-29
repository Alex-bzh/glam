//models/languages.js
const db = require('../services/db');

// add language-topic
async function addLanguageTopic(ref_document, ref_language) {

  await db.query(
    `INSERT INTO documents_languages_topics (ref_document, ref_language)
    VALUES (?, ?);`,
    [ref_document, ref_language]
  );

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
  addLanguageTopic,
	getLanguages
}
