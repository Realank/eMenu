var express = require('express');
var router = express.Router();

/* GET home page. */
router.get('/', function(req, res, next) {
  // res.render('index', { title: 'Express' });
    var obj = {
        "name":"realank",
        "pass":"1234"
    };

    res.json(obj);
});

module.exports = router;
