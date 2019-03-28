//
//  ZTTextFieldCell.h
//  ZTCloudMirror
//
//  Created by ZWL on 2017/11/23.
//  Copyright © 2017年 中通四局. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZTInputModel.h"
#import "ZTInputDelegate.h"

@class ZTTextFieldCell;
@protocol ZTTextFieldCellDelegate <ZTInputDelegate>
@optional

-(void)textFieldCellDidTapTitle:(ZTTextFieldCell *)textFieldCell;

-(void)textFieldCellDidTapTextField:(ZTTextFieldCell *)textFieldCell;


@end

@interface ZTTextFieldCell : UITableViewCell
@property(nonatomic,weak)id<ZTTextFieldCellDelegate> delegate;
@property(nonatomic,strong)ZTInputModel *model;
@end
