//
//  DishDetailViewController.h
//  eMenuClient
//
//  Created by Realank on 2018/2/13.
//  Copyright © 2018年 Realank. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuViewController.h"
@interface DishDetailViewController : UIViewController

@property (nonatomic, weak) RLKDish* dish;
@property (nonatomic, weak) id<DishOrderChangeDelegate> delegate;
@end
