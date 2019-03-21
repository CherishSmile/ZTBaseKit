//
//  ZTWebVC.h
//  ZTCarOwner
//
//  Created by ZWL on 2017/8/25.
//  Copyright © 2017年 CITCC4. All rights reserved.
//

#import "ZTBaseVC.h"
#import <WebKit/WebKit.h>
#import "ZTWebManager.h"
#import "ZTWebView.h"

@interface ZTWebVC : ZTBaseVC


@property(nonatomic, strong, readonly) ZTWebView * baseWebView;

@property(nonatomic, strong, readonly) ZTWebManager * webManager;

/**
 是否使用UIWebView
 */
@property(nonatomic, assign) BOOL  isUseUIWeb;

/**
 导航是否隐藏
 */
@property(nonatomic, assign) BOOL  isHiddenNavBar;

/**
 是否显示进度条
 */
@property(nonatomic, assign) BOOL isShowProgress;

/**
 是否使用web标题
 */
@property(nonatomic, assign) BOOL isUseWebTitle;

/**
 是否开启定位权限
 */
@property(nonatomic, assign) BOOL  isUseLocation;

/**
 html的url地址
 */
@property(nonatomic, copy) NSString * urlString;

/**
 导航返回
 */
-(void)goBack;

@end
