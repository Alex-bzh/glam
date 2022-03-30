//models/themes.js
const db = require('../services/db');

// add document theme
async function addDocumentTheme(ref_document, ref_theme) {

  await db.query(
    `INSERT INTO documents_themes (ref_document, ref_theme)
    VALUES (?, ?);`,
    [ref_document, ref_theme]
  );

}

// all themes about a given field
async function getThemes(field) {

  const results = await db.query(
    `SELECT id_theme, theme
    FROM themes
    WHERE field = ?
    ORDER BY theme ASC;`,
    [field]
  );

  return results;
}

module.exports = {
  addDocumentTheme,
  getThemes
}
