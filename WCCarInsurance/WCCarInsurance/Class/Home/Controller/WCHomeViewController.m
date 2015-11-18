//
//  WCHomeViewController.m
//  WCCarInsurance
//
//  Created by Macx on 15/11/13.
//  Copyright © 2015年 Macx. All rights reserved.
//

#import "WCHomeViewController.h"
#import "WCCallButton.h"
#import "WCShowCell.h"

@implementation WCHomeViewController

static NSString *const WCShowCellID = @"show";
static NSString *const WCRecommentCellID = @"recommend";

- (void)viewDidLoad
{
    //self.view.backgroundColor = [UIColor redColor];
    [super viewDidLoad];
    [self setUpNavigationItem];
    [self setUpTableView];
}

/**
 *  设置导航条
 */
- (void)setUpNavigationItem
{
    self.navigationItem.title = @"超仔保驾";
    WCCallButton *button = [WCCallButton buttonWithType:UIButtonTypeCustom];
    button.bounds = CGRectMake(kNilOptions, kNilOptions, 2 * WCCommonMargin, 3 * WCCommonMargin);
    button.titleLabel.font = [UIFont systemFontOfSize:WCCommonMargin];
    [button setTitle:@"客服" forState:UIControlStateNormal];
    [button setTitleColor:WCBGColor(44, 126, 254) forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"icon_phone1"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"icon_phone_click"] forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(rightButtonItemClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
}

/**
 *  按钮点击事件
 */
- (void)rightButtonItemClick
{
    WCLogFunc;
}

/**
 *  设置表格
 */
- (void)setUpTableView
{
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[WCShowCell class] forCellReuseIdentifier:WCShowCellID];
    
}
@end
