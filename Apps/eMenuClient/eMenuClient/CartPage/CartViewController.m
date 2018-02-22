//
//  CartViewController.m
//  eMenuClient
//
//  Created by Realank on 2018/2/13.
//  Copyright © 2018年 Realank. All rights reserved.
//

#import "CartViewController.h"
#import "DishSampleTableViewCell.h"
@interface CartViewController ()<UITableViewDelegate, UITableViewDataSource,DishOrderChangeDelegate>
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UIButton *orderButton;
@property (weak, nonatomic) IBOutlet UITableView *orderedDishListView;

@end

@implementation CartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [_orderButton setRoundCornerRadius];
    _orderButton.backgroundColor = kThemeColor;
    [self setupTableView];
}

- (void)setupTableView{
    _orderedDishListView.delegate = self;
    _orderedDishListView.dataSource = self;
    [self reloadData];
}

- (IBAction)checkAction:(id)sender {
    [self dismissViewControllerAnimated:NO completion:nil];
    if (_goCheckDelegate) {
        [_goCheckDelegate goCheck];
    }
}

- (void)wantOrder:(BOOL)order dish:(RLKDish *)dish{
    if (_orderChangeDelegate) {
        [_orderChangeDelegate wantOrder:order dish:dish];
    }
    [self reloadData];
}

- (void)reloadData{
    [_orderedDishListView reloadData];
    _priceLabel.text = [NSString stringWithFormat:@"¥%.1f",[_menu totalOrderPrice]];
    _orderButton.enabled = (_menu.orderedDishes.count > 0);
}

#pragma mark - table view delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _menu.orderedDishes.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row = indexPath.row;
    DishSampleTableViewCell* cell = [DishSampleTableViewCell cellWithTableView:tableView];
    RLKDish* dish = _menu.orderedDishes[row];
    cell.dish = dish;
    cell.delegate = self;
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [DishSampleTableViewCell cellHeight];
}


@end
