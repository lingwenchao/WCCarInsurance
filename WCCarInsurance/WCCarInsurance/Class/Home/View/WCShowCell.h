//
//  WCShowCell.h
//  WCCarInsurance
//
//  Created by Macx on 15/11/14.
//  Copyright © 2015年 Macx. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WCShowCell;

@protocol WCShowCellDelegate <NSObject>

@optional

- (void)showCell:(WCShowCell *)showCell didClickOnButtonIndex:(NSInteger)buttonIndex;

@end

@interface WCShowCell : UITableViewCell

@property (nonatomic , weak)id<WCShowCellDelegate>delegate;

@end
