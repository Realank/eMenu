//
//  RLKMenu.h
//  eMenuClient
//
//  Created by Realank on 2018/2/12.
//  Copyright © 2018年 Realank. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RLKMenu : NSObject

@property (nonatomic, strong) NSArray* dishes;
@property (nonatomic, strong) NSArray* categories;

@property (nonatomic, strong) NSDictionary* dishesByCategory;
@property (nonatomic, strong) NSArray* dishesNoCategory;

+ (void)loadWithResult:(void (^)(RLKMenu* menu))resultBlock;

- (NSArray*)orderedDishes;
- (void)orderDish:(RLKDish*)dish;
- (void)disOrderDish:(RLKDish*)dish;
- (float)totalOrderPrice;
@end
