//controllers/authors.js
const authors = require('../models/authors');

async function addAuthors(authorsList, ref_document) {

  for (author of authorsList) {
    // insert unknown authors
    if (!await authors.isAuthor(author)) await authors.addAuthor(author);
    // id authors
    const ref_author = await authors.getAuthorId(author);
    // link between doc and authors
    await authors.addDocumentAuthor(ref_document, ref_author, author.ref_role);
  }
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

module.exports = {
	addAuthors,
	buildAuthors
};
