//
//  ZTAlertController.h
//  ZTCarOwner
//
//  Created by ZWL on 2018/7/10.
//  Copyright © 2018 ZWL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZTBaseVC.h"

NS_ASSUME_NONNULL_BEGIN

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

@end


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

@property(nonatomic, strong) id message;

+ (instancetype)alertControllerWithTitle:(nullable NSString *)title attributedMessage:(nullable NSAttributedString *)message preferredStyle:(ZTAlertControllerStyle)preferredStyle;

@end


@interface ZTAlertController (DatePicker)
/**
 datePicker的时间模式
 */
@property (nonatomic, assign) UIDatePickerMode  datePickerModel;

@property (nullable, nonatomic, strong) NSDate *minimumDate; // specify min/max date range. default is nil. When min > max, the values are ignored. Ignored in countdown timer mode
@property (nullable, nonatomic, strong) NSDate *maximumDate; // default is nil

@end

@interface ZTAlertController (ActivityView)

/**
 活动alert的图片地址或者图片
 */
@property(nonatomic, strong) id activityImage;

@end


NS_ASSUME_NONNULL_END
