//
//  UIView+Extension.m
//  
//
//  Created by Realank on 15/7/27.
//  Copyright (c) 2015年 Realank. All rights reserved.
//

#import "UIView+Extension.h"

@implementation UIView (Extension)


- (void)setX:(CGFloat)x{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)x{
    return self.frame.origin.x;
}

- (void)setY:(CGFloat)y{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)y{
    return self.frame.origin.y;
}


- (void)setWidth:(CGFloat)width{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)width{
    return self.frame.size.width;
}

- (void)setHeight:(CGFloat)height{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)height{
    return self.frame.size.height;
}


- (void)setCenterX:(CGFloat)centerX{
    CGPoint point = self.center;
    point.x = centerX;
    self.center = point;
}

- (CGFloat)centerX{
    return self.center.x;
}

- (void)setCenterY:(CGFloat)centerY{
    CGPoint point = self.center;
    point.y = centerY;
    self.center = point;
}

- (CGFloat)centerY{
    return self.center.y;
}

- (void)setSize:(CGSize)size{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}


- (CGSize)size{
    return self.frame.size;
}

- (void)setCornerRadius:(CGFloat)radius{
    self.layer.cornerRadius = radius;
    self.clipsToBounds = YES;
}

- (void)setRoundCornerRadius{
    self.layer.cornerRadius = self.layer.bounds.size.height/2.0;
}

- (void)setBorderColor:(UIColor*)color width:(CGFloat)width{
    self.layer.borderColor = color.CGColor;
    self.layer.borderWidth = width;
}

- (void)setShadowColor:(UIColor*)color offset:(CGSize)offset radius:(CGFloat)radius opacity:(CGFloat)opacity{
    self.layer.shadowColor = color.CGColor;
    self.layer.shadowOffset = offset;
    self.layer.shadowRadius = radius;
    self.layer.shadowOpacity = opacity;
//    self.layer.masksToBounds = NO;
}

@end
