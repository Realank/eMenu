//
//  DishDetailViewController.m
//  eMenuClient
//
//  Created by Realank on 2018/2/13.
//  Copyright © 2018年 Realank. All rights reserved.
//
#import "OrderCountView.h"
#import "DishDetailViewController.h"

@interface DishDetailViewController ()<OrderChangeDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *backScrollView;
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UIImageView *dishImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *stockLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet OrderCountView *orderStatusView;
@property (weak, nonatomic) IBOutlet UILabel *describeLabel;

@end

@implementation DishDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self configUI];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    _backScrollView.contentSize = CGSizeMake(0, _backView.height);
}
 
- (void)changeOrderCount:(BOOL)add{
    if (_delegate) {
        [_delegate wantOrder:add dish:_dish];
    }
}

- (void)setDish:(RLKDish *)dish{
    _dish = dish;
    [self configUI];
}

- (void)configUI{
    [_backScrollView setCornerRadius:10];
    [_dishImageView sd_setImageWithURL:[NSURL URLWithString:_dish.imageURL]];
    _nameLabel.text = _dish.name;
    _stockLabel.text = [NSString stringWithFormat:@"剩余%@份",_dish.stock];
    if (_dish.unit.length) {
        _priceLabel.text = [NSString stringWithFormat:@"¥%@/%@",_dish.price,_dish.unit];
    }else{
        _priceLabel.text = [NSString stringWithFormat:@"¥%@",_dish.price];
    }
    _orderStatusView.count = _dish.orderCount;
    _orderStatusView.delegate = self;
    _orderStatusView.showBorder = YES;
    _describeLabel.text = _dish.descirbe;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self dismissViewControllerAnimated:NO completion:nil];
}


@end
