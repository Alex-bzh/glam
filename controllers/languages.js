//controllers/languages.js
const languages = require('../models/languages');

// add language-topic
async function addLanguagesTopics(languages_topics, ref_document) {

  for (language of languages_topics) {
    await languages.addLanguageTopic(ref_document, language);
  }

}

module.exports = {
  addLanguagesTopics
};
