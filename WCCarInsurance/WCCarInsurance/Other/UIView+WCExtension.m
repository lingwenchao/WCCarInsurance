//
//  UIView+WCExtension.m
//  项目实战1
//
//  Created by Macx on 15/11/6.
//  Copyright © 2015年 Macx. All rights reserved.
//

#import "UIView+WCExtension.h"

@implementation UIView (WCExtension)

- (void)setWC_width:(CGFloat)WC_width
{
    CGRect frame = self.frame;
    frame.size.width = WC_width;
    self.frame = frame;
}

- (CGFloat)WC_width{
    return self.frame.size.width;
}

- (void)setWC_height:(CGFloat)WC_height
{
    CGRect frame = self.frame;
    frame.size.height = WC_height;
    self.frame = frame;
}

- (CGFloat)WC_height
{
    return self.frame.size.height;
}

- (CGFloat)WC_x
{
    return self.frame.origin.x;
}

- (void)setWC_x:(CGFloat)WC_x
{
    CGRect frame = self.frame;
    frame.origin.x = WC_x;
    self.frame = frame;
}

- (CGFloat)WC_y
{
    return self.frame.origin.y;
}

- (void)setWC_y:(CGFloat)WC_y
{
    CGRect frame = self.frame;
    frame.origin.y = WC_y;
    self.frame = frame;
}

- (CGFloat)WC_centerX
{
    return self.center.x;
}

- (void)setWC_centerX:(CGFloat)WC_centerX
{
    CGPoint center = self.center;
    center.x = WC_centerX;
    self.center = center;
}

- (CGFloat)WC_centerY
{
    return self.center.y;
}

- (void)setWC_centerY:(CGFloat)WC_centerY
{
    CGPoint center = self.center;
    center.y = WC_centerY;
    self.center = center;
}

- (CGFloat)WC_right
{
    //    return self.xmg_x + self.xmg_width;
    return CGRectGetMaxX(self.frame);
}

- (CGFloat)WC_bottom
{
    //    return self.xmg_y + self.xmg_height;
    return CGRectGetMaxY(self.frame);
}

- (void)setWC_right:(CGFloat)WC_right
{
    self.WC_x = WC_right - self.WC_width;
}

- (void)setWC_bottom:(CGFloat)WC_bottom
{
    self.WC_y = WC_bottom - self.WC_height;
}


@end
