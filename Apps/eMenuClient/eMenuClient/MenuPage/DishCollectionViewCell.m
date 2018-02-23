//
//  DishCollectionViewCell.m
//  eMenuClient
//
//  Created by Realank on 2018/2/12.
//  Copyright © 2018年 Realank. All rights reserved.
//

#import "DishCollectionViewCell.h"
#import "OrderCountView.h"

@interface DishCollectionViewCell()<OrderChangeDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *dishImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *describeLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet OrderCountView *orderView;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *orderBackViewWidthConstraint;

@end

@implementation DishCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self setCornerRadius:5];
    _orderView.delegate = self;
    _orderView.count = _dish.orderCount;
//    [_orderView setShadowColor:[UIColor blackColor] offset:CGSizeMake(8, 8) radius:8 opacity:0.4];
//    self.contentView.backgroundColor = UIColorFromRGB(0xf0f0f0);
}

+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView forIndexPath:(NSIndexPath*)indexPath{
    NSString* kCellIdentifier = [[self class] description];
    NSString* identificate = [NSString stringWithFormat:@"%@%d_%d",kCellIdentifier,indexPath.section,indexPath.row];
    id cell = [collectionView dequeueReusableCellWithReuseIdentifier:identificate forIndexPath:indexPath];
    return cell;
}
+ (void)registerCellWithCollectionView:(UICollectionView *)collectionView forIndexPath:(NSIndexPath*)indexPath{
    NSString* kCellIdentifier = [[self class] description];
    NSString* identificate = [NSString stringWithFormat:@"%@%d_%d",kCellIdentifier,indexPath.section,indexPath.row];
    [collectionView registerNib:[UINib nibWithNibName:kCellIdentifier bundle:nil] forCellWithReuseIdentifier:identificate];
}

- (void)setDish:(RLKDish *)dish{
    _dish = dish;
    [_dishImageView sd_setImageWithURL:[NSURL URLWithString:dish.imageURL]];
    _nameLabel.text = dish.name;
    _describeLabel.text = dish.descirbe;
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
