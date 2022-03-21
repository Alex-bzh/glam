// routes/users.js
const express = require('express');
const auth = require('../controllers/auth');
const users = require('../controllers/users');

const router = express.Router();

/*
* Add user – restricted
*/
router.get('/add', auth.isAuthorized, users.addUserForm);
router.post('/add', auth.isAuthorized, users.addUser);

/*
* Connection/Logout
*/
router.get('/login', auth.loginForm);
router.post('/login', auth.login);
router.get('/logout', auth.logout);

/*
* Users infos – restricted
*/
router.get('/', auth.isAuthorized, users.getUsers);
router.get('/:id_user', auth.isAuthorized, users.getUser);

module.exports = router;
