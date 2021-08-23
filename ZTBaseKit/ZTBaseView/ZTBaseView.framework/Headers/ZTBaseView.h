//
//  ZTBaseView.h
//  ZTBaseView
//
//  Created by Alvin on 2021/7/20.
//  Copyright © 2021 CITCC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

//! Project version number for ZTBaseView.
FOUNDATION_EXPORT double ZTBaseViewVersionNumber;

//! Project version string for ZTBaseView.
FOUNDATION_EXPORT const unsigned char ZTBaseViewVersionString[];

/**
 刷新类型

 - ZTRefreshStyleNone: 无类型
 - ZTRefreshStyleHeader: 仅下拉刷新
 - ZTRefreshStyleFooter: 仅上拉加载
 - ZTRefreshStyleAll: 下拉刷新和上拉加载
 */
typedef NS_ENUM(NSInteger,ZTRefreshStyle) {
    ZTRefreshStyleNone = 0,
    ZTRefreshStyleHeader,
    ZTRefreshStyleFooter,
    ZTRefreshStyleAll,
};

/**
 请求状态

 - ZTRequestResultNone: 无请求
 - ZTRequestResultSuccess: 请求成功
 - ZTRequestResultFailed: 请求失败
 */
typedef NS_ENUM(NSInteger,ZTRequestResult) {
    ZTRequestResultNone = 0,
    ZTRequestResultSuccess,
    ZTRequestResultFailed,
};


// In this header, you should import all the public headers of your framework using statements like #import <ZTBaseView/PublicHeader.h>

#import <ZTBaseView/UIViewController+NavBarStyle.h>
#import <ZTBaseView/ZTBaseVC.h>
#import <ZTBaseView/ZTCollectionView.h>
#import <ZTBaseView/ZTTableView.h>
#import <ZTBaseView/ZTWebManager.h>
#import <ZTBaseView/ZTWebVC.h>
#import <ZTBaseView/ZTWebView.h>

