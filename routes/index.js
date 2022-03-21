const express = require('express');
const router = express.Router();

/* GET home page. */
router.get('/:page?', (req, res, next) => {
  // if param page to upper, else HOME
  const page = req.params.page ? req.params.page.toUpperCase() : 'HOME';
  // render basic page
  res.render('index', {
    connected: req.loggedIn,
    title: req.t(`NAV.${page}`),
    content: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam in feugiat mauris. Nam facilisis enim in molestie elementum. Vestibulum vehicula nisi malesuada sollicitudin maximus. Etiam vel tortor nec nulla fringilla mattis. Mauris et suscipit arcu, vitae lobortis quam. Mauris vel purus tristique ex fringilla euismod sed vehicula sapien. Integer mattis, lacus in placerat varius, lorem ex tempor dui, eget euismod felis mauris in sapien. Nunc vehicula ligula non tortor elementum tincidunt. Etiam sem purus, pulvinar non sollicitudin sit amet, ornare dapibus orci.'
  });
});

module.exports = router;
