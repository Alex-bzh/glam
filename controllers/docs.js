// controllers/docs.js
const docs = require('../models/docs');

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
		const languages = await docs.getLanguages();
		res.render(`docs/${ type }`, {
			connected: req.loggedIn,
			languages: languages,
			title: req.t('DOCS.ADD'),
			subtitle: req.t(`DOCS.${ type.toUpperCase() }`),
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
