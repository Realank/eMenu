var mongoose = require('mongoose');

// 相当于构建一张表的字段
var RestaurantSchema = new mongoose.Schema({
    name: String,
    account: String,
    tableCount: Number,
    password: String,
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
RestaurantSchema.pre('save', function(next) {
    // 是否是新添加的数据？
    if (this.isNew) { // 是，将创建时间和更新时间设置为当前时间
        this.meta.createAt = this.meta.updateAt = Date.now();
    } else { // 否，只更新update的时间
        this.meta.updateAt = Date.now();
    }

    next(); // 执行下一中间件
});

// mongoose的死套路，添加一个静态方法

RestaurantSchema.statics = {
    // 获取数据
    fetch: function(cb) {
        return this
            .find({})
            .sort('meta.updateAt')
            .exec(cb)
    },
    // 根据id获取文档（记录）
    findById: function(id, cb) {
        return this
            .findOne({_id: id})
            .exec(cb);		// 执行回调函数
    },
    findByAccountAndPass: function(account, password, cb) {
        return this
            .findOne({account: account, password, password})
            .exec(cb);		// 执行回调函数
    },
};


// 相当于创建一张表
var Restaurant = mongoose.model('Restaurant', RestaurantSchema);

module.exports = Restaurant;
