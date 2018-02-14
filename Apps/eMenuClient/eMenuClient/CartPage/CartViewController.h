//
//  CartViewController.h
//  eMenuClient
//
//  Created by Realank on 2018/2/13.
//  Copyright © 2018年 Realank. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuViewController.h"

@protocol CartViewGoCheckDelegate

- (void)goCheck;

@end

@interface CartViewController : UIViewController

@property (nonatomic, weak) RLKMenu* menu;
@property (nonatomic, weak) id<CartViewGoCheckDelegate> goCheckDelegate;
@property (nonatomic, weak) id<DishOrderChangeDelegate> orderChangeDelegate;
@end
