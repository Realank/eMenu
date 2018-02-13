//
//  CartViewController.m
//  eMenuClient
//
//  Created by Realank on 2018/2/13.
//  Copyright © 2018年 Realank. All rights reserved.
//

#import "CartViewController.h"

@interface CartViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UIButton *orderButton;
@property (weak, nonatomic) IBOutlet UITableView *orderedDishListView;

@end

@implementation CartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _priceLabel.text = [NSString stringWithFormat:@"¥%.1f",[_menu totalOrderPrice]];
    [_orderButton setRoundCornerRadius];
    [self setupTableView];
}

- (void)setupTableView{
    _orderedDishListView.delegate = self;
    _orderedDishListView.dataSource = self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _menu.orderedDishes.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row = indexPath.row;
    UITableViewCell* cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    RLKDish* dish = _menu.orderedDishes[row];
    cell.textLabel.text = dish.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%d",(int)dish.orderCount];
    
    cell.textLabel.textColor = [UIColor darkGrayColor];
    cell.backgroundColor = [UIColor clearColor];
    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.bounds];
    cell.selectedBackgroundView.backgroundColor = [UIColor whiteColor];
    return cell;
    
}

@end
