//
//  ZTAlertView.h
//  ZTCarOwner
//
//  Created by ZWL on 2018/7/19.
//  Copyright © 2018 ZWL. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^ZTAlertViewCompleteHandler)(void);

@class ZTAlertAction;
@interface ZTAlertView : UIView

@property(nonatomic, strong) UIColor * titleColor;

@property(nonatomic, strong) UIColor * messageColor;

@property(nonatomic, assign) NSTextAlignment  messageAlignment;

@property(nonatomic, strong) id message;

@property(nonatomic, strong) NSDictionary * linkAttributes;


- (instancetype)initWithTitle:(NSString *)title message:(id)message actions:(NSArray<ZTAlertAction *> *)actions textFields:(NSArray<UITextField *> *)textFields;


/**
 添加链接
 
 @param url url
 @param range 链接位置
 */
- (void)addLinkToURL:(NSURL *)url withRange:(NSRange)range tapCompleteHandler:(ZTAlertViewCompleteHandler)completeHandler;

/**
 添加电话号码
 
 @param phoneNumber 电话号码
 @param range 电话号码位置
 */
- (void)addLinkToPhoneNumber:(NSString *)phoneNumber withRange:(NSRange)range tapCompleteHandler:(ZTAlertViewCompleteHandler)completeHandler;


/**
 添加自定义信息
 
 @param components 自定义信息
 @param range 位置
 */
- (void)addLinkToTransitInformation:(NSDictionary *)components withRange:(NSRange)range tapCompleteHandler:(ZTAlertViewCompleteHandler)completeHandler;

@end
