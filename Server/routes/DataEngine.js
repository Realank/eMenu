
const mongoose = require('mongoose');
const _ = require('underscore');

const Dish = require('../models/dishes');

var DataEngine = function () {

};

DataEngine.start = function () {
    // 连接数据库
    mongoose.connect("mongodb://localhost:27017/dishes");

//     db.connection.on("error", function(error) {
//         console.log("数据库连接失败：" + error);
// });
//
//     db.connection.on("open", function() {
//         console.log("——数据库连接成功！——");
// });
}


DataEngine.listDishes = function (cb) {
    Dish.fetch(function(err, dishes) {
        if (err) console.log('list dishes error:' +  err);
        cb(dishes);
    });
};

DataEngine.findDishById = function (id, cb) {
    Dish.findById(id,function (err, dish) {
        if (err) console.log(err);
        cb(dish);
    });
};

DataEngine.postDish = function (dish, cb) {
    var id = dish.id;
    var _dish;
    if(id !== undefined){
        console.log('id:' + id)
        //update data
        Dish.findById(id, function (err, existDish) {
            if (err) console.log(err);
            _dish = _.extend(existDish, dish);
            _dish.save(function (err, dish) {
                if (err) console.log(err);
                cb(err);
            });
        });
    }else{
        _dish = new Dish(dish);
        console.log('_dish' + _dish)
        _dish.save(function (err, dish) {
            if (err) console.log(err);
            cb(err);
        })
    }
}

DataEngine.deleteDish = function (id, cb) {
    Dish.remove({_id:id},function (err, dish) {
        if (err) console.log(err);
        cb(err)
    })
}

module.exports = DataEngine;
