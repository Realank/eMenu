//
//  DishCheckTableViewCell.m
//  eMenuClient
//
//  Created by Realank on 2018/2/22.
//  Copyright © 2018年 Realank. All rights reserved.
//

#import "DishCheckTableViewCell.h"

@interface DishCheckTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@end

@implementation DishCheckTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    NSString* kCellIdentifier = [[self class] description];
    id cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    if (cell == nil) {
        [tableView registerNib:[UINib nibWithNibName:kCellIdentifier bundle:nil] forCellReuseIdentifier:kCellIdentifier];
        cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    }
    return cell;
}

- (void)setDish:(RLKDish *)dish{
    _dish = dish;
    _nameLabel.text = dish.name;
    _countLabel.text = [NSString stringWithFormat:@"X%.1f",dish.orderCount];
    float totalPrice = dish.orderCount * dish.price.floatValue;
    _priceLabel.text = [NSString stringWithFormat:@"¥%.1f",totalPrice];
}
@end
