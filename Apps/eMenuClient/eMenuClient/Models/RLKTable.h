//
//  RLKTable.h
//  eMenuClient
//
//  Created by Realank on 2018/2/12.
//  Copyright © 2018年 Realank. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RLKTable : NSObject

@property (nonatomic, copy) NSString* name;
@property (nonatomic, copy) NSString* account;
@property (nonatomic, copy) NSString* password;
@property (nonatomic, strong) NSString* tableNumber;

@property (nonatomic, strong) RLKMenu* menu;

+ (void)loginWithAccount:(NSString*)account andPassword:(NSString*)password result:(void (^)(RLKTable* table))resultBlock;

@end
