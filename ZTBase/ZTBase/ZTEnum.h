//
//  ZTEnum.h
//  ZTCloudMirror
//
//  Created by ZWL on 2018/3/22.
//  Copyright © 2018年 ZWL. All rights reserved.
//

#ifndef ZTEnum_h
#define ZTEnum_h

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



/**
 当前版本是否是最新版本
 
 - ZTVersionTypeOld: 老版本
 - ZTVersionTypeNew: 新版本
 - ZTVersionTypeEqual: 两个版本一致
 */
typedef NS_ENUM(NSInteger,ZTVersionType) {
    ZTVersionTypeOld,
    ZTVersionTypeNew,
    ZTVersionTypeEqual
};


typedef NS_ENUM(NSInteger,ZTNavBarItemPosition) {
    ZTNavBarItemPositionLeft,
    ZTNavBarItemPositionRight
};

#endif /* ZTEnum_h */
