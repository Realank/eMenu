
const mongoose = require('mongoose');
const _ = require('underscore');

const Dish = require('../models/dishes');
const Restaurant = require('../models/restaurants');

var DataEngine = function () {

};

DataEngine.start = function () {
    // 连接数据库
    mongoose.connect("mongodb://localhost:27017/eMenu");

//     db.connection.on("error", function(error) {
//         console.log("数据库连接失败：" + error);
// });
//
//     db.connection.on("open", function() {
//         console.log("——数据库连接成功！——");
// });
}


//dish
DataEngine.listDishes = function (resId,cb) {
    Dish.fetchByResId(resId,function(err, dishes) {
        if (err) console.log('list dishes error:' +  err);
        cb(err, dishes);
    });
};

DataEngine.findDishById = function (id, cb) {
    Dish.findById(id,function (err, dish) {
        if (err) console.log(err);
        cb(err, dish);
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

DataEngine.findRestaurant = function (account, password, cb) {
    Restaurant.findByAccountAndPass(account, password, function (err, restaurant) {
        if (err) console.log(err);
        cb(err, restaurant);
    })
}

DataEngine.postRestaurant = function (restaurant, cb) {
    var id = restaurant.id;
    var _restaurant;
    if(id !== undefined){
        console.log('id:' + id)
        //update data
        Restaurant.findById(id, function (err, existRes) {
            if (err) console.log(err);
            _restaurant = _.extend(existRes, restaurant);
            _restaurant.save(function (err, restaurant) {
                if (err) console.log(err);
                cb(err);
            });
        });
    }else{
        _restaurant = new Restaurant(restaurant);
        console.log('_restaurant' , restaurant)
        _restaurant.save(function (err, restaurant) {
            if (err) console.log(err);
            cb(err);
        })
    }
}

DataEngine.deleteRestaurant = function (id, cb) {
    Restaurant.remove({_id:id},function (err, res) {
        if (err) console.log(err);
        cb(err)
    })
}

module.exports = DataEngine;
