//
//  RLKCategory.h
//  eMenuClient
//
//  Created by Realank on 2018/2/12.
//  Copyright © 2018年 Realank. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RLKCategory : NSObject

@property (nonatomic, copy) NSString* type;
@property (nonatomic, copy) NSString* name;


+ (instancetype)modelWithDict:(AVObject*)dict;
@end
