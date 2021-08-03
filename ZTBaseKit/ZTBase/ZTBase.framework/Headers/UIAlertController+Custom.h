//
//  UIAlertController+Custom.h
//  ZTCarOwner
//
//  Created by ZWL on 2018/1/18.
//  Copyright © 2018年 ZWL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertController (Custom)

/**
 标题颜色
 */
@property (nonatomic,strong) UIColor * titleColor;

/**
 标题字体大小
 */
@property (nonatomic,strong) UIFont * titleFont;

/**
 标题位置
 */
@property (nonatomic,assign) NSTextAlignment titleAligment;


/**
 内容颜色
 */
@property (nonatomic,strong) UIColor * messageColor;

/**
 内容字体大小
 */
@property (nonatomic,strong) UIFont * messageFont;

/**
 内容位置
 */
@property (nonatomic,assign) NSTextAlignment messageAligment;

@end
