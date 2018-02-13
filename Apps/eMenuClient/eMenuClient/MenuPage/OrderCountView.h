//
//  OrderCountView.h
//  eMenuClient
//
//  Created by Realank on 2018/2/13.
//  Copyright © 2018年 Realank. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol OrderChangeDelegate

- (void)changeOrderCount:(BOOL)add;

@end

IB_DESIGNABLE
@interface OrderCountView : UIView

@property (nonatomic, assign) IBInspectable NSInteger count;
@property (nonatomic, weak) id<OrderChangeDelegate> delegate;
@end
