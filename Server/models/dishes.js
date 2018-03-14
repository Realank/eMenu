var mongoose = require('mongoose');

// 相当于构建一张表的字段
var DishSchema = new mongoose.Schema({
    name: String,
    describe: String,
    category: String,
    imageURL: String,
    unit: String,
    price: Number,
    stock: Number,
    resId: String,
    meta: {
        createAt: {
            type: Date,
            default: Date.now()
        },
        updateAt: {
            type: Date,
            default: Date.now()
        }
    },
});

// 保存
// pre每次在存储此数据之前都会调用此方法
DishSchema.pre('save', function(next) {
    // 是否是新添加的数据？
    if (this.isNew) { // 是，将创建时间和更新时间设置为当前时间
        this.meta.createAt = this.meta.updateAt = Date.now();
    } else { // 否，只更新update的时间
        this.meta.updateAt = Date.now();
    }

    next(); // 执行下一中间件
});

// mongoose的死套路，添加一个静态方法

DishSchema.statics = {
    // 获取数据
    fetch: function(cb) {
        return this
            .find({})
            .sort('meta.updateAt')
            .exec(cb)
    },
    fetchByResId: function(resId,cb) {
        return this
            .find({resId:resId})
            .sort('meta.updateAt')
            .exec(cb)
    },
    // 根据id获取文档（记录）
    findById: function(id, cb) {
        return this
            .findOne({_id: id})
            .exec(cb);		// 执行回调函数
    },
};


// 相当于创建一张表
var Dish = mongoose.model('Dish', DishSchema);

module.exports = Dish;
