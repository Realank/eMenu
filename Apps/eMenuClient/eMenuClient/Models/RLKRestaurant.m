//
//  Restaurant.m
//  eMenuClient
//
//  Created by Realank on 2018/2/12.
//  Copyright © 2018年 Realank. All rights reserved.
//

#import "RLKRestaurant.h"

@implementation RLKRestaurant

+ (instancetype)modelWithDict:(AVObject*)dict{
    if (dict && dict.allKeys.count) {
        RLKRestaurant* res = [[RLKRestaurant alloc] init];
        res.name = dict[@"name"];
        res.account = dict[@"account"];
        res.password = dict[@"password"];
        res.tableCount = dict[@"tablecount"];
        return res;
    }
    return nil;
}

+ (void)loginWithAccount:(NSString*)account andPassword:(NSString*)password result:(void (^)(RLKRestaurant* restaurant))resultBlock{
    AVQuery *query = [AVQuery queryWithClassName:@"Restaurant"];
    [query orderByAscending:@"index"];
    NSLog(@"has cache: %d",[query hasCachedResult]);
//    query.cachePolicy = kAVCachePolicyNetworkElseCache;
//    query.maxCacheAge = 3600 * 24 * 2;
    [query whereKey:@"account" equalTo:account];
    [query whereKey:@"password" equalTo:password];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            if (objects.count) {
                RLKRestaurant* res = [RLKRestaurant modelWithDict:objects.firstObject];
                if (res) {
                    [RLKMenu loadWithResult:^(RLKMenu *menu) {
                        if (menu) {
                            res.menu = menu;
                            resultBlock(res);
                        }else{
                            resultBlock(nil);
                        }
                    }];
                    return;
                }
            }
        }
        resultBlock(nil);
    }];
}

@end
