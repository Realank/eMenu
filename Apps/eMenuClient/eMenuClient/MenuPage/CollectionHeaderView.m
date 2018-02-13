//
//  CollectionHeaderView.m
//  eMenuClient
//
//  Created by Realank on 2018/2/13.
//  Copyright © 2018年 Realank. All rights reserved.
//

#import "CollectionHeaderView.h"

@implementation CollectionHeaderView

- (void)awakeFromNib{
    [super awakeFromNib];
//    [self setBorderColor:[UIColor lightGrayColor] width:1];
//    [self setCornerRadius:5];
    self.backgroundColor = [kThemeColor colorWithAlphaComponent:0.7];;
}

@end
