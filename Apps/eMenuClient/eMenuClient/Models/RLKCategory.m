//
//  RLKCategory.m
//  eMenuClient
//
//  Created by Realank on 2018/2/12.
//  Copyright © 2018年 Realank. All rights reserved.
//

#import "RLKCategory.h"

@implementation RLKCategory

+ (instancetype)modelWithDict:(AVObject*)dict{
    if (dict && dict.allKeys.count) {
        RLKCategory* category = [[RLKCategory alloc] init];
        category.name = dict[@"name"];
        category.type = dict[@"type"];
        return category;
    }
    return nil;
}

@end
