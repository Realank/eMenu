//
//  RLKDish.m
//  eMenuClient
//
//  Created by Realank on 2018/2/12.
//  Copyright © 2018年 Realank. All rights reserved.
//

#import "RLKDish.h"
#import "SDWebImagePrefetcher.h"

@implementation RLKDish

+ (instancetype)modelWithDict:(AVObject*)dict{
    if (dict && dict.allKeys.count) {
        RLKDish* dish = [[RLKDish alloc] init];
        dish.name = dict[@"DishName"];
        dish.describe = dict[@"DishDescribe"];
        dish.imageURL = dict[@"ImageURL"];
        [[SDWebImagePrefetcher sharedImagePrefetcher] prefetchURLs:@[[NSURL URLWithString:dish.imageURL]]];
        dish.stock = dict[@"Count"];
        dish.price = dict[@"Price"];
        dish.category = dict[@"Category"];
        dish.unit = dict[@"Unit"];
        dish._id = dict.objectId;
        return dish;
    }
    return nil;
}

- (NSString *)description{
    return [NSString stringWithFormat:@"%@(%@) %@",self.name, self.describe, self.price];
}

@end
