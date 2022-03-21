// controllers/users.js
const bcrypt = require('bcrypt');
const users = require('../models/users');

const getUsers = async (req, res, next) => {
  try {
    res.send(await users.getAllUsers());
  } catch (err) {
    next(err);
  }
}

const getUser = async (req, res, next) => {
  try {
    res.send(await users.getUserById(req.params.id_user));
  } catch (err) {
    next(err);
  }
};

const addUser = async (req, res, next) => {
  try {
    // hash
    const password = await bcrypt.hash(req.body.password, 10);
    // add
    await users.addOneUser(
      req.body.firstname, req.body.lastname, req.body.email, password
    )
    // confirmation
    res.render('index', {
      connected: req.loggedIn,
      title: req.t("USERS.CREATED"),
      content: req.t("USERS.CREATED")
    });
  } catch (err) {
    next(err);
  }
}

const addUserForm = async (req, res, next) => {
  try {
    res.render('users/add', {
      connected: req.loggedIn,
      title: req.t(`USERS.ADD`)
    });
  } catch (err) {
    next(err);
  }
}

module.exports = {
  addUser,
  addUserForm,
  getUsers,
  getUser
};
