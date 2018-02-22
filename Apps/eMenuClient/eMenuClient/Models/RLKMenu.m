//
//  RLKMenu.m
//  eMenuClient
//
//  Created by Realank on 2018/2/12.
//  Copyright © 2018年 Realank. All rights reserved.
//

#import "RLKMenu.h"

@interface RLKMenu()

@property (nonatomic, strong) NSMutableArray* orderedM;
@end

@implementation RLKMenu

+ (instancetype)modelWithCategories:(NSArray*)categories andDishes:(NSArray*)dishes{
    if (categories.count == 0 || dishes.count == 0) {
        return nil;
    }
    RLKMenu* menu = [[RLKMenu alloc] init];
    menu.categories = categories;
    menu.dishes = dishes;
    NSMutableDictionary* dishesByCategoryM = [NSMutableDictionary dictionary];
    NSMutableArray* dishesNoCategoryM = [NSMutableArray array];
    for (RLKCategory* cat in categories) {
        NSString* type = cat.type;
        if (type.length) {
            dishesByCategoryM[type] = [NSMutableArray array];
        }
    }
    for (RLKDish* dish in dishes) {
        NSString* category = dish.category;
        if (category.length) {
            NSMutableArray* dishArray = dishesByCategoryM[category];
            if (dishArray) {
                [dishArray addObject:dish];
                continue;
            }
        }
        [dishesNoCategoryM addObject:dish];
        
    }
    menu.dishesByCategory = [dishesByCategoryM copy];
    menu.dishesNoCategory = [dishesNoCategoryM copy];
    return menu;
}

+ (void)loadWithResult:(void (^)(RLKMenu* menu))resultBlock{
    
    
    [RLKMenu loadCategories:^(NSArray *categories) {
        
        [RLKMenu loadDishes:^(NSArray *dishes) {
            
            if (categories.count && dishes.count) {
                RLKMenu* menu = [RLKMenu modelWithCategories:categories andDishes:dishes];
                if (resultBlock) {
                    resultBlock(menu);
                }
            }else{
                if (resultBlock) {
                    resultBlock(nil);
                }
            }
            
        }];
    }];

}

+ (void)loadCategories:(void (^)(NSArray* categories))resultBlock{
    AVQuery *query = [AVQuery queryWithClassName:@"Category"];
    [query orderByAscending:@"index"];
    NSLog(@"has cache: %d",[query hasCachedResult]);
//    query.cachePolicy = kAVCachePolicyNetworkElseCache;
//    query.maxCacheAge = 3600 * 24 * 2;
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            if (objects.count) {
                NSMutableArray* categories = [NSMutableArray array];
                for (AVObject* obj in objects) {
                    
                    if (obj.allKeys > 0) {
                        RLKCategory* cat = [RLKCategory modelWithDict:obj];
                        if (cat) {
                            [categories addObject:cat];
                        }
                        
                    }
                }
                if (categories.count > 0) {
                    resultBlock([categories copy]);
                    return;
                }
            }
        }
        resultBlock(nil);
    }];
}


+ (void)loadDishes:(void (^)(NSArray* dishes))resultBlock{
    AVQuery *query = [AVQuery queryWithClassName:@"Menu"];
    [query orderByAscending:@"index"];
    NSLog(@"has cache: %d",[query hasCachedResult]);
//    query.cachePolicy = kAVCachePolicyNetworkElseCache;
//    query.maxCacheAge = 3600 * 24 * 2;
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            if (objects.count) {
                NSMutableArray* dishes = [NSMutableArray array];
                for (AVObject* obj in objects) {
                    
                    if (obj.allKeys > 0) {
                        RLKDish* dish = [RLKDish modelWithDict:obj];
                        if (dish) {
                            NSLog(@"%@",dish);
                            [dishes addObject:dish];
                        }
                        
                    }
                }
                if (dishes.count > 0) {
                    resultBlock([dishes copy]);
                    return;
                }
            }
        }
        resultBlock(nil);
    }];
}

- (instancetype)init{
    if (self = [super init]) {
        _orderedM = [NSMutableArray array];
    }
    return self;
}

- (NSArray *)orderedDishes{
    return [_orderedM copy];
}

- (BOOL)findDish:(RLKDish *)dish{
    for (RLKDish* existDish in _orderedM) {
        if ([existDish._id isEqualToString:dish._id]) {
            return YES;
        }
    }
    return NO;
}

- (void)orderDish:(RLKDish *)dish{
    if (![self findDish:dish]) {
        [_orderedM addObject:dish];
    }
    dish.orderCount++;
}
- (void)disOrderDish:(RLKDish *)dish{
    if ([self findDish:dish]) {
        dish.orderCount--;
        if (dish.orderCount == 0) {
            [_orderedM removeObject:dish];
        }
    }
}

- (float)totalOrderPrice{
    float price = 0;
    for (RLKDish* dish in _orderedM) {
        price += (dish.price.floatValue * dish.orderCount);
    }
    return price;
}

- (void)clearAllOrders{
    for (RLKDish* dish in _orderedM) {
        dish.orderCount = 0;
    }
    [_orderedM removeAllObjects];
}

@end
