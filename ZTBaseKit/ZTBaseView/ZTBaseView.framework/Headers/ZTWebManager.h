//
//  ZTWebManager.h
//  ZTCarOwner
//
//  Created by ZWL on 2018/6/28.
//  Copyright © 2018 ZWL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZTWebView.h"


typedef void(^ZTWebViewReceiveScriptMessageHandler)(ZTWebView * webView,NSString * methodName,id parameters);

@interface ZTWebManager : NSObject

@property(nonatomic, strong, readonly) NSArray * jsMessages;

@property(nonatomic, strong, readonly) NSURL * requestURL;


-(instancetype)initWithWebView:(ZTWebView *)webView;

/**
 清除缓存
 */
-(void)clearWebCache;

/**
 加载Html
 
 @param urlString html
 */
-(void)loadHtml:(NSString *)urlString withCookies:(NSDictionary<NSString *, NSString *> *)cookies;


/// 加载沙盒中的html
-(void)loadSandboxHtml;

/**
 js调用OC 添加scriptMessages

 @param scriptMessageHandler 添加scriptMessages回调，返回值为scriptMessages的name
 */
-(void)addCommonJavaScriptMessagesHandler:(NSArray<NSString *> *(^)(WKUserContentController *userCC,ZTScriptMessageHandler *messageHandler))scriptMessageHandler;
/**
 js调用OC 添加scriptMessages（调用此方法，添加message的title属性）
 
 @param messageNames OC方法名数组
 */
-(void)addJavaScriptMessages:(NSArray<NSString*>*)messageNames;

/**
 OC调用js（请在页面加载完成之后，调用此方法，否则可能会无效）
 
 @param jsMethod js方法名
 @param completionHandler 完成回调
 */
-(void)callJavaScript:(NSString *)jsMethod completionHandler:(void (^)(id, NSError * error))completionHandler;

/**
 向网页中注入js代码
 
 @param userScripts js数组
 */
-(void)addUserScript:(NSArray<NSString*>*)userScripts;

/**
 添加cookie
 */
-(void)addWKWebCookie:(void(^)(WKUserContentController *userCC))cookieHandler;

/**
 删除注入脚本
 */
-(void)removeScript;

-(void)webView:(ZTWebView *)webView didReceiveScriptMessageWithFunctionName:(NSString *)name functionParameters:(id)parameters;

@property(nonatomic, copy) ZTWebViewReceiveScriptMessageHandler receiveScriptMessageHandler;

@end

@interface ZTWebManager (WebOperation)

/**
 清除缓存
 */
+(void)clearAllWebCache;
+(void)clearWKWebCache;

@end

