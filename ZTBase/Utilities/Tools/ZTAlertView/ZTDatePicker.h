//
//  ZTDatePicker.h
//  ZTCarOwner
//
//  Created by ZWL on 2017/8/24.
//  Copyright © 2017年 CITCC4. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^ZTDatePickerCloseBlock)(void);

@class ZTAlertAction;

@interface ZTDatePicker : UIView

@property(nonatomic, copy) ZTDatePickerCloseBlock closeBlock;
/**
 设置datePicker模式
 */
@property(nonatomic, assign) UIDatePickerMode datePickerMode;

@property (nullable, nonatomic, strong) NSDate *minimumDate; // specify min/max date range. default is nil. When min > max, the values are ignored. Ignored in countdown timer mode
@property (nullable, nonatomic, strong) NSDate *maximumDate; // default is nil

/**
 按钮数组
 */
@property(nonatomic, strong, readonly) NSArray<ZTAlertAction *> * actions;

/**
 所选择的时间
 */
@property(nonatomic, copy, readonly) NSDate * selectedDate;


-(instancetype)initWithActions:(NSArray<ZTAlertAction *> *)actions;

@end

NS_ASSUME_NONNULL_END
