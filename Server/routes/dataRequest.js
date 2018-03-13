var express = require('express');
var router = express.Router();
var dataEngine = require('./DataEngine')

router.post('/newdish', function(req, res, next) {
    var dish = req.body.dish;
    console.log('post == ', dish);
    if(dish.name.length == 0){
        res.json({status:'error',reason:'fill blanks'});
        return;
    }
    dataEngine.postDish(dish,function (err) {
        if(err) console.log(err);
        res.json({status:'success'})
        return;
    })

});

router.get('/dishlist', function(req, res, next) {
    console.log('dishlist');
    dataEngine.listDishes(function (dishes) {
        res.json(dishes);
    })
});

router.get('/dish/:id', function(req, res, next) {
    console.log('load dish');
    var id = req.params.id
    dataEngine.findDishById(id,function (dish) {
        res.json(dish)
    })
});

router.get('/delete/:id', function(req, res, next) {
    console.log('delete dish');
    var id = req.params.id
    dataEngine.deleteDish(id,function (dish) {
        res.json({status:"success"})
    })
});

module.exports = router;
