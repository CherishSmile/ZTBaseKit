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


typedef void(^CompletionHandler)(id result, NSError *  error);

typedef void(^ZTWebBackCompletionHandler)(id result);

@interface ZTWebVC : ZTBaseVC

@property(nonatomic, copy) ZTWebBackCompletionHandler  webBackCompletionHandler;

@property(nonatomic, strong, readonly) ZTWebView * baseWebView;

@property(nonatomic, strong, readonly) ZTWebManager * webManager;

@property(nonatomic, strong) Class webManagerClass;

@property(nonatomic, assign) BOOL  allowsInlineMediaPlayback;

@property(nonatomic, assign) BOOL  mediaPlaybackRequiresUserAction;


@property(nonatomic, assign) BOOL  loadSandboxFile;
@property(nonatomic, copy) NSString * loadFilePath;
@property(nonatomic, copy) NSString * allowingReadAccessToPath;
/**
 进度条颜色
 */
@property(nonatomic, strong) UIColor * progressColor;

/**
 进度条高度
 */
@property(nonatomic, assign) CGFloat  progressHeight;

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

@property(nonatomic, assign) BOOL  openWebIsClearCache;

/**
 html的url地址
 */
@property(nonatomic, copy) NSString * urlString;

@property(nonatomic, strong) NSDictionary<NSString *, NSString *> * httpCookies;


/// 若重置urlString 或者loadSandboxFile、loadFilePath、allowingReadAccessToPath相关参数，重新调用此方法，可立即生效
-(void)loadHtml;

/**
 导航返回
 */
-(void)goBack;
/**
 关闭页面
*/
-(void)closeClick;

/**
 OC调用js（请在页面加载完成之后，调用此方法，否则可能会无效）
 
 @param jsMethod js方法名
 @param completionHandler 完成回调
 */
-(void)callJavaScript:(NSString*)jsMethod completionHandler:(CompletionHandler)completionHandler;

/**
 js调用OC 添加处理脚本（调用此方法，添加message的title属性）
 
 @param messageNames OC方法名数组
 */
-(void)addJavaScriptMessages:(NSArray<NSString*>*)messageNames;

/**
 向网页中注入js代码
 
 @param userScripts js数组
 */
-(void)addUserScript:(NSArray<NSString*>*)userScripts;

@end
