var mongoose = require('mongoose');

var MovieSchema = require('../schemas/movie.js');

// 相当于创建一张表
var Movie = mongoose.model('Movie', MovieSchema);

module.exports = Movie;
