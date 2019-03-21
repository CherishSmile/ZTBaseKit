//
//  ZTAlertView.h
//  ZTCarOwner
//
//  Created by ZWL on 2018/7/19.
//  Copyright © 2018 ZWL. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZTAlertAction;
@interface ZTAlertView : UIView

@property(nonatomic, assign) NSTextAlignment  messageAlignment;

@property(nonatomic, strong) id message;

- (instancetype)initWithTitle:(NSString *)title message:(id)message actions:(NSArray<ZTAlertAction *> *)actions textFields:(NSArray<UITextField *> *)textFields;

@end
