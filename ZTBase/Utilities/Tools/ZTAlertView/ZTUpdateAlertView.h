//
//  ZTUpdateAlertView.h
//  ZTCarOwner
//
//  Created by ZWL on 2018/7/26.
//  Copyright © 2018 ZWL. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZTAlertAction;
@interface ZTUpdateAlertView : UIView

- (instancetype)initWithTitle:(NSString *)title message:(id)message actions:(NSArray<ZTAlertAction *> *)actions;

@end
