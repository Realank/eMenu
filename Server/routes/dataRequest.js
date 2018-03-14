var express = require('express');
var router = express.Router();
var dataEngine = require('./DataEngine')

router.post('/newdish', function(req, res, next) {
    var dish = req.body.dish;
    console.log('post new dish == ', dish);
    if(dish.name.length == 0){
        res.json({status:'error',reason:'fill blanks'});
        return;
    }
    dataEngine.postDish(dish,function (err) {
        if(err) {
            console.log(err);
            res.json({status:'error',reason:'register failed'});
        }else{
            res.json({status:'success'})
        }
        return;
    })

});

router.get('/dishlist/:id', function(req, res, next) {
    console.log('dishlist');
    var id = req.params.id
    dataEngine.listDishes(id,function (err, dishes) {
        res.json({status:'success',data:dishes});
    })
});

router.get('/dish/:id', function(req, res, next) {
    console.log('load dish');
    var id = req.params.id
    dataEngine.findDishById(id,function (err, dish) {
        res.json({status:'success',data:dish})
    })
});

router.get('/deletedish/:id', function(req, res, next) {
    console.log('delete dish');
    var id = req.params.id
    dataEngine.deleteDish(id,function (err) {
        res.json({status:"success"})
    })
});

router.post('/reslogin', function(req, res, next) {
    var account = req.body.account;
    var password = req.body.password;
    console.log('login == ', account, 'with ', password);
    if(account.length == 0 || password.length == 0){
        res.json({status:'error',reason:'please input username and password'});
        return;
    }
    dataEngine.findRestaurant(account, password,function (err, restaurant) {
        console.log(restaurant);
        if(err || !restaurant){
            console.log(err);
            res.json({status:'error',reason:'username or password incorrect'});
        }else{
            res.json({status:'success',data:restaurant})
        }
        return;
    })

});

router.post('/newres', function(req, res, next) {
    var restaurant = req.body.restaurant;
    console.log('post new restaurent == ', restaurant);
    if(restaurant.account.length == 0){
        res.json({status:'error',reason:'fill blanks'});
        return;
    }
    dataEngine.postRestaurant(restaurant,function (err) {
        if(err) {
            console.log(err);
            res.json({status:'error',reason:'register failed'});
        }else{
            res.json({status:'success'})
        }

        return;
    })

});

module.exports = router;
