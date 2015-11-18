//
//  WCRecommend.h
//  WCCarInsurance
//
//  Created by Macx on 15/11/18.
//  Copyright © 2015年 Macx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WCRecommend : NSObject

/** 图片 */
@property (nonatomic, copy) NSString *posterLink;
/** 标题 */
@property (nonatomic, copy) NSString *title;
/** 介绍 */
@property (nonatomic, copy) NSString *intro;
/** 连接 */
@property (nonatomic, copy) NSString *webLink;

@end
