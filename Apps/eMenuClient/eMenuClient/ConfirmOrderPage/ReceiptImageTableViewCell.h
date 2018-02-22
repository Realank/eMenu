//
//  ReceiptImageTableViewCell.h
//  eMenuClient
//
//  Created by Realank on 2018/2/22.
//  Copyright © 2018年 Realank. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReceiptImageTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *receiptImageView;

+ (instancetype)cellWithTableView:(UITableView *)tableView;


@end
