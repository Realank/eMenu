//
//  UIView+Extension.h
//
//
//  Created by Realank on 15/7/27.
//  Copyright (c) 2015年 Realank. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Extension)
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;

- (void)setCornerRadius:(CGFloat)radius;
- (void)setRoundCornerRadius;
- (void)setBorderColor:(UIColor*)color width:(CGFloat)width;
- (void)setShadowColor:(UIColor*)color offset:(CGSize)offset radius:(CGFloat)radius opacity:(CGFloat)opacity;
@end
