//
//  ZTWebView.h
//  ZTCarOwner
//
//  Created by ZWL on 2019/1/28.
//  Copyright © 2019 CITCC4. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
#import <ZTBase/ZTScriptMessageHandler.h>

NS_ASSUME_NONNULL_BEGIN


typedef void(^ZTWebViewEstimatedProgressHandler)(CGFloat estimatedProgress,NSError * error);

typedef void(^ZTWebViewTitleHandler)(NSString * title);


@interface ZTWebViewConfiguration : NSObject

@property(nonatomic, assign) BOOL  loadSandboxFile;
@property(nonatomic, copy) NSString * loadFilePath;
@property(nonatomic, copy) NSString * allowingReadAccessToPath;

@property(nonatomic, assign) BOOL  allowsInlineMediaPlayback;
@property(nonatomic, assign) BOOL  mediaPlaybackRequiresUserAction;

@end


@protocol ZTWebViewDelegate;
@protocol ZTWebScriptMessageHandler;

@interface ZTWebView : UIView

- (instancetype)initWithFrame:(CGRect)frame configuration:(ZTWebViewConfiguration *)configuration;


@property(nonatomic, weak) id<ZTWebViewDelegate> delegate;

@property(nonatomic, strong, readonly) WKWebView * baseWKWeb;
@property(nonatomic, strong, readonly) UIScrollView *scrollView;

- (void)loadRequest:(NSURLRequest *)request;
- (void)loadHTMLString:(NSString *)string baseURL:(nullable NSURL *)baseURL;
- (void)loadData:(NSData *)data MIMEType:(NSString *)MIMEType textEncodingName:(NSString *)textEncodingName baseURL:(NSURL *)baseURL;
- (nullable WKNavigation *)loadFileURL:(NSURL *)URL allowingReadAccessToURL:(NSURL *)readAccessURL API_AVAILABLE(macos(10.11), ios(9.0));

@property(nonatomic, strong, readonly) ZTWebViewConfiguration * configuration;

@property(nonatomic, strong, readonly) WKWebViewConfiguration * wkConfiguration;

@property(nullable, nonatomic, readonly, copy) NSURL *URL;

@property(nonatomic, assign, readonly) CGFloat  estimatedProgress;

@property(nonatomic, copy, readonly) NSString * title;

@property(nonatomic, copy) ZTWebViewEstimatedProgressHandler estimatedProgressHandler;

@property(nonatomic, copy) ZTWebViewTitleHandler webTitleHandler;

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


@end

@protocol ZTWebScriptMessageHandler <NSObject>

@optional

-(void)webView:(ZTWebView *)webView didReceiveScriptMessageWithFunctionName:(NSString *)name functionParameters:(id)parameters;

-(void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message;

@end


NS_ASSUME_NONNULL_END
