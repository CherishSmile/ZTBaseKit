//
//  UIViewController+NavBarAlpha.h
//  ZTCarOwner
//
//  Created by ZWL on 2018/8/15.
//  Copyright © 2018 ZWL. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 导航样式
 
 - ZTNavBarStyleDefault: 默认样式（黑色背景）
 - ZTNavBarStyleWhite: 白色背景样式
 - ZTNavBarStyleClear: 透明背景样式
 */
typedef NS_ENUM(NSInteger,ZTNavBarStyle) {
    ZTNavBarStyleDefault = 1,
    ZTNavBarStyleWhite,
    ZTNavBarStyleClear
};


typedef NS_ENUM(NSInteger,ZTNavBarStatus) {
    ZTNavBarStatusOpacity,
    ZTNavBarStatusTranslucent,
    ZTNavBarStatusClear
};

@interface UIViewController (NavBarStyle)


@property(nonatomic, assign, readonly) BOOL  isSetedStyle;

/**
 导航的高度
 */
@property(nonatomic, assign, readonly) CGFloat navBarHeight;


@property(nonatomic, strong, readonly) UIVisualEffectView * navVisualEffectView;


/**
 状态栏样式
 请在plist文件中设置这个属性，否则不生效
 <key>UIViewControllerBasedStatusBarAppearance</key>
 <false/>
 */
@property(nonatomic, assign) UIStatusBarStyle  statusBarStyle;


@property(nonatomic, assign) BOOL  statusBarHidden;

/**
 状态栏背景色
 */
@property(nonatomic, strong) UIColor * statusBarBackgroundColor;

/**
 导航透明度
 */
@property(nonatomic, assign) CGFloat  barAlpha;

/**
 导航样式
 */
@property(nonatomic, assign) ZTNavBarStyle  barStyle;

/**
 导航样式状态
 */
@property(nonatomic, assign) ZTNavBarStatus  barStatus;

/**
 导航栏颜色
 */
@property(nonatomic, strong) UIColor * navBarTintColor;

/**
 导航栏上字体颜色
 */
@property(nonatomic, strong) UIColor * navTintColor;

/**
 导航栏标题颜色
 */
@property(nonatomic, strong) UIColor * navTitleColor;

/**
 设置导航样式(放在viewWillAppear中，可控制每个不同的NavBar)
 
 @param style 样式
 */
-(void)setNavBarStyle:(ZTNavBarStyle)style;

@end
