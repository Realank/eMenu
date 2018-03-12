
const mongoose = require('mongoose');
const _ = require('underscore');

const Movie = require('../models/movie');

var DBEngine = function () {

};

DBEngine.start = function () {
    // 连接数据库
    mongoose.connect("mongodb://localhost:27017/imovie");

//     db.connection.on("error", function(error) {
//         console.log("数据库连接失败：" + error);
// });
//
//     db.connection.on("open", function() {
//         console.log("——数据库连接成功！——");
// });
}


DBEngine.listMovies = function (cb) {
    Movie.fetch(function(err, movies) {
        if (err) console.log('list movies error:' +  err);
        cb(movies);
    });
};

DBEngine.findMovieById = function (id, cb) {
    Movie.findById(id,function (err, movie) {
        if (err) console.log(err);
        cb(movie);
    });
};

DBEngine.postMovie = function (movie, cb) {
    var id = movie.id;
    var _movie;
    if(id !== undefined){
        console.log('id:' + id)
        //update data
        Movie.findById(id, function (err, existMovie) {
            if (err) console.log(err);
            _movie = _.extend(existMovie, movie);
            _movie.save(function (err, movie) {
                if (err) console.log(err);
                cb(err);
            });
        });
    }else{
        _movie = new Movie(movie);
        console.log('_movie' + _movie)
        _movie.save(function (err, movie) {
            if (err) console.log(err);
            cb(err);
        })
    }
}

DBEngine.deleteMovie = function (id, cb) {
    Movie.remove({_id:id},function (err, movie) {
        if (err) console.log(err);
        cb(err)
    })
}

module.exports = DBEngine;
