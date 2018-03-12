var express = require('express');
var router = express.Router();
var dbEngine = require("./DBEngine")

/* GET home page. */
router.get('/', function(req, res, next) {
  // res.render('index', { title: 'Express' });
  //   dbEngine.postNewMovie({
  //           name:"harry potter",
  //           description:"good"
  //       },function (err) {
  //
  //   });
  //   dbEngine.listMovies(function (movies) {
  //       res.json(movies);
  //   })
    res.render('index', { title: 'Add Movie' });

});

module.exports = router;
