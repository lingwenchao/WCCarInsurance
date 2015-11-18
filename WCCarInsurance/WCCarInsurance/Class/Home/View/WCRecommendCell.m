//
//  WCRecommendCell.m
//  WCCarInsurance
//
//  Created by Macx on 15/11/18.
//  Copyright © 2015年 Macx. All rights reserved.
//

#import "WCRecommendCell.h"
#import "WCRecommend.h"
@interface WCRecommendCell()

@property (weak, nonatomic) IBOutlet UIImageView *posterLinkImageView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *introLabel;
@property (weak, nonatomic) IBOutlet UIView *separatorView;

@end

@implementation WCRecommendCell

- (void)awakeFromNib {
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.separatorView.hidden = NO;
}

- (void)setRecommend:(WCRecommend *)recommend
{
    _recommend = recommend;
    
    self.titleLabel.text = recommend.title;
    self.introLabel.text = recommend.intro;
    [self.posterLinkImageView setUpImageWithUrl:recommend.posterLink];
    
}


@end
