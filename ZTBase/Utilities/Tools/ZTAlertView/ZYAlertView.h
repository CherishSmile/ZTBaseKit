//
//  ZYAlertView.h
//  ZYAlertView
//
//  Created by ZWL on 16/3/15.
//  Copyright © 2016年 ZWL. All rights reserved.
//
#import <UIKit/UIKit.h>

@class ZYAlertView;
typedef void(^ZYAlertViewHandler)(ZYAlertView *alertView);

/**
 alert弹出的动画样式

 - ZYAlertViewTransitionStyleSlideFromBottom: 从底部弹出
 - ZYAlertViewTransitionStyleSlideFromTop: 从顶部弹出
 - ZYAlertViewTransitionStyleFade: 渐变出现
 - ZYAlertViewTransitionStyleBounce: 弹性出现
 - ZYAlertViewTransitionStyleDropDown: 水滴降落出现
 */
typedef NS_ENUM(NSInteger,ZYAlertViewTransitionStyle) {
    ZYAlertViewTransitionStyleSlideFromBottom = 0,
    ZYAlertViewTransitionStyleSlideFromTop,
    ZYAlertViewTransitionStyleFade,
    ZYAlertViewTransitionStyleBounce,
    ZYAlertViewTransitionStyleDropDown
};
@interface ZYAlertView : UIView

/**
 原始window
 */
@property (nonatomic, weak)   UIWindow *oldKeyWindow;

/**
 alert所在的window
 */
@property (nonatomic, strong) UIWindow *alertWindow;

/**
 alertView
 */
@property (nonatomic, strong) UIView * containerView;

/**
 点击alert以外的区域是否不会消失（YES不会消失，NO会消失，默认为NO）
 */
@property (nonatomic, assign) BOOL isTouchOtherUndissmiss;

@property (nonatomic, assign, getter = isVisible) BOOL visible;
@property (nonatomic, readonly, getter = isParallaxEffectEnabled) BOOL enabledParallaxEffect;
@property (nonatomic, assign, getter = isLayoutDirty) BOOL layoutDirty;

/**
 将要出现回调
 */
@property (nonatomic, copy) ZYAlertViewHandler willShowHandler;

/**
 已经出现回调
 */
@property (nonatomic, copy) ZYAlertViewHandler didShowHandler;

/**
 将要消失回调
 */
@property (nonatomic, copy) ZYAlertViewHandler willDismissHandler;

/**
 已经消失回调
 */
@property (nonatomic, copy) ZYAlertViewHandler didDismissHandler;

/**
 alert动画样式
 */
@property (nonatomic, assign) ZYAlertViewTransitionStyle transitionStyle;

/**
 弹出alert
 */
- (void)show;

/**
 隐藏alert

 @param animated 是否带动画
 */
- (void)dismissAnimated:(BOOL)animated;

@end
