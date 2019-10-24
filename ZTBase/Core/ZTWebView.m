//
//  ZTWebView.m
//  ZTCarOwner
//
//  Created by ZWL on 2019/1/28.
//  Copyright © 2019 CITCC4. All rights reserved.
//

#import "ZTWebView.h"
#import "ZTUIWebViewProgress.h"
#import <AFNetworking/UIWebView+AFNetworking.h>
#import "ZTBaseFunction.h"

static inline  id queryObject(NSString * query){
    NSArray * queryArr = [query componentsSeparatedByString:@"&"];
    if (queryArr.count>1) {
        NSMutableDictionary * queryDic = [NSMutableDictionary dictionary];
        for (NSString * string in queryArr) {
            NSArray * stringArr = [string componentsSeparatedByString:@"="];
            NSString * keyString = [ZTStringFromNullableString(stringArr.firstObject) stringByAddingPercentEncodingWithAllowedCharacters:NSCharacterSet.URLQueryAllowedCharacterSet];
            NSString * valueString = [ZTStringFromNullableString(stringArr.lastObject) stringByAddingPercentEncodingWithAllowedCharacters:NSCharacterSet.URLQueryAllowedCharacterSet];
            [queryDic setObject:ZTStringFromNullableString(valueString) forKey:ZTStringFromNullableString(keyString)];
        }
        return queryDic.copy;
    }else{
        return queryArr.firstObject;
    }
}


static NSString * WEBPROGRESS = @"estimatedProgress";
static NSString * WEBTITLE = @"title";

@interface ZTWebView ()<WKNavigationDelegate,UIWebViewDelegate,WKScriptMessageHandler,ZTUIWebViewProgressDelegate>
@property(nonatomic, assign) ZTWebViewType  webType;
@property(nonatomic, strong) WKWebView * baseWKWeb;
@property(nonatomic, strong) UIWebView * baseUIWeb;
@property(nonatomic, strong) ZTUIWebViewProgress * progressProxy;
@property(nonatomic, strong) WKWebViewConfiguration * configuration;

@property(nonatomic, strong) UIScrollView *scrollView;

@property(nullable, nonatomic, copy) NSURL *URL;
@property(nonatomic, assign) CGFloat  estimatedProgress;
@property(nonatomic, copy) NSString * title;

@property(nonatomic, strong) NSError * error;

@end

@implementation ZTWebView

- (instancetype)initWithFrame:(CGRect)frame webType:(ZTWebViewType)webType
{
    self = [super initWithFrame:frame];
    if (self) {
        self.webType = webType;
        [self createSubviews];
    }
    return self;
}

- (void)createSubviews{
    if (self.webType==ZTWebViewTypeUIWebView) {
        self.baseUIWeb = [[UIWebView alloc] initWithFrame:self.bounds];
        self.baseUIWeb.delegate = self;
        self.baseUIWeb.delegate = self.progressProxy;
        [self addSubview:self.baseUIWeb];
    }else{
        WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
        self.baseWKWeb = [[WKWebView alloc] initWithFrame:self.bounds configuration:config];
        self.baseWKWeb.navigationDelegate = self;
        [self addSubview:self.baseWKWeb];
        [self.baseWKWeb addObserver:self forKeyPath:WEBPROGRESS options:(NSKeyValueObservingOptionNew) context:nil];
        [self.baseWKWeb addObserver:self forKeyPath:WEBTITLE options:(NSKeyValueObservingOptionNew) context:nil];
    }
}

-(void)layoutSubviews{
    [super layoutSubviews];
    if (self.webType==ZTWebViewTypeUIWebView) {
        self.baseUIWeb.frame = self.bounds;
    }else{
        self.baseWKWeb.frame = self.bounds;
    }
}

#pragma mark - kvo
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:WEBPROGRESS]) {
        self.estimatedProgress = self.baseWKWeb.estimatedProgress;
        if (self.estimatedProgressHandler) {
            self.estimatedProgressHandler(self.baseWKWeb.estimatedProgress,self.error);
        }
    }else if ([keyPath isEqualToString:WEBTITLE]){
        self.title = self.baseWKWeb.title;
        if (self.webTitleHandler) {
            self.webTitleHandler(self.baseWKWeb.title);
        }
    }
}
#pragma mark -  WKNavigationDelegate

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    if ([self.delegate respondsToSelector:@selector(webView:decidePolicyForNavigationAction:decisionHandler:)]) {
        [self.delegate webView:self decidePolicyForNavigationAction:navigationAction decisionHandler:decisionHandler];
    }else{
        decisionHandler(WKNavigationActionPolicyAllow);
    }
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
    if ([self.delegate respondsToSelector:@selector(webView:decidePolicyForNavigationResponse:decisionHandler:)]) {
        [self.delegate webView:self decidePolicyForNavigationResponse:navigationResponse decisionHandler:decisionHandler];
    }else{
        decisionHandler(WKNavigationResponsePolicyAllow);
    }
}


- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation{
    if ([self.delegate respondsToSelector:@selector(webView:didStartProvisionalNavigation:)]) {
        [self.delegate webView:self didStartProvisionalNavigation:navigation];
    }
}

- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(null_unspecified WKNavigation *)navigation{
    if ([self.delegate respondsToSelector:@selector(webView:didReceiveServerRedirectForProvisionalNavigation:)]) {
        [self.delegate webView:self didReceiveServerRedirectForProvisionalNavigation:navigation];
    }
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error{
    self.error = error;
    if ([self.delegate respondsToSelector:@selector(webView:didFailProvisionalNavigation:withError:)]) {
        [self.delegate webView:self didFailProvisionalNavigation:navigation withError:error];
    }
}

- (void)webView:(WKWebView *)webView didCommitNavigation:(null_unspecified WKNavigation *)navigation{
    if ([self.delegate respondsToSelector:@selector(webView:didCommitNavigation:)]) {
        [self.delegate webView:self didCommitNavigation:navigation];
    }
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation{
    if ([self.delegate respondsToSelector:@selector(webView:didFinishNavigation:)]) {
        [self.delegate webView:self didFinishNavigation:navigation];
    }
}

- (void)webView:(WKWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error{
    self.error = error;
    if ([self.delegate respondsToSelector:@selector(webView:didFailNavigation:withError:)]) {
        [self.delegate webView:self didFailNavigation:navigation withError:error];
    }
}

- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential * _Nullable credential))completionHandler{
    if ([self.delegate respondsToSelector:@selector(webView:didReceiveAuthenticationChallenge:completionHandler:)]) {
        [self.delegate webView:self didReceiveAuthenticationChallenge:challenge completionHandler:completionHandler];
    }else{
        NSURLCredential *credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
        completionHandler(NSURLSessionAuthChallengeUseCredential,credential);
    }
}

- (void)webViewWebContentProcessDidTerminate:(WKWebView *)webView API_AVAILABLE(macosx(10.11), ios(9.0)){
    if([self.delegate respondsToSelector:@selector(webViewWebContentProcessDidTerminate:)]){
        [self.delegate webViewWebContentProcessDidTerminate:self];
    }
}

#pragma mark - UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType API_DEPRECATED("No longer supported.", ios(2.0, 12.0)){
    if([request.URL.scheme isEqualToString:ZTStringFromNullableString(self.webScheme)]){
        id delegate = self.delegate;
        if ([delegate conformsToProtocol:@protocol(ZTWebScriptMessageHandler)]) {
            if ([delegate respondsToSelector:@selector(webView:didReceiveScriptMessageWithFunctionName:functionParameters:)]) {
                [delegate webView:self didReceiveScriptMessageWithFunctionName:request.URL.host functionParameters:queryObject(request.URL.query)];
                return NO;
            }else{
                if([self.delegate respondsToSelector:@selector(webView:shouldStartLoadWithRequest:navigationType:)]){
                    return [self.delegate webView:self shouldStartLoadWithRequest:request navigationType:navigationType];
                }else{
                    return YES;
                }
            }
        }else{
            if([self.delegate respondsToSelector:@selector(webView:shouldStartLoadWithRequest:navigationType:)]){
                return [self.delegate webView:self shouldStartLoadWithRequest:request navigationType:navigationType];
            }else{
                return YES;
            }
        }
    }else{
        if([self.delegate respondsToSelector:@selector(webView:shouldStartLoadWithRequest:navigationType:)]){
            return [self.delegate webView:self shouldStartLoadWithRequest:request navigationType:navigationType];
        }else{
            return YES;
        }
    }
}

