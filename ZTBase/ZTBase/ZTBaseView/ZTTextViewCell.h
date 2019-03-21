//
//  ZTTextViewCell.h
//  ZTCloudMirror
//
//  Created by ZWL on 2017/11/23.
//  Copyright © 2017年 中通四局. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZTInputModel.h"

@class ZTTextViewCell;
@protocol ZTTextViewCellDelegate <NSObject>
-(void)textViewCellDidChange:(ZTTextViewCell *)textViewCell textString:(NSString *)text;
@end

@interface ZTTextViewCell : UITableViewCell
@property(nonatomic,weak)id<ZTTextViewCellDelegate> delegate;
@property(nonatomic,strong)ZTInputModel *model;
@end
