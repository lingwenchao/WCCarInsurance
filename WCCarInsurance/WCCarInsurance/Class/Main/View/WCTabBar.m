//
//  WCTabBar.m
//  WCCarInsurance
//
//  Created by Macx on 15/11/13.
//  Copyright © 2015年 Macx. All rights reserved.
//

#import "WCTabBar.h"
#import "WCTabBarButton.h"

@interface WCTabBar()

/**
 *  记住按钮的选中状态
 */
@property (nonatomic , weak)WCTabBarButton *selectedButton;

@end

@implementation WCTabBar

/**
 *  重写模型
 */
- (void)setItems:(NSArray *)items
{
    _items = items;
    for (UITabBarItem *item in self.items){
        
        WCTabBarButton *button = [WCTabBarButton buttonWithType:UIButtonTypeCustom];
        
        button.backgroundColor = [UIColor whiteColor];
        
        [button setImage:item.image forState:UIControlStateNormal];
        [button setImage:item.selectedImage forState:UIControlStateSelected];
        
        //添加监听事件
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:button];
        
        if (self.subviews.count == 1){
            [self buttonClick:button];
        }
    }
}

/**
 *  重新布局item子控件位置
 */
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    NSInteger count = self.subviews.count;
    
    //CGFloat buttonX = 0;
    CGFloat buttonY = 0;
    CGFloat buttonW = self.WC_width / count;
    CGFloat buttonH = self.WC_height;
    
    for (NSInteger i = 0;i < count; i++){
        WCTabBarButton *button = self.subviews[i];
        button.tag = i;
        CGFloat buttonX = buttonW * i;
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
    }
}

/**
 *  按钮点击事件
 */
- (void)buttonClick:(WCTabBarButton *)button
{
    self.selectedButton.selected = NO;
    button.selected = YES;
    self.selectedButton = button;
    //切换界面
    if ([_delegate respondsToSelector:@selector(tabBar:didSelectedButtonIndex:)]) {
        [_delegate tabBar:self didSelectedButtonIndex:button.tag];
    }
}



@end
