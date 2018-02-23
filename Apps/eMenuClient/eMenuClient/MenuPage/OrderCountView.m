//
//  OrderCountView.m
//  eMenuClient
//
//  Created by Realank on 2018/2/13.
//  Copyright © 2018年 Realank. All rights reserved.
//

#import "OrderCountView.h"

@interface OrderCountView()

@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIView *orderBackView;
@property (weak, nonatomic) IBOutlet UIButton *orderButton;
@property (weak, nonatomic) IBOutlet UIButton *disOrderButton;
@property (weak, nonatomic) IBOutlet UILabel *orderCountLabel;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *orderBackViewWidthConstraint;

@end

IB_DESIGNABLE
@implementation OrderCountView
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setupView];
    }
    return self;
}

- (void)setShowBorder:(BOOL)showBorder{
    _showBorder = showBorder;
    if (_showBorder) {
        [self.orderBackView setBorderColor:kThemeColor width:1];
    }
}


- (void)setupView{
    [[NSBundle mainBundle] loadNibNamed:@"OrderCountView" owner:self options:nil];
    [self addSubview:self.contentView];
    [self.orderBackView setRoundCornerRadius];
    self.orderBackView.tintColor = kThemeColor;
    self.orderBackView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.9];
    self.orderCountLabel.textColor = kThemeColor;
    [self updateOrderStatus];
}

- (void)awakeFromNib{
    [super awakeFromNib];

}

- (void)updateOrderStatus{
    __weak typeof(self) weakSelf = self;
    if (_count == 0) {
        
        [UIView animateWithDuration:0.0 animations:^{
            weakSelf.disOrderButton.hidden = YES;
            weakSelf.orderCountLabel.hidden = YES;
            weakSelf.orderBackViewWidthConstraint.constant = 44;
            weakSelf.orderBackViewWidthConstraint.active = YES;
            [weakSelf layoutIfNeeded];
        }];
        
        
    }else{
        
        _orderCountLabel.text = [NSString stringWithFormat:@"%d",(int)_count];
        [UIView animateWithDuration:0.0 animations:^{
            weakSelf.disOrderButton.hidden = NO;
            weakSelf.orderCountLabel.hidden = NO;
            weakSelf.orderBackViewWidthConstraint.active = NO;
            [weakSelf layoutIfNeeded];
        }];
        
    }
    
}

- (void)setCount:(NSInteger)count{
    _count = count;
    [self updateOrderStatus];
}

- (IBAction)orderAction:(id)sender {
    _count++;
    if (_delegate) {
        [_delegate changeOrderCount:YES];
    }
    [self updateOrderStatus];
}
- (IBAction)disOrderAction:(id)sender {
    _count--;
    if (_delegate) {
        [_delegate changeOrderCount:NO];
    }
    [self updateOrderStatus];
}

@end
