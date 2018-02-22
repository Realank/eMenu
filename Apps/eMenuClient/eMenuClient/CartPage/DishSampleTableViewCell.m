//
//  DishSampleTableViewCell.m
//  eMenuClient
//
//  Created by Realank on 2018/2/14.
//  Copyright © 2018年 Realank. All rights reserved.
//

#import "DishSampleTableViewCell.h"
#import "OrderCountView.h"
@interface DishSampleTableViewCell()<OrderChangeDelegate>
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet OrderCountView *orderView;


@end
@implementation DishSampleTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _orderView.delegate = self;
    _orderView.count = _dish.orderCount;
    _orderView.showBorder = YES;
}

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    NSString* kCellIdentifier = [[self class] description];
    DishSampleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    if (cell == nil) {
        [tableView registerNib:[UINib nibWithNibName:kCellIdentifier bundle:nil] forCellReuseIdentifier:kCellIdentifier];
        cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    }
    return cell;
}


+ (CGFloat)cellHeight{
    return 85.0f;
}

- (void)setDish:(RLKDish *)dish{
    _dish = dish;
    _nameLabel.text = dish.name;
    if (dish.unit.length) {
        _priceLabel.text = [NSString stringWithFormat:@"¥%@/%@",dish.price,dish.unit];
    }else{
        _priceLabel.text = [NSString stringWithFormat:@"¥%@",dish.price];
    }
    _orderView.count = dish.orderCount;
}

- (void)changeOrderCount:(BOOL)add{
    
    if (_delegate) {
        [_delegate wantOrder:add dish:_dish];
    }
}


@end
