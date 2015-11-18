//
//  WCTabBar.h
//  WCCarInsurance
//
//  Created by Macx on 15/11/13.
//  Copyright © 2015年 Macx. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WCTabBar;

@protocol WCTabBarDelegate <NSObject>

@optional
/**
 *  告知代理当前选中按钮的索引
 */
- (void)tabBar:(WCTabBar *)tabBar didSelectedButtonIndex:(NSInteger)index;

@end

@interface WCTabBar : UIView

/**
 *  tabBarItem模型
 */
@property (nonatomic , strong)NSArray *items;

//代理
@property (nonatomic ,weak)id<WCTabBarDelegate>delegate;

@end
