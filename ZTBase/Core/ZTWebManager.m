//
//  ZTWebManager.m
//  ZTCarOwner
//
//  Created by ZWL on 2018/6/28.
//  Copyright © 2018 ZWL. All rights reserved.
//

#import "ZTWebManager.h"
#import "ZTScriptMessageHandler.h"
#import "ZTPublicMethod.h"

@interface ZTWebManager ()
@property(nonatomic, strong) ZTWebView * webView;
@property(nonatomic, strong) NSArray * baseMessageNames;
@property(nonatomic, strong) NSArray * messageNames;

@end

@implementation ZTWebManager

-(instancetype)initWithWebView:(ZTWebView *)webView{
    if (self = [super init]) {
        self.webView = webView;
    }
    return self;
}

#pragma mark - public method
/**
 清除缓存
 */
-(void)clearWebCache{
    if (self.webView.webType==ZTWebViewTypeUIWebView) {
        [ZTWebManager clearUIWebCache];
    }else{
        [ZTWebManager clearWKWebCache];
    }
}

/**
 加载Html
 
 @param urlString html
 */
-(void)loadHtml:(NSString *)urlString{
    if (isNil(urlString).length) {
        if ([urlString hasPrefix:@"http://"]||[urlString hasPrefix:@"https://"]) {
            NSURL *url = urlFromString(urlString);
            [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
        }else{
            NSString *htmlPath = [[NSBundle mainBundle] pathForResource:urlString ofType:@"html"];
            if (isNil(htmlPath).length) {
                NSURL *url = [NSURL fileURLWithPath:htmlPath];
                [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
            }else{
                [self.webView loadHTMLString:urlString baseURL:nil];
            }
        }
    }else{
        NSLog(@"urlString为空");
    }
}

-(void)addCommonJavaScriptMessagesHandler:(NSArray<NSString *> *(^)(WKUserContentController *userCC,ZTScriptMessageHandler *messageHandler))scriptMessageHandler{
    if (self.webView.webType==ZTWebViewTypeWKWebView) {
        WKUserContentController *userCC = self.webView.configuration.userContentController;
        ZTScriptMessageHandler *messageHandle = self.webView.messageHandler;
        if (scriptMessageHandler) {
           self.baseMessageNames = scriptMessageHandler(userCC,messageHandle);
        }
    }
}


/**
 js调用OC 添加处理脚本
 
 @param messageNames OC方法名数组
 */
-(void)addJavaScriptMessages:(NSArray<NSString *> *)messageNames{
    if (self.webView.webType==ZTWebViewTypeWKWebView) {
        self.messageNames = messageNames;
        WKUserContentController *userCC = self.webView.configuration.userContentController;
        [messageNames enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            ZTScriptMessageHandler *messageHandle = self.webView.messageHandler;
            [userCC addScriptMessageHandler:messageHandle name:obj];
        }];
    }
}

-(void)callJavaScript:(NSString *)jsMethod completionHandler:(void (^ _Nullable)(_Nullable id, NSError * _Nullable error))completionHandler{
    [self.webView evaluateJavaScript:jsMethod completionHandler:completionHandler];
}


/**
 向网页中注入js代码
 
 @param userScripts js数组
 */
-(void)addUserScript:(NSArray<NSString*>*)userScripts{
    
    if (self.webView.webType==ZTWebViewTypeUIWebView) {
        
    }else{
        WKUserContentController *userCC = self.webView.configuration.userContentController;
        [userScripts enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            WKUserScript *userScript = [[WKUserScript alloc] initWithSource:obj injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:true];
            [userCC addUserScript:userScript];
        }];
    }
}

/**
 给wkwebview添加cookie
 */
-(void)addWKWebCookie:(void(^)(WKUserContentController *userCC))cookieHandler{
    if (self.webView.webType==ZTWebViewTypeWKWebView) {
        if (cookieHandler) {
            cookieHandler(self.webView.configuration.userContentController);
        }
    }
}

-(void)removeScript{
    if (self.webView.webType==ZTWebViewTypeWKWebView) {
        [self.jsMessages enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [self.webView.configuration.userContentController removeScriptMessageHandlerForName:obj];
        }];
        [self.webView.configuration.userContentController removeAllUserScripts];
    }
}

#pragma mark - setter
-(NSArray *)jsMessages{
    NSMutableArray *messages = [NSMutableArray array];
    [messages addObjectsFromArray:self.baseMessageNames];
    [messages addObjectsFromArray:self.messageNames];
    return messages.copy;
}

#pragma mark -  ZTWebScriptMessageHandler

-(void)webView:(ZTWebView *)webView didReceiveScriptMessageWithFunctionName:(NSString *)name functionParameters:(id)parameters{
    if (self.receiveScriptMessageHandler) {
        self.receiveScriptMessageHandler(webView, name, parameters);
    }
}


@end

@implementation ZTWebManager (WebOperation)

+ (void)clearAllWebCache{
    [self clearWKWebCache];
    [self clearUIWebCache];
}
+ (void)clearUIWebCache{
    [NSURLCache.sharedURLCache removeAllCachedResponses];
    [NSURLCache.sharedURLCache setDiskCapacity:0];
    [NSURLCache.sharedURLCache setMemoryCapacity:0];
    [self removeApplicationLibraryDirectoryWithDirectory:@"Caches"];
    [self removeApplicationLibraryDirectoryWithDirectory:@"WebKit"];
    for (NSHTTPCookie *cookie in [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies]) {
        [[NSHTTPCookieStorage sharedHTTPCookieStorage] deleteCookie:cookie];
    }
    [self removeApplicationLibraryDirectoryWithDirectory:@"Cookies"];
    
}
+ (void)clearWKWebCache{
    if (@available(iOS 9.0, *)) {
        NSArray *types = @[WKWebsiteDataTypeMemoryCache,WKWebsiteDataTypeDiskCache];
        NSSet *websiteDataTypes = [NSSet setWithArray:types];
        NSDate *dateFrom = [NSDate dateWithTimeIntervalSince1970:0];
        [[WKWebsiteDataStore defaultDataStore] removeDataOfTypes:websiteDataTypes modifiedSince:dateFrom completionHandler:^{
            
        }];
    } else {
        NSString *libraryPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory,NSUserDomainMask,YES) firstObject];
        NSString *cookiesFolderPath = [libraryPath stringByAppendingString:@"/Cookies"];
        NSLog(@"%@", cookiesFolderPath);
        NSError *errors;
        [[NSFileManager defaultManager]removeItemAtPath:cookiesFolderPath error:&errors];
    }
}

+ (void)removeApplicationLibraryDirectoryWithDirectory:(NSString *)dirName {
    NSString *dir = [[[[NSSearchPathForDirectoriesInDomains(NSApplicationDirectory, NSUserDomainMask, YES) lastObject]stringByDeletingLastPathComponent] stringByAppendingPathComponent:@"Library"] stringByAppendingPathComponent:dirName];
    if ([[NSFileManager defaultManager] fileExistsAtPath:dir]) {
        [[NSFileManager defaultManager] removeItemAtPath:dir error:nil];
    }
}

@end


