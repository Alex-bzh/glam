//controllers/themes.js
const themes = require('../models/themes');

// add document themes
async function addDocumentThemes(docThemes, ref_document) {

  for (theme of docThemes) {
    await themes.addDocumentTheme(ref_document, theme);
  }

}

module.exports = {
  addDocumentThemes
};
