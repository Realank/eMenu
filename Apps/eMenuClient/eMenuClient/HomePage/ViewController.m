//
//  ViewController.m
//  eMenuClient
//
//  Created by Realank on 2018/2/12.
//  Copyright © 2018年 Realank. All rights reserved.
//

#import "ViewController.h"
#import "MenuViewController.h"


@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *orderButton;
@property (nonatomic, strong) RLKRestaurant* restuarant;
@property (weak, nonatomic) IBOutlet UILabel *resNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *resTableLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [_orderButton setRoundCornerRadius];
    [self login];
}

- (void)login{
    [SVProgressHUD show];
    [RLKRestaurant loginWithAccount:@"chinacafe" andPassword:@"111111" result:^(RLKRestaurant *restaurant) {
        if (restaurant.menu.dishes.count) {
            [SVProgressHUD dismiss];
            self.restuarant = restaurant;
            _resNameLabel.text = restaurant.name;
            _resTableLabel.text = [NSString stringWithFormat:@"%@桌",restaurant.tableCount];
        }else{
            [SVProgressHUD showErrorWithStatus:@"加载失败"];
        }
    }];
}


- (IBAction)orderAction:(id)sender {
    MenuViewController * vc = [[MenuViewController alloc] init];
    vc.menu = self.restuarant.menu;
    [self.navigationController pushViewController:vc animated:YES];

}

@end
