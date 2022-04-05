//models/docs.js
const authors = require('../controllers/authors');
const languages = require('../controllers/languages');
const themes = require('../controllers/themes');
const db = require('../services/db');

// POST doc
async function addDoc(data) {

  // optional variables
  const online          = (typeof(data.online)          == "undefined" || !data.online          || !data.online.length)         ? 0   : 1;
  const metadata        = (typeof(data.metadata)        == "undefined" || !data.metadata        || !data.metadata.length)       ? 0   : 1;
  const abstract        = (typeof(data.abstract)        == "undefined" || !data.abstract        || !data.abstract.length)       ? ""  : data.abstract;
  const edition         = (typeof(data.edition)         == "undefined" || !data.edition         || !data.edition.length)        ? ""  : data.edition;
  const nb_volumes      = (typeof(data.nb_volumes)      == "undefined" || !data.nb_volumes      || !data.nb_volumes.length)     ? 0   : data.nb_volumes;
  const issue           = (typeof(data.issue)           == "undefined" || !data.issue           || !data.issue.length)          ? 0   : data.issue;
  const pages           = (typeof(data.pages)           == "undefined" || !data.pages           || !data.pages.length)          ? 0   : data.pages;
  const pages_from      = (typeof(data.pages_from)      == "undefined" || !data.pages_from      || !data.pages_from.length)     ? 0   : data.pages_from;
  const pages_to        = (typeof(data.pages_to)        == "undefined" || !data.pages_to        || !data.pages_to.length)       ? 0   : data.pages_to;
  const date_alternate  = (typeof(data.date_alternate)  == "undefined" || !data.date_alternate  || !data.date_alternate.length) ? 0   : data.date_alternate;
  const place           = (typeof(data.place)           == "undefined" || !data.place           || !data.place.length)          ? ""  : data.place;
  const support         = (typeof(data.support)         == "undefined" || !data.support         || !data.support.length)        ? ""  : data.support;
  const media_type      = (typeof(data.media_type)      == "undefined" || !data.media_type      || !data.media_type.length)     ? ""  : data.media_type;
  const format          = (typeof(data.format)          == "undefined" || !data.format          || !data.format.length)         ? ""  : data.format;
  const doi             = (typeof(data.doi)             == "undefined" || !data.doi             || !data.doi.length)            ? ""  : data.doi;
  const issn            = (typeof(data.issn)            == "undefined" || !data.issn            || !data.issn.length)           ? ""  : data.issn;
  const url             = (typeof(data.url)             == "undefined" || !data.url             || !data.url.length)            ? ""  : data.url;
  const genderStudies   = (typeof(data.genderStudies)   == "undefined" || !data.genderStudies   || !data.genderStudies.length)  ? []  : data.genderStudies;

  // special variables
  const date            = data.date.split("-");

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
      online,
      metadata,
      data.title,
      data.title_alternate,
      abstract,
      edition,
      data.volume,
      nb_volumes,
      issue,
      pages,
      pages_from,
      pages_to,
      date[0],
      date[1],
      date[2],
      date_alternate,
      place,
      support,
      media_type,
      format,
      doi,
      issn,
      url
    ]
  );

  // doc id
  const ref_document = result.insertId;

  /**********
  * Authors *
  **********/

  // make an array of authors w/ roles
  const authorsList = await authors.buildAuthors(data.firstnames, data.lastnames, data.ref_roles);

  // add authors
  await authors.addAuthors(authorsList, ref_document);

  /*******************
  * Languages-topics *
  *******************/

  // add languages-topics
  await languages.addLanguagesTopics(data.languages_topics, ref_document);

  /*********
  * Themes *
  *********/

  // add themes: general
  await themes.addDocumentThemes(data.themes, ref_document);
  // add themes: gender studies
  await themes.addDocumentThemes(genderStudies, ref_document);
  // add themes: linguistics
  await themes.addDocumentThemes(data.linguistics, ref_document);

  return "Doc created";

  /*********
  * Fields *
  *********/

  // add related fields
  await fields.addDocumentFields(data.related_fields, ref_document);

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
    FROM documents;`
  );

  return results;
}

module.exports = {
  addDoc,
  getAllDocs
};