- (void)webViewDidStartLoad:(UIWebView *)webView API_DEPRECATED("No longer supported.", ios(2.0, 12.0)){
    if([self.delegate respondsToSelector:@selector(webView:didStartProvisionalNavigation:)]){
        [self.delegate webView:self didStartProvisionalNavigation:nil];
    }
}
- (void)webViewDidFinishLoad:(UIWebView *)webView API_DEPRECATED("No longer supported.", ios(2.0, 12.0)){
    if([self.delegate respondsToSelector:@selector(webView:didFinishNavigation:)]){
        [self.delegate webView:self didFinishNavigation:nil];
    }
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error API_DEPRECATED("No longer supported.", ios(2.0, 12.0)){
    self.error = error;
    if([self.delegate respondsToSelector:@selector(webView:didFailNavigation:withError:)]){
        [self.delegate webView:self didFailNavigation:nil withError:error];
    }
}

-(void)webViewProgress:(ZTUIWebViewProgress *)webViewProgress updateProgress:(float)progress{
    self.estimatedProgress = progress;
    if (self.estimatedProgressHandler) {
        self.estimatedProgressHandler(progress,self.error);
    }
    self.title = [self.baseUIWeb stringByEvaluatingJavaScriptFromString:@"document.title"];
    if (self.webTitleHandler) {
        self.webTitleHandler(self.title);
    }
}

#pragma mark -  WKScriptMessageHandler
-(void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    id delegate = self.delegate;
    if ([delegate conformsToProtocol:@protocol(ZTWebScriptMessageHandler)]) {
        if ([delegate respondsToSelector:@selector(webView:didReceiveScriptMessageWithFunctionName:functionParameters:)]) {
            [delegate webView:self didReceiveScriptMessageWithFunctionName:message.name functionParameters:message.body];
        }
        if ([delegate respondsToSelector:@selector(userContentController:didReceiveScriptMessage:)]) {
            [delegate userContentController:userContentController didReceiveScriptMessage:message];
        }
    }
}


#pragma mark - public method

- (void)loadRequest:(NSURLRequest *)request{
    if (self.webType==ZTWebViewTypeUIWebView) {
        [self.baseUIWeb loadRequest:request];
    }else{
        [self.baseWKWeb loadRequest:request];
    }
}
- (void)loadHTMLString:(NSString *)string baseURL:(nullable NSURL *)baseURL{
    if (self.webType==ZTWebViewTypeUIWebView) {
        [self.baseUIWeb loadHTMLString:string baseURL:baseURL];
    }else{
        [self.baseWKWeb loadHTMLString:string baseURL:baseURL];
    }
}
- (void)loadData:(NSData *)data MIMEType:(NSString *)MIMEType textEncodingName:(NSString *)textEncodingName baseURL:(NSURL *)baseURL{
    if (self.webType==ZTWebViewTypeUIWebView) {
        [self.baseUIWeb loadData:data MIMEType:MIMEType textEncodingName:textEncodingName baseURL:baseURL];
    }else{
        if (@available(iOS 9.0, *)) {
            [self.baseWKWeb loadData:data MIMEType:MIMEType characterEncodingName:textEncodingName baseURL:baseURL];
        } else {
            // Fallback on earlier versions
        }
    }
}


- (void)reload{
    if (self.webType==ZTWebViewTypeUIWebView) {
        [self.baseUIWeb reload];
    }else{
        [self.baseWKWeb reload];
    }
}
- (void)stopLoading{
    if (self.webType==ZTWebViewTypeUIWebView) {
        [self.baseUIWeb stopLoading];
    }else{
        [self.baseWKWeb stopLoading];
    }
}

- (void)goBack{
    if (self.webType==ZTWebViewTypeUIWebView) {
        [self.baseUIWeb goBack];
    }else{
        [self.baseWKWeb goBack];
    }
}
- (void)goForward{
    if (self.webType==ZTWebViewTypeUIWebView) {
        [self.baseUIWeb goForward];
    }else{
        [self.baseWKWeb goForward];
    }
}

-(BOOL)canGoBack{
    if (self.webType==ZTWebViewTypeUIWebView) {
        return self.baseUIWeb.canGoBack;
    }else{
        return self.baseWKWeb.canGoBack;
    }
}
- (BOOL)canGoForward{
    if (self.webType==ZTWebViewTypeUIWebView) {
        return self.baseUIWeb.canGoForward;
    }else{
        return self.baseWKWeb.canGoForward;
    }
}

-(NSURL *)URL{
    if (self.webType==ZTWebViewTypeUIWebView) {
        return self.baseUIWeb.request.URL;
    }else{
        return self.baseWKWeb.URL;
    }
}

-(BOOL)loading{
    if (self.webType==ZTWebViewTypeUIWebView) {
        return self.baseUIWeb.loading;
    }else{
        return self.baseWKWeb.loading;
    }
}
-(WKWebViewConfiguration *)configuration{
    if (self.webType==ZTWebViewTypeUIWebView) {
        return nil;
    }else{
        return self.baseWKWeb.configuration;
    }
}

-(NSString *)stringByEvaluatingJavaScriptFromString:(NSString *)script{
    if (self.webType==ZTWebViewTypeUIWebView) {
        return [self.baseUIWeb stringByEvaluatingJavaScriptFromString:script];
    }else{
        return @"";
    }
}

- (NSString *)evaluateJavaScript:(NSString *)javaScriptString completionHandler:(void (^)(id _Nullable, NSError * _Nullable))completionHandler{
    if (self.webType==ZTWebViewTypeUIWebView) {
        return [self.baseUIWeb stringByEvaluatingJavaScriptFromString:javaScriptString];
    }else{
        [self.baseWKWeb evaluateJavaScript:javaScriptString completionHandler:completionHandler];
        return @"";
    }
}

#pragma mark - setter
-(void)setBackgroundColor:(UIColor *)backgroundColor{
    [super setBackgroundColor:backgroundColor];
    if (self.webType==ZTWebViewTypeUIWebView) {
        self.baseUIWeb.backgroundColor = backgroundColor;
    }else{
        self.baseWKWeb.backgroundColor = backgroundColor;
    }
}

-(void)setAllowsInlineMediaPlayback:(BOOL)allowsInlineMediaPlayback{
    _allowsInlineMediaPlayback = allowsInlineMediaPlayback;
    if (self.webType==ZTWebViewTypeUIWebView) {
        self.baseUIWeb.allowsInlineMediaPlayback = allowsInlineMediaPlayback;
    }else{
        self.baseWKWeb.configuration.allowsInlineMediaPlayback = allowsInlineMediaPlayback;
    }
}

-(void)setMediaPlaybackRequiresUserAction:(BOOL)mediaPlaybackRequiresUserAction{
    _mediaPlaybackRequiresUserAction = mediaPlaybackRequiresUserAction;
    if (self.webType==ZTWebViewTypeUIWebView) {
        self.baseUIWeb.mediaPlaybackRequiresUserAction = mediaPlaybackRequiresUserAction;
    }else{
        if (@available(iOS 10.0, *)) {
            self.baseWKWeb.configuration.mediaTypesRequiringUserActionForPlayback = mediaPlaybackRequiresUserAction;
        } else {
            self.baseWKWeb.configuration.requiresUserActionForMediaPlayback = mediaPlaybackRequiresUserAction;
        }
    }
}

#pragma mark - getter
-(UIScrollView *)scrollView{
    if (!_scrollView) {
        if (self.webType==ZTWebViewTypeUIWebView) {
            _scrollView = self.baseUIWeb.scrollView;
        }else{
            _scrollView = self.baseWKWeb.scrollView;
        }
    }
    return _scrollView;
}
- (ZTUIWebViewProgress *)progressProxy{
    if (!_progressProxy) {
        _progressProxy = [[ZTUIWebViewProgress alloc] init];
        _progressProxy.webViewProxyDelegate = self;
        _progressProxy.progressDelegate = self;
    }
    return _progressProxy;
}

-(ZTScriptMessageHandler *)messageHandler{
    if (!_messageHandler) {
        if (self.webType==ZTWebViewTypeUIWebView) {
            
        }else{
            _messageHandler = [ZTScriptMessageHandler scriptWithDelegate:self];
        }
    }
    return _messageHandler;
}

-(void)dealloc{
    if (self.webType==ZTWebViewTypeUIWebView) {
       
    }else{
        [self.baseWKWeb removeObserver:self forKeyPath:WEBPROGRESS];
        [self.baseWKWeb removeObserver:self forKeyPath:WEBTITLE];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

@implementation ZTWebView (UIWebViewHandler)

- (AFHTTPSessionManager *)sessionManager{
    return self.baseUIWeb.sessionManager;
}

-(void)setSessionManager:(AFHTTPSessionManager *)sessionManager{
    self.baseUIWeb.sessionManager = sessionManager;
}

-(void)loadRequest:(NSURLRequest *)request progress:(NSProgress *__autoreleasing  _Nullable *)progress success:(NSString * _Nonnull (^)(NSHTTPURLResponse * _Nonnull, NSString * _Nonnull))success failure:(void (^)(NSError * _Nonnull))failure{
    [self.baseUIWeb loadRequest:request progress:progress success:success failure:failure];
}

-(void)loadRequest:(NSURLRequest *)request MIMEType:(NSString *)MIMEType textEncodingName:(NSString *)textEncodingName progress:(NSProgress *__autoreleasing  _Nullable *)progress success:(NSData * _Nonnull (^)(NSHTTPURLResponse * _Nonnull, NSData * _Nonnull))success failure:(void (^)(NSError * _Nonnull))failure{
    [self.baseUIWeb loadRequest:request MIMEType:MIMEType textEncodingName:textEncodingName progress:progress success:success failure:failure];
}

@end
