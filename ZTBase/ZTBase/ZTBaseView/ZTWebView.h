//
//  ZTWebView.h
//  ZTCarOwner
//
//  Created by ZWL on 2019/1/28.
//  Copyright © 2019 CITCC4. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
#import "ZTScriptMessageHandler.h"
#import <AFNetworking/UIWebView+AFNetworking.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger,ZTWebViewType) {
    ZTWebViewTypeWKWebView,
    ZTWebViewTypeUIWebView
};


typedef void(^ZTWebViewEstimatedProgressHandler)(CGFloat estimatedProgress,NSError * error);

typedef void(^ZTWebViewTitleHandler)(NSString * title);

@protocol ZTWebViewDelegate;
@protocol ZTWebScriptMessageHandler;

@interface ZTWebView : UIView

- (instancetype)initWithFrame:(CGRect)frame webType:(ZTWebViewType)webType;


@property(nonatomic, weak) id<ZTWebViewDelegate> delegate;
@property(nonatomic, readonly, strong) UIScrollView *scrollView;

- (void)loadRequest:(NSURLRequest *)request;
- (void)loadHTMLString:(NSString *)string baseURL:(nullable NSURL *)baseURL;
- (void)loadData:(NSData *)data MIMEType:(NSString *)MIMEType textEncodingName:(NSString *)textEncodingName baseURL:(NSURL *)baseURL;

@property(nonatomic, assign, readonly) ZTWebViewType  webType;

@property(nonatomic, copy) NSString * webScheme;

@property(nonatomic, assign) BOOL  allowsInlineMediaPlayback;

@property(nonatomic, assign) BOOL  mediaPlaybackRequiresUserAction;

@property(nullable, nonatomic, readonly, copy) NSURL *URL;

@property(nonatomic, assign, readonly) CGFloat  estimatedProgress;

@property(nonatomic, copy, readonly) NSString * title;

@property(nonatomic, copy) ZTWebViewEstimatedProgressHandler estimatedProgressHandler;

@property(nonatomic, copy) ZTWebViewTitleHandler webTitleHandler;

@property(nonatomic, strong, readonly) WKWebViewConfiguration * configuration;

@property(nonatomic, strong) ZTScriptMessageHandler * messageHandler;

- (void)reload;
- (void)stopLoading;

- (void)goBack;
- (void)goForward;

@property (nonatomic, readonly, getter=canGoBack) BOOL canGoBack;
@property (nonatomic, readonly, getter=canGoForward) BOOL canGoForward;
@property (nonatomic, readonly, getter=isLoading) BOOL loading;


- (nullable NSString *)evaluateJavaScript:(NSString *)javaScriptString completionHandler:(void (^ _Nullable)(_Nullable id, NSError * _Nullable error))completionHandler;

@end

@protocol ZTWebViewDelegate <NSObject>
@optional
/*! @abstract Decides whether to allow or cancel a navigation.
 @param webView The web view invoking the delegate method.
 @param navigationAction Descriptive information about the action
 triggering the navigation request.
 @param decisionHandler The decision handler to call to allow or cancel the
 navigation. The argument is one of the constants of the enumerated type WKNavigationActionPolicy.
 @discussion If you do not implement this method, the web view will load the request or, if appropriate, forward it to another application.
 */
