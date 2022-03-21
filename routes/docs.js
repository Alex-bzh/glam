// routes/docs.js
const express = require('express');
const auth = require('../controllers/auth');
const docs = require('../controllers/docs')

const router = express.Router();

/*
*	Add doc – restricted
*/
router.get('/add', auth.isAuthorized, docs.listDocTypes);
router.get('/add/:type', auth.isAuthorized, docs.docForm);
router.post('/add', auth.isAuthorized, docs.addDoc);

/*
*	Docs infos
*/
router.get('/', docs.getDocs);
//router.get('/:id_doc', users.getDoc);

module.exports = router;
