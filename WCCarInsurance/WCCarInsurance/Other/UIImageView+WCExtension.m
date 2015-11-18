//
//  UIImageView+WCExtension.m
//  WCCarInsurance
//
//  Created by Macx on 15/11/18.
//  Copyright © 2015年 Macx. All rights reserved.
//

#import "UIImageView+WCExtension.h"
#import <UIImageView+WebCache.h>
@implementation UIImageView (WCExtension)

- (void)setUpImageWithUrl:(NSString *)url
{
    UIImage *placeholderImage = [UIImage imageNamed:@"bg_coupons"];
    __weak typeof(self) weakSelf = self;
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:placeholderImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (error) return ;
        weakSelf.image = image ? image:placeholderImage;
    }];
    
}

@end
