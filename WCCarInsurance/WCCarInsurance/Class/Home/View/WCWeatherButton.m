//
//  WCWeatherButton.m
//  WCCarInsurance
//
//  Created by Macx on 15/11/18.
//  Copyright © 2015年 Macx. All rights reserved.
//

#import "WCWeatherButton.h"

@implementation WCWeatherButton

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setTitle:@"北京" forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:@"WeatherArrow"] forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont systemFontOfSize:16.0];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.titleLabel.WC_x= 0;
    self.imageView.WC_x= CGRectGetMaxX(self.titleLabel.frame);
}

- (void)setHighlighted:(BOOL)highlighted {
    
}

@end
