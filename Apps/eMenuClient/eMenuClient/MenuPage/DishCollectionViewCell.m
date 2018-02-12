//
//  DishCollectionViewCell.m
//  eMenuClient
//
//  Created by Realank on 2018/2/12.
//  Copyright © 2018年 Realank. All rights reserved.
//

#import "DishCollectionViewCell.h"

@interface DishCollectionViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *dishImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *describeLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UIView *orderBackView;
@property (weak, nonatomic) IBOutlet UIButton *orderButton;
@property (weak, nonatomic) IBOutlet UIButton *disOrderButton;
@property (weak, nonatomic) IBOutlet UILabel *orderCountLabel;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *orderBackViewWidthConstraint;

@end

@implementation DishCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self setCornerRadius:5];
    [self.orderBackView setRoundCornerRadius];
    self.orderBackView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.8];
}

+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView forIndexPath:(NSIndexPath*)indexPath{
    NSString* kCellIdentifier = [[self class] description];
    NSString* identifierName = [NSString stringWithFormat:@"%@%ld",kCellIdentifier,indexPath.row];
    id cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifierName forIndexPath:indexPath];
    return cell;
}
+ (void)registerCellWithCollectionView:(UICollectionView *)collectionView forIndexPath:(NSIndexPath*)indexPath{
    NSString* kCellIdentifier = [[self class] description];
    NSString* identifierName = [NSString stringWithFormat:@"%@%ld",kCellIdentifier,indexPath.row];
    [collectionView registerNib:[UINib nibWithNibName:kCellIdentifier bundle:nil] forCellWithReuseIdentifier:identifierName];
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
    [self updateOrderStatus];
}

- (void)updateOrderStatus{
    __weak typeof(self) weakSelf = self;
    if (_dish.orderCount == 0) {
        
        [UIView animateWithDuration:0.2 animations:^{
            weakSelf.disOrderButton.hidden = YES;
            weakSelf.orderCountLabel.hidden = YES;
            weakSelf.orderBackViewWidthConstraint.constant = 44;
            weakSelf.orderBackViewWidthConstraint.active = YES;
            [weakSelf layoutIfNeeded];
        }];
        
        
    }else{
        
        _orderCountLabel.text = [NSString stringWithFormat:@"%d",(int)_dish.orderCount];
        [UIView animateWithDuration:0.2 animations:^{
            weakSelf.disOrderButton.hidden = NO;
            weakSelf.orderCountLabel.hidden = NO;
            weakSelf.orderBackViewWidthConstraint.active = NO;
            [weakSelf layoutIfNeeded];
        }];
        
    }
    
}
- (IBAction)orderAction:(id)sender {
    _dish.orderCount += 1;
    [self updateOrderStatus];
}
- (IBAction)disOrderAction:(id)sender {
    _dish.orderCount -= 1;
    [self updateOrderStatus];
}

@end
