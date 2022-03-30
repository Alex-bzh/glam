// controllers/docs.js
const docs = require('../models/docs');
const langs = require('../models/languages');
const themes = require('../models/themes');

// add a doc
const addDoc = async (req, res, next) => {
	try {
		res.send(await docs.addDoc(req.body))
	} catch (err) {
		next(err);
	}
}

// form to add a document of any type
const docForm = async (req, res, next) => {
	try {
		const type = req.params.type;
		res.render(`docs/${ type }`, {
			connected: req.loggedIn,
			genderStudies: await themes.getThemes(1),
			languages: await langs.getLanguages(),
			linguistics: await themes.getThemes(2),
			subtitle: req.t(`DOCS.${ type.toUpperCase() }`),
			themes: await themes.getThemes(0),
			title: req.t('DOCS.ADD'),
			type: type
		});
	} catch (err) {
		next(err);
	}
}

// get all the documents
const getDocs = async (req, res, next) => {
	try {
		res.send(await docs.getAllDocs());
	} catch (err) {
		next(err);
	}
}

// render a nav list of all types of documents
const listDocTypes = async (req, res, next) => {
	try {
	  res.render('docs/types', {
    	connected: req.loggedIn,
	    title: req.t('DOCS.ADD')
	  });
	} catch (err) {
		next(err);
	}
}

module.exports = {
	addDoc,
	getDocs,
	docForm,
	listDocTypes
}
