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

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [_orderButton setRoundCornerRadius];
}
- (IBAction)orderAction:(id)sender {
    [SVProgressHUD show];
    [RLKMenu loadWithResult:^(RLKMenu *menu) {
        if (menu.dishes.count) {
            [SVProgressHUD dismiss];
            MenuViewController * vc = [[MenuViewController alloc] init];
            vc.menu = menu;
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            [SVProgressHUD showErrorWithStatus:@"加载失败"];
        }
    }];
    
    
}

@end
