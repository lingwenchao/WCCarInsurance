//
//  WCNavigationController.m
//  WCCarInsurance
//
//  Created by Macx on 15/11/13.
//  Copyright © 2015年 Macx. All rights reserved.
//

#import "WCNavigationController.h"

@interface WCNavigationController()<UIGestureRecognizerDelegate>

@end

@implementation WCNavigationController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.interactivePopGestureRecognizer.delegate = self;
    
}

#pragma mark - <UIGestureRecognizerDelegate>
/**
 *  每当用户触发手势时都会调用
 *
 *  @param gestureRecognizer 返回yes手势有效,no则无效
 *
 *  @return YES OR NO;
 */
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    return self.childViewControllers.count > 1;
}

/**
 *  当类第一次使用的时候调用
 */
+ (void)initialize{
        UINavigationBar *navBar = [UINavigationBar appearanceWhenContainedIn:self, nil];
        //设置导航条背景图片
        [navBar setBackgroundImage:[UIImage imageNamed:@"nav_bg"] forBarMetrics:UIBarMetricsDefault];
        NSMutableDictionary *navBarAttri = [NSMutableDictionary dictionary];
        navBarAttri[NSFontAttributeName] = [UIFont systemFontOfSize:18.0];
        [navBar setTitleTextAttributes:navBarAttri];
    
}

/**
 *  重写push方法
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count != 0) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:@"nav_arrow"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(backButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [button sizeToFit];
        button.contentEdgeInsets = UIEdgeInsetsMake(kNilOptions, -WCCommonMargin * 2, kNilOptions, kNilOptions);
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

- (void)backButtonClick
{
    [self popViewControllerAnimated:YES];
}
@end
