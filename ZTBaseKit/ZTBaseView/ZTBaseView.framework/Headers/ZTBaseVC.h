//
//  ZTBaseVC.h
//  Notice
//
//  Created by ZWL on 15/9/7.
//  Copyright (c) 2015年 ZWL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+NavBarStyle.h"


typedef void(^ZTBaseViewBlock)(void);

@interface ZTBaseVC : UIViewController

/**
 页面将要出现
 */
@property(nonatomic, copy) ZTBaseViewBlock viewWillAppear;

/**
 页面已经出现
 */
@property(nonatomic, copy) ZTBaseViewBlock viewDidAppear;

/**
 页面将要消失
 */
@property(nonatomic, copy) ZTBaseViewBlock viewWillDisappear;

/**
 页面已经消失
 */
@property(nonatomic, copy) ZTBaseViewBlock viewDidDisappear;

/**
 页面关闭
 */
@property(nonatomic, copy) ZTBaseViewBlock popViewController;


@property(nonatomic, copy) ZTBaseViewBlock traitCollectionDidChange API_AVAILABLE(ios(13.0));

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

