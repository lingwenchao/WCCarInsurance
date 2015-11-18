//
//  WCTabBarController.m
//  WCCarInsurance
//
//  Created by Macx on 15/11/13.
//  Copyright © 2015年 Macx. All rights reserved.
//

#import "WCTabBarController.h"
#import "WCNavigationController.h"
#import "WCHomeViewController.h"
#import "WCPriceListViewController.h"
#import "WCMeViewController.h"
#import "WCNavigationController.h"
#import "WCTabBar.h"

@interface WCTabBarController()<WCTabBarDelegate>

/**
 *  存储tabBarItem
 */
@property (nonatomic , strong)NSMutableArray *items;

@end

@implementation WCTabBarController

#pragma mark - 懒加载
- (NSMutableArray *)items
{
    if (!_items) {
        _items = [NSMutableArray array];
    }
    return _items;
}

#pragma mark - 初始化
/**
 *  移除系统自带tabBar
 */
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    for (UIView *childView in self.tabBar.subviews) {
        if (![childView isKindOfClass:[WCTabBar class]]) {
            [childView removeFromSuperview];
        }
    }
}

/**
 *  初始化设置
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setUpAllChildController];
    [self setUpTabBar];
    
}


/**
 *  自定义TabBar
 */
- (void)setUpTabBar
{
    WCTabBar *tabBar = [[WCTabBar alloc]init];
    tabBar.frame = self.tabBar.bounds;
    tabBar.items = self.items;
    tabBar.delegate = self;
    [self.tabBar addSubview:tabBar];
}


/**
 *  添加子控制器
 */
- (void)setUpAllChildController
{
    WCHomeViewController *home = [[WCHomeViewController alloc] init];
    [self setUpOneChildView:home image:[UIImage imageNamed:@"tab_home_nomal"] selectedImage:[UIImage imageNamed:@"tab_home_click"]];
    
    WCPriceListViewController *priceList = [[WCPriceListViewController alloc] init];
    [self setUpOneChildView:priceList image:[UIImage imageNamed:@"preferential_tab_nomal"] selectedImage:[UIImage imageNamed:@"preferential_tab_click"]];
    
    WCMeViewController *me = [[WCMeViewController alloc] init];
    [self setUpOneChildView:me image:[UIImage imageNamed:@"my_tab_nomal"] selectedImage:[UIImage imageNamed:@"my_tab_click"]];
    
    
}

/**
 *  设置每个子控制器
 */
- (void)setUpOneChildView:(UIViewController *)vc image:(UIImage *)image selectedImage:(UIImage *)selectedImage
{
    vc.tabBarItem.image = image;
    vc.tabBarItem.selectedImage = selectedImage;
    UINavigationController *nav = [[WCNavigationController alloc]initWithRootViewController:vc];
    
    [self.items addObject:nav.tabBarItem];
    
    [self addChildViewController:nav];
    
}

#pragma mark - <WCTabBarDelegate>
- (void)tabBar:(WCTabBar *)tabBar didSelectedButtonIndex:(NSInteger)index
{
    self.selectedIndex = index;
}

@end