- (void)webView:(ZTWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler;

/*! @abstract Decides whether to allow or cancel a navigation after its
 response is known.
 @param webView The web view invoking the delegate method.
 @param navigationResponse Descriptive information about the navigation
 response.
 @param decisionHandler The decision handler to call to allow or cancel the
 navigation. The argument is one of the constants of the enumerated type WKNavigationResponsePolicy.
 @discussion If you do not implement this method, the web view will allow the response, if the web view can show it.
 */
- (void)webView:(ZTWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler;

/*! @abstract Invoked when a main frame navigation starts.
 @param webView The web view invoking the delegate method.
 @param navigation The navigation.
 */
- (void)webView:(ZTWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation;

/*! @abstract Invoked when a server redirect is received for the main
 frame.
 @param webView The web view invoking the delegate method.
 @param navigation The navigation.
 */
- (void)webView:(ZTWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(null_unspecified WKNavigation *)navigation;

/*! @abstract Invoked when an error occurs while starting to load data for
 the main frame.
 @param webView The web view invoking the delegate method.
 @param navigation The navigation.
 @param error The error that occurred.
 */
- (void)webView:(ZTWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error;

/*! @abstract Invoked when content starts arriving for the main frame.
 @param webView The web view invoking the delegate method.
 @param navigation The navigation.
 */
- (void)webView:(ZTWebView *)webView didCommitNavigation:(null_unspecified WKNavigation *)navigation;

/*! @abstract Invoked when a main frame navigation completes.
 @param webView The web view invoking the delegate method.
 @param navigation The navigation.
 */
- (void)webView:(ZTWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation;

/*! @abstract Invoked when an error occurs during a committed main frame
 navigation.
 @param webView The web view invoking the delegate method.
 @param navigation The navigation.
 @param error The error that occurred.
 */
- (void)webView:(ZTWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error;

/*! @abstract Invoked when the web view needs to respond to an authentication challenge.
 @param webView The web view that received the authentication challenge.
 @param challenge The authentication challenge.
 @param completionHandler The completion handler you must invoke to respond to the challenge. The
 disposition argument is one of the constants of the enumerated type
 NSURLSessionAuthChallengeDisposition. When disposition is NSURLSessionAuthChallengeUseCredential,
 the credential argument is the credential to use, or nil to indicate continuing without a
 credential.
 @discussion If you do not implement this method, the web view will respond to the authentication challenge with the NSURLSessionAuthChallengeRejectProtectionSpace disposition.
 */
- (void)webView:(ZTWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential * _Nullable credential))completionHandler;

/*! @abstract Invoked when the web view's web content process is terminated.
 @param webView The web view whose underlying web content process was terminated.
 */
- (void)webViewWebContentProcessDidTerminate:(ZTWebView *)webView API_AVAILABLE(macosx(10.11), ios(9.0));


/**
 UIWebViewDelegate
 */
- (BOOL)webView:(ZTWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType API_DEPRECATED("No longer supported.", ios(2.0, 12.0));


@end

@protocol ZTWebScriptMessageHandler <NSObject>

@optional

-(void)webView:(ZTWebView *)webView didReceiveScriptMessageWithFunctionName:(NSString *)name functionParameters:(id)parameters;

-(void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message;

@end

@interface ZTWebView (UIWebViewHandler)
/**
 The session manager used to download all requests.
 */
@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;

/**
 Asynchronously loads the specified request.
 
 @param request A URL request identifying the location of the content to load. This must not be `nil`.
 @param progress A progress object monitoring the current download progress.
 @param success A block object to be executed when the request finishes loading successfully. This block returns the HTML string to be loaded by the web view, and takes two arguments: the response, and the response string.
 @param failure A block object to be executed when the data task finishes unsuccessfully, or that finishes successfully, but encountered an error while parsing the response data. This block has no return value and takes a single argument: the error that occurred.
 */
- (void)loadRequest:(NSURLRequest *)request
           progress:(NSProgress * _Nullable __autoreleasing * _Nullable)progress
            success:(nullable NSString * (^)(NSHTTPURLResponse *response, NSString *HTML))success
            failure:(nullable void (^)(NSError *error))failure;

/**
 Asynchronously loads the data associated with a particular request with a specified MIME type and text encoding.
 
 @param request A URL request identifying the location of the content to load. This must not be `nil`.
 @param MIMEType The MIME type of the content. Defaults to the content type of the response if not specified.
 @param textEncodingName The IANA encoding name, as in `utf-8` or `utf-16`. Defaults to the response text encoding if not specified.
 @param progress A progress object monitoring the current download progress.
 @param success A block object to be executed when the request finishes loading successfully. This block returns the data to be loaded by the web view and takes two arguments: the response, and the downloaded data.
 @param failure A block object to be executed when the data task finishes unsuccessfully, or that finishes successfully, but encountered an error while parsing the response data. This block has no return value and takes a single argument: the error that occurred.
 */
- (void)loadRequest:(NSURLRequest *)request
           MIMEType:(nullable NSString *)MIMEType
   textEncodingName:(nullable NSString *)textEncodingName
           progress:(NSProgress * _Nullable __autoreleasing * _Nullable)progress
            success:(nullable NSData * (^)(NSHTTPURLResponse *response, NSData *data))success
            failure:(nullable void (^)(NSError *error))failure;
@end




NS_ASSUME_NONNULL_END
