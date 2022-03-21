// controllers/auth.js
const bcrypt = require('bcrypt');
const dotenv = require('dotenv');
const jwt = require('jsonwebtoken');
const moment = require('moment');
const users = require('../models/users');

// get config vars
dotenv.config();

// check credentials
const isAuthorized = async (req, res, next) => {
	try {
		if (!req.cookies.authorization) throw { status: 401, message: req.t("AUTH.NOT_AUTHORIZED") }
		// get the token
		const token = JSON.parse(req.cookies.authorization).token;
		// decode the token
		const decodedToken = jwt.verify(token, process.env.SECRET_TOKEN);
		// extract userId
		const user = await users.getUserById(decodedToken.userId);
		// check that the user exists in db
		if (req.body.userId && req.body.userId !== decodedToken.userId) {
			throw { status: 401, message: req.t("AUTH.NO_USER") };
		} else {
			next();
		}
	} catch (err) {
		next(err);
	}
};

// already logged in?
const isLoggedIn = async (req, res, next) => {
	try {
		// if not logged in
		if (!req.cookies.authorization) { req.loggedIn = false; }
		else {
			// get the token
			const token = JSON.parse(req.cookies.authorization).token;
			// decode the token
			const decodedToken = jwt.decode(token, process.env.SECRET_TOKEN);
			// token expired?
			req.loggedIn = decodedToken.exp > moment().unix() ? true : false;
		}
		next();
	} catch (err) {
		next(err);
	}
};

// log in
const login = async (req, res, next) => {
	try {
		// a user
		const user = await users.getUserByEmail(req.body.email);
		// no user with this email
		if (!user) throw { status: 401, message: req.t("AUTH.NO_EMAIL") }
		// compare password given
		bcrypt.compare(req.body.password, user.password)
		.then(result => {
			// password incorrect
			if(!result) throw { status: 401, message: req.t("AUTH.NO_PASSWORD") }
			// create token
			else return {
				userId: user.id,
				token: jwt.sign(
					{ userId: user.id },
					process.env.SECRET_TOKEN,
					{ expiresIn: '7d' }
				)
			};
		})
		.then(token => {
			// HTTPOnly Cookie
			res.cookie("authorization", JSON.stringify(token), {
	      secure: process.env.NODE_ENV !== "development",
	      httpOnly: true,
	      expires: moment().add(7, "days").toDate()
	    });
		  // redirect
			res.status(200).redirect('/');
		})
		.catch(err => next(err));
	} catch (err) {
		next(err);
	}
}

// render connection form
const loginForm = async (req, res, next) => {
	try {	
		// if already logged in, to home page	
		if (req.loggedIn) res.redirect('/')
		res.render('auth/login', {
    	connected: req.loggedIn,
    	title: req.t(`AUTH.LOGIN`)
  	});
	} catch (err) {
		next(err);
	}
}

// logout
const logout = async (req, res, next) => {
	try {
		// delete cookie authorization
		res.clearCookie('authorization');
		res.redirect('/');
	} catch (err) {
		next(err);
	}
}

module.exports = {
	isAuthorized,
	isLoggedIn,
	login,
	loginForm,
	logout
};
