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
@property (nonatomic, strong) RLKTable* table;
@property (weak, nonatomic) IBOutlet UILabel *resNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *resTableLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [_orderButton setRoundCornerRadius];
    self.view.backgroundColor = kThemeColor;
    self.title = @"点菜";
    [self login];
}

- (void)login{
    [SVProgressHUD show];
    [RLKTable loginWithAccount:@"chinacafe" andPassword:@"111111" result:^(RLKTable *table) {
        if (table.menu.dishes.count) {
            [SVProgressHUD dismiss];
            self.table = table;
            _resNameLabel.text = table.name;
            _resTableLabel.text = table.tableNumber;
        }else{
            [SVProgressHUD showErrorWithStatus:@"加载失败"];
        }
    }];
}


- (IBAction)orderAction:(id)sender {
    MenuViewController * vc = [[MenuViewController alloc] init];
    vc.menu = self.table.menu;
    [self.navigationController pushViewController:vc animated:YES];

}

@end
