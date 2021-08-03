//
//  ZTAlertController.h
//  ZTCarOwner
//
//  Created by ZWL on 2018/7/10.
//  Copyright © 2018 ZWL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
//! Project version number for ZTAlertController.
FOUNDATION_EXPORT double ZTAlertControllerVersionNumber;

//! Project version string for ZTAlertController.
FOUNDATION_EXPORT const unsigned char ZTAlertControllerVersionString[];



// In this header, you should import all the public headers of your framework using statements like #import <ZTAlertController/PublicHeader.h>
#import <ZTAlertController/ZTActivityAlertView.h>
#import <ZTAlertController/ZTAlertView.h>
#import <ZTAlertController/ZTAnimationManager.h>
#import <ZTAlertController/ZTDatePicker.h>
#import <ZTAlertController/ZTUpdateAlertView.h>

NS_ASSUME_NONNULL_BEGIN

static NSString * const ZTAlertResource = @"Frameworks/ZTAlertController.framework/Resource";


typedef NS_ENUM(NSInteger, ZTAlertActionStyle) {
    ZTAlertActionStyleDefault = 0,
    ZTAlertActionStyleCancel
} NS_ENUM_AVAILABLE_IOS(8_0);

typedef NS_ENUM(NSInteger, ZTAlertControllerStyle) {
    ZTAlertControllerStyleActionSheet = 0,
    ZTAlertControllerStyleAlert,
    ZTAlertControllerStylePicker,
    ZTAlertControllerStyleDatePicker,
    ZTAlertControllerStyleActivity,
    ZTAlertControllerStyleUpdate
} NS_ENUM_AVAILABLE_IOS(8_0);

@class ZTAlertAction;

typedef void(^ZTAlertActionHandler)(ZTAlertAction *action);

@interface ZTAlertAction : UIButton

+ (instancetype)actionWithTitle:(nullable NSString *)title style:(ZTAlertActionStyle)style handler:(ZTAlertActionHandler)handler;

@property (nullable, nonatomic, readonly) NSString *title;

@property (nonatomic, assign, readonly) ZTAlertActionStyle style;

@property (nullable, nonatomic, strong) UIColor * titleColor;

@property (nullable, nonatomic, strong) id extra;

@property(nonatomic, assign) BOOL  clickAlertNoAction;

@end


typedef void(^ZTAlertCompleteHandler)(void);

@interface ZTAlertController : UIViewController

/**
 ZTAlertAction的数组
 */
@property(nullable, nonatomic, readonly) NSArray<ZTAlertAction *> * actions;

/**
 alert的内容位置
 */
@property(nonatomic, assign) NSTextAlignment  messageAlignment;


+ (instancetype)alertControllerWithTitle:(nullable NSString *)title message:(nullable NSString *)message preferredStyle:(ZTAlertControllerStyle)preferredStyle;

- (void)addAction:(ZTAlertAction *)action;

- (void)addTextFieldWithConfigurationHandler:(void (^ __nullable)(UITextField *textField))configurationHandler;

@property (nullable, nonatomic, readonly) NSArray<UITextField *> *textFields;

@end

@interface ZTAlertController (AlertView)

@property(nonatomic, strong) UIColor * titleColor;

@property(nonatomic, strong) UIColor * messageColor;

@property(nonatomic, strong) id message;

@property(nonatomic, strong) NSDictionary * linkAttributes;

+ (instancetype)alertControllerWithTitle:(nullable NSString *)title attributedMessage:(nullable NSAttributedString *)message preferredStyle:(ZTAlertControllerStyle)preferredStyle;

/**
 添加链接
 
 @param url url
 @param range 链接位置
 */
- (void)addLinkToURL:(NSURL *)url withRange:(NSRange)range tapCompleteHandler:(ZTAlertCompleteHandler)completeHandler;

/**
 添加电话号码
 
 @param phoneNumber 电话号码
 @param range 电话号码位置
 */
- (void)addLinkToPhoneNumber:(NSString *)phoneNumber withRange:(NSRange)range tapCompleteHandler:(ZTAlertCompleteHandler)completeHandler;


/**
 添加自定义信息
 
 @param components 自定义信息
 @param range 位置
 */
- (void)addLinkToTransitInformation:(NSDictionary *)components withRange:(NSRange)range tapCompleteHandler:(ZTAlertCompleteHandler)completeHandler;


@end


@interface ZTAlertController (DatePicker)
/**
 datePicker的时间模式
 */
@property(nonatomic, assign) UIDatePickerMode  datePickerModel;

@property (nullable, nonatomic, strong) NSDate *minimumDate; // specify min/max date range. default is nil. When min > max, the values are ignored. Ignored in countdown timer mode
@property (nullable, nonatomic, strong) NSDate *maximumDate; // default is nil

@end

@interface ZTAlertController (ActivityView)

/**
 活动alert的图片地址或者图片
 */
@property(nonatomic, strong) id activityImage;

@end


typedef struct ZTAlertAttribute {
    NSString * _Nullable  title;
    UIColor * _Nullable  color;
}ZTAlertAttribute;

ZTAlertAttribute ZTAlertAttrbuiteMake(NSString * title, UIColor * color);
ZTAlertController * ZTShowAlert(ZTAlertAttribute title,
                              ZTAlertAttribute message,
                              ZTAlertAttribute sureTitle,
                              ZTAlertCompleteHandler _Nullable sureClick,
                              ZTAlertAttribute cancleTitle,
                              ZTAlertCompleteHandler _Nullable cancleClick
                              );


NS_ASSUME_NONNULL_END
