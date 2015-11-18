//
//  WCShowCell.m
//  WCCarInsurance
//
//  Created by Macx on 15/11/14.
//  Copyright © 2015年 Macx. All rights reserved.
//

#import "WCShowCell.h"
#import "WCShowButton.h"

@interface WCShowCell()

@property (nonatomic , strong)NSMutableArray *buttons;

@end

@implementation WCShowCell

#pragma mark - 懒加载
- (NSMutableArray *)buttons
{
    if (!_buttons) {
        _buttons = [NSMutableArray array];
    }
    return  _buttons;
}

#pragma mark - 初始化
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpContenButton];
    }
    return self;
}

- (void)awakeFromNib
{
    [self setUpContenButton];
}

/**
 *  添加子控件
 */
- (void)setUpContenButton
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = WCCommentBackgroundColor;
    CGFloat priceW = WCScreenWidth * 0.45;
    CGFloat priceH = priceW * 1.3;
    [self setUpButtonWithFrame:CGRectMake(kNilOptions, kNilOptions, priceW, priceH) image:@"car_bj"];
    
    CGFloat peccancyX = priceW;
    CGFloat peccancyW = WCScreenWidth - priceW;
    CGFloat peccancyH = peccancyW * 0.5;
    [self setUpButtonWithFrame:CGRectMake(peccancyX, kNilOptions, peccancyW, peccancyH) image:@"car_wz"];
    
    CGFloat compensateX = peccancyX;
    CGFloat compensateY = peccancyH;
    CGFloat compensateH = priceH - peccancyH;
    CGFloat compensateW = compensateH * 0.93;
    [self setUpButtonWithFrame:CGRectMake(compensateX, compensateY, compensateW, compensateH) image:@"car_lp"];
    
    CGFloat maintainX = compensateX + compensateW;
    CGFloat maintainY = compensateY;
    CGFloat maintainW = WCScreenWidth - priceW - compensateW;
    CGFloat maintainH = compensateH;
    [self setUpButtonWithFrame:CGRectMake(maintainX, maintainY, maintainW, maintainH) image:@"smby"];
    
    CGFloat vipY = priceH + WCcommonSmallMargin;
    CGFloat vipH = WCScreenWidth * 0.2;
    [self setUpButtonWithFrame:CGRectMake(kNilOptions, vipY, WCScreenWidth, vipH) image:@"carowner"];
}

/**
 *  添加按钮
 */
- (void)setUpButtonWithFrame:(CGRect)frame image:(NSString *)image
{
    WCShowButton *button = [WCShowButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    [button setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [self addSubview:button];
    [self.buttons addObject:button];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
}

/**
 *  按钮点击事件
 */
- (void)buttonClick:(UIButton *)button {
    NSInteger index = [self.buttons indexOfObject:button];
    if ([self.delegate respondsToSelector:@selector(showCell:didClickOnButtonIndex:)]) {
        [self.delegate showCell:self didClickOnButtonIndex:index];
    }
}
@end
