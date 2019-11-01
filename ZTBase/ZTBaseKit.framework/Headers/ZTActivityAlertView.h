//
//  ZTActivityAlertView.h
//  ZTCarOwner
//
//  Created by ZWL on 2018/7/5.
//  Copyright © 2018 ZWL. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ZTActivityAlertViewBlock)(void);

@interface ZTActivityAlertView : UIView

@property(nonatomic, strong) id imageObject;

@property(nonatomic, copy) ZTActivityAlertViewBlock closeBlock;
@property(nonatomic, copy) ZTActivityAlertViewBlock sureBlock;

@end
