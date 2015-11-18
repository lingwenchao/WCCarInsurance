//
//  WCWeather.h
//  WCCarInsurance
//
//  Created by Macx on 15/11/18.
//  Copyright © 2015年 Macx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WCWeather : NSObject

/** 天气图标 */
@property (nonatomic, copy) NSString *img;
/** 温度 */
@property (nonatomic, copy) NSString *temp;
/** 洗车状况 */
@property (nonatomic, copy) NSString *index_xc;
/** 天气状况 */
@property (nonatomic, copy) NSString *weather;

@end
