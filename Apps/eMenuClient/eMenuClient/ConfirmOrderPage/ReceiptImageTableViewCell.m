//
//  ReceiptImageTableViewCell.m
//  eMenuClient
//
//  Created by Realank on 2018/2/22.
//  Copyright © 2018年 Realank. All rights reserved.
//

#import "ReceiptImageTableViewCell.h"

@implementation ReceiptImageTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    NSString* kCellIdentifier = [[self class] description];
    id cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    if (cell == nil) {
        [tableView registerNib:[UINib nibWithNibName:kCellIdentifier bundle:nil] forCellReuseIdentifier:kCellIdentifier];
        cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    }
    return cell;
}



@end
