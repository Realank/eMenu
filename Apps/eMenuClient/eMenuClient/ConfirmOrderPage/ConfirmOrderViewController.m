//
//  ConfirmOrderViewController.m
//  eMenuClient
//
//  Created by Realank on 2018/2/22.
//  Copyright © 2018年 Realank. All rights reserved.
//

#import "ConfirmOrderViewController.h"
#import "ReceiptImageTableViewCell.h"
#import "DishCheckTableViewCell.h"

@interface ConfirmOrderViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UIButton *confirmButton;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UITableView *dishesListView;
@property (nonatomic, weak) UIView* headerView;

@end

@implementation ConfirmOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = kThemeColor;
    self.title = @"确认下单";
    [self setupTableView];
    _priceLabel.text = [NSString stringWithFormat:@"¥%.1f",[_menu totalOrderPrice]];
    [_confirmButton setRoundCornerRadius];
    [_confirmButton setTitleColor:kThemeColor forState:UIControlStateNormal];
}
- (IBAction)confirmOrderAction:(id)sender {
    [_menu clearAllOrders];
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)cancelAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)setupTableView{
    self.dishesListView.delegate = self;
    self.dishesListView.dataSource = self;
    UIView* header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 344, 0)];
    header.backgroundColor = [UIColor whiteColor];
    [self.dishesListView addSubview:header];
    _headerView = header;
}

#pragma mark - table view delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGPoint offset = scrollView.contentOffset;
    if (offset.y < 0) {
        CGRect rect = _headerView.bounds;
        rect.origin.y = offset.y;
        rect.size.height = -offset.y;
        _headerView.frame = rect;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSInteger row = indexPath.row;
    NSArray* dishes = _menu.orderedDishes;
    if (row < dishes.count) {
        RLKDish* dish = dishes[row];
        DishCheckTableViewCell* cell = [DishCheckTableViewCell cellWithTableView:tableView];
        cell.dish = dish;
        return cell;
    }else{
        ReceiptImageTableViewCell* cell = [ReceiptImageTableViewCell cellWithTableView:tableView];
        cell.receiptImageView.image = [UIImage imageNamed:@"receiptFooter"];
        return cell;
    }
    
    return nil;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return (_menu.orderedDishes.count + 1);
}



@end
