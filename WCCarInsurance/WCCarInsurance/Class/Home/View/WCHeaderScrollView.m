//
//  WCHeaderScrollView.m
//  WCCarInsurance
//
//  Created by Macx on 15/11/18.
//  Copyright © 2015年 Macx. All rights reserved.
//

#import "WCHeaderScrollView.h"

#import <AFNetworking.h>
#import <MJExtension.h>
#import <UIButton+WebCache.h>
#import "WCWeather.h"
#import "WCWeatherButton.h"
#import "WCHeaderScrollViewModel.h"

static CGFloat const moveImageTimer = 5.0;

@interface WCHeaderScrollView()<UIScrollViewDelegate>

/** 图片轮播器 */
@property (nonatomic, weak) UIScrollView *scrollView;
/** 页码管理器 */
@property (nonatomic, weak) UIPageControl *pageControl;
/** 当前视图 */
@property (nonatomic, weak) UIImageView *currentImageView;
/** 上一个视图 */
@property (nonatomic, weak) UIImageView *prefixImageView;
/** 下一个视图 */
@property (nonatomic, weak) UIImageView *nextImageView;
/** 当前图片的下标 */
@property (nonatomic, assign) NSInteger currentImageIndex;
/** 请求管理者 */
@property (nonatomic, weak) AFHTTPSessionManager *manager;
/** 滚动视图模型数组 */
@property (nonatomic, strong) NSArray *headerScrollViewModels;
/** 天气界面 */
@property (nonatomic, weak) UIView *weatherView;
/** 天气城市按钮 */
@property (nonatomic, weak) WCWeatherButton *chooseCityButton;
/** 显示天气按钮 */
@property (nonatomic, weak) UIButton *weatherButton;
/** 加载天气 */
@property (nonatomic, weak) UIActivityIndicatorView *weatherLoadingView;
/** 天气模型 */
@property (nonatomic, strong) WCWeather *wether;
/** 天气温度 */
@property (nonatomic, weak) UILabel *tempLabel;
/** 天气状况 */
@property (nonatomic, weak) UILabel *weatherLabel;
/** 洗车状况 */
@property (nonatomic, weak) UILabel *clearCarLabel;
/** 定时器 */
@property (nonatomic, strong) NSTimer *moveTimer;
/** 是否手动滚动轮播 */
@property (nonatomic, assign, getter=isMoveAuto) BOOL moveAuto;

@end

@implementation WCHeaderScrollView

#pragma mark - 懒加载
- (AFHTTPSessionManager *)manager
{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

- (UILabel *)tempLabel {
    if (!_tempLabel) {
        UILabel *tempLabel = [[UILabel alloc] init];
        tempLabel.WC_x = CGRectGetMaxX(self.weatherButton.frame) + WCcommonSmallMargin;
        tempLabel.WC_y = self.weatherButton.WC_y + WCcommonSmallMargin;
        tempLabel.WC_width = WCCommonMargin * 14;
        tempLabel.WC_height = self.weatherButton.WC_height * 0.5;
        tempLabel.font = [UIFont boldSystemFontOfSize:25.0];
        tempLabel.textColor = [UIColor whiteColor];
        _tempLabel = tempLabel;
        [self.weatherView addSubview:tempLabel];
    }
    return _tempLabel;
}

- (UILabel *)weatherLabel {
    if (!_weatherLabel) {
        UILabel *weatherLabel = [[UILabel alloc] init];
        weatherLabel.WC_x = self.tempLabel.WC_x;
        weatherLabel.WC_y = CGRectGetMaxY(self.tempLabel.frame);
        weatherLabel.WC_width = self.tempLabel.WC_width;
        weatherLabel.WC_height = CGRectGetMaxY(self.weatherButton.frame) - CGRectGetMaxY(self.tempLabel.frame);
        weatherLabel.font = [UIFont systemFontOfSize:15.0];
        weatherLabel.textColor = [UIColor whiteColor];
        _weatherLabel = weatherLabel;
        [self.weatherView addSubview:weatherLabel];
    }
    return _weatherLabel;
}

- (UILabel *)clearCarLabel {
    if (!_clearCarLabel) {
        UILabel *clearCarLabel = [[UILabel alloc] init];
        clearCarLabel.WC_x = CGRectGetMaxX(self.tempLabel.frame);
        clearCarLabel.WC_y  = self.tempLabel.WC_y + WCcommonSmallMargin;
        clearCarLabel.WC_width = self.weatherLabel.WC_width;
        clearCarLabel.WC_height = self.weatherLabel.WC_height;
        clearCarLabel.font = [UIFont systemFontOfSize:16.0];
        clearCarLabel.textColor = [UIColor whiteColor];
        _clearCarLabel = clearCarLabel;
        [self.weatherView addSubview:clearCarLabel];
    }
    return _clearCarLabel;
}

#pragma mark - 初始化
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self loadData];
    }
    return self;
}


/**
 *  加载数据
 */
- (void)loadData {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"type"] = @1;
    __weak typeof(self) weakSelf = self;
    [self.manager POST:WCRecommendRequest parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        weakSelf.headerScrollViewModels = [WCHeaderScrollViewModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"POSTER"]];
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [self setUpScrollView];
            [self setUpPageControl];
            [self setUpImageView];
            [self setUpWeatherReport];
        }];
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        
    }];
}

/**
 *  设置滚动容器
 */
- (void)setUpScrollView
{
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    scrollView.bounces = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.pagingEnabled = YES;
    scrollView.delegate = self;
    scrollView.contentSize = CGSizeMake(3 * self.WC_width, kNilOptions);
    self.scrollView = scrollView;
    [self addSubview:scrollView];
#warning 不知道啥意思
    if (self.headerScrollViewModels.count == 0 || self.headerScrollViewModels.count == 1) {
        scrollView.userInteractionEnabled = NO;
        return;
    }
    [self.scrollView setContentOffset:CGPointMake(self.WC_width, kNilOptions) animated:NO];
    self.moveTimer = [NSTimer scheduledTimerWithTimeInterval:moveImageTimer target:self selector:@selector(animateMoveImage) userInfo:nil repeats:YES];
    self.moveAuto = NO;
}

/**
 *  设置页码管理器
 */
- (void)setUpPageControl {
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    pageControl.WC_x = kNilOptions;
    pageControl.WC_width = self.WC_width;
    pageControl.WC_height = WCCommonMargin;
    pageControl.WC_y = self.WC_height - WCCommonMargin - WCcommonSmallMargin;
    pageControl.numberOfPages = self.headerScrollViewModels.count;
    pageControl.currentPage = kNilOptions;
    pageControl.currentPageIndicatorTintColor = WCNavigationColor;
    pageControl.pageIndicatorTintColor = WCCommentBackgroundColor;
    pageControl.enabled = NO;
    self.pageControl = pageControl;
    [self addSubview:pageControl];
}

- (void)setUpImageView
{
    
}

- (void)setUpWeatherReport
{
    
}

#pragma mark - 定时器自动轮播
- (void)animateMoveImage {
    [self.scrollView setContentOffset:CGPointMake(2 *self.WC_width, kNilOptions) animated:YES];
    self.moveAuto = YES;
    [NSTimer scheduledTimerWithTimeInterval:0.4 target:self selector:@selector(scrollViewDidEndDecelerating:) userInfo:nil repeats:NO];
}

@end
