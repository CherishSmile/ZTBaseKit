//
//  ZTLogViewController.h
//  ZTCloudMirror
//
//  Created by ZWL on 2019/11/18.
//  Copyright © 2019 CITCC4. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, ZTLogViewAction) {
    ZTLogViewActionScreen,
    ZTLogViewActionBottom,
    ZTLogViewActionTop,
    ZTLogViewActionClean,
    ZTLogViewActionClose,
    ZTLogViewActionSearch,
    ZTLogViewActionMore,
    ZTLogViewActionProceed,
    ZTLogViewActionParse
};

typedef void(^ZTLogViewActionBlock)(ZTLogViewAction action);

@interface ZTLogViewController : UIViewController

@property (nonatomic, copy) NSAttributedString * logTxt;

@property (nonatomic, copy) ZTLogViewActionBlock actionBlock;

@property (nonatomic, assign) BOOL fullScreen; // 是否全屏
@property (nonatomic, assign) BOOL minimize; // 是否最小化
@property (nonatomic, assign, readonly) BOOL isPause; // 是否暂停
@property (nonatomic, assign, readonly) BOOL isSearching; // 是否正在搜索

-(void)clear;

-(void)scrollToBottom:(BOOL)animated;

-(void)scrollToTop:(BOOL)animated;

/// 继续日志采集
-(void)proceed;

/// 暂停日志采集
-(void)pause;

@end

NS_ASSUME_NONNULL_END
