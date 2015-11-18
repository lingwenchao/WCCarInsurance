//
//  WCCallButton.m
//  WCCarInsurance
//
//  Created by Macx on 15/11/14.
//  Copyright © 2015年 Macx. All rights reserved.
//

#import "WCCallButton.h"

@implementation WCCallButton

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.imageView.WC_x = kNilOptions;
    self.imageView.WC_y = kNilOptions;
    self.titleLabel.WC_x = kNilOptions;
    self.titleLabel.WC_y = CGRectGetMaxY(self.imageView.frame);
    self.titleLabel.WC_width = self.WC_width;
    self.titleLabel.WC_height = self.WC_height - self.imageView.WC_height ; 
}

@end
