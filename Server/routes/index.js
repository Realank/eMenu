var express = require('express');
var router = express.Router();

/* GET home page. */
router.get('/', function(req, res, next) {
    res.render('index', { title: 'All Dishes'});

});
router.get('/edit/:id', function(req, res, next) {
    var id = req.params.id
    res.render('editDish', { title: 'edit Dish',dishid:id });

});
router.get('/add', function(req, res, next) {
    res.render('editDish', { title: 'add Dish'});

});

module.exports = router;
