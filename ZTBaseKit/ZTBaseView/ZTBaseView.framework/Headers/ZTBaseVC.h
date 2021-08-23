//
//  ZTBaseVC.h
//  Notice
//
//  Created by ZWL on 15/9/7.
//  Copyright (c) 2015年 ZWL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+NavBarStyle.h"

typedef void(^ZTViewWillAppearBlock)(void);
typedef void(^ZTViewDidAppearBlock)(void);
typedef void(^ZTViewWillDisappearBlock)(void);
typedef void(^ZTViewDidDisappearBlock)(void);
typedef void(^ZTPopViewControllerBlock)(void);


@interface ZTBaseVC : UIViewController

/**
 页面将要出现
 */
@property(nonatomic, copy) ZTViewWillAppearBlock viewWillAppear;

/**
 页面已经出现
 */
@property(nonatomic, copy) ZTViewDidAppearBlock viewDidAppear;

/**
 页面将要消失
 */
@property(nonatomic, copy) ZTViewWillDisappearBlock viewWillDisappear;

/**
 页面已经消失
 */
@property(nonatomic, copy) ZTViewDidDisappearBlock viewDidDisappear;

/**
 页面关闭
 */
@property(nonatomic, copy) ZTPopViewControllerBlock popViewController;

/**
 navbar是否是半透明
 */
@property(nonatomic, assign, readonly) BOOL navBarTranslucent;

/**
 tabbar是否是半透明
 */
@property(nonatomic, assign, readonly) BOOL tabBarTranslucent;

/**
 是否关闭侧滑返回手势
 */
@property(nonatomic, assign) BOOL isClosePopGestureRecognizer;

/**
 导航返回
 */
-(void)goBack;

@end

NSString * ZTBaseViewResource(void);

