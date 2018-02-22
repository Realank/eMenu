//
//  DishSampleTableViewCell.h
//  eMenuClient
//
//  Created by Realank on 2018/2/14.
//  Copyright © 2018年 Realank. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuViewController.h"
@interface DishSampleTableViewCell : UITableViewCell

@property (nonatomic, weak) RLKDish* dish;
@property (nonatomic, weak) id<DishOrderChangeDelegate> delegate;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

+ (CGFloat)cellHeight;

@end
