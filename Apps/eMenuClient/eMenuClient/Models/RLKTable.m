//
//  RLKTable.m
//  eMenuClient
//
//  Created by Realank on 2018/2/12.
//  Copyright © 2018年 Realank. All rights reserved.
//

#import "RLKTable.h"

@implementation RLKTable

+ (instancetype)modelWithDict:(AVObject*)dict{
    if (dict && dict.allKeys.count) {
        RLKTable* res = [[RLKTable alloc] init];
        res.name = dict[@"name"];
        res.account = dict[@"account"];
        res.password = dict[@"password"];
        res.tableNumber = dict[@"tableNumber"];
        return res;
    }
    return nil;
}

+ (void)loginWithAccount:(NSString*)account andPassword:(NSString*)password result:(void (^)(RLKTable* table))resultBlock{
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
                RLKTable* table = [RLKTable modelWithDict:objects.firstObject];
                if (table) {
                    [RLKMenu loadWithResult:^(RLKMenu *menu) {
                        if (menu) {
                            table.menu = menu;
                            resultBlock(table);
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
