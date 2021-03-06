//
//  MenuViewController.h
//  eMenuClient
//
//  Created by Realank on 2018/2/12.
//  Copyright © 2018年 Realank. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol DishOrderChangeDelegate

- (void)wantOrder:(BOOL)order dish:(RLKDish*)dish;

@end

@interface MenuViewController : UIViewController

@property (nonatomic, strong) RLKMenu* menu;

@end
