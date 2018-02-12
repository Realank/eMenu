//
//  RLKDish.h
//  eMenuClient
//
//  Created by Realank on 2018/2/12.
//  Copyright © 2018年 Realank. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RLKDish : NSObject
@property (nonatomic, copy) NSString* _id;
@property (nonatomic, copy) NSString* name;
@property (nonatomic, copy) NSString* descirbe;
@property (nonatomic, copy) NSString* category;
@property (nonatomic, copy) NSString* imageURL;
@property (nonatomic, copy) NSString* unit;
@property (nonatomic, strong) NSNumber* price;
@property (nonatomic, strong) NSNumber* stock;

//order
@property (nonatomic, assign) float orderCount;

+ (instancetype)modelWithDict:(AVObject*)dict;
@end
