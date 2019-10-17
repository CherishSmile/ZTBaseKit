//
//  ZTWebVC.m
//  ZTCarOwner
//
//  Created by ZWL on 2017/8/25.
//  Copyright © 2017年 CITCC4. All rights reserved.
//

#import "ZTWebVC.h"
#import "UINavigationController+SGProgress.h"
#import "ZTScriptMessageHandler.h"
#import "ZTBaseFunction.h"
#import <Masonry/Masonry.h>

@interface ZTWebVC ()<ZTWebViewDelegate,ZTWebScriptMessageHandler>

@property(nonatomic, strong) ZTWebView * baseWebView;

@property(nonatomic,strong)UIBarButtonItem * closeItem;
@property(nonatomic,strong)UIBarButtonItem * backItem;
@property(nonatomic,strong)ZTWebManager * webManager;

@end

@implementation ZTWebVC

-(instancetype)init{
    if (self = [super init]) {
        self.isUseWebTitle = true;
        self.isShowProgress = true;
        self.progressColor = UIColorFromRGB(0x25A8F5);
        self.progressHeight = 2;
    }
    return self;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = self.isHiddenNavBar;
    self.navigationController.navigationBar.translucent = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.progressHeight = self.progressHeight;
    
    if (self.isUseLocation) {
        ZTShowLocationPermissionAlert(nil);
    }
    
    [self setNavBarItem];
    [self createSubviews];
    [self initWebConfig];
    
    [self loadHtml:self.urlString];

}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = self.isHiddenNavBar;
    self.navigationController.navigationBar.translucent = NO;
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController hiddenSGProgress];
}

-(void)setNavBarItem{
    self.navigationItem.leftBarButtonItems = @[self.backItem];
}

- (void)createSubviews{
    [self.view addSubview:self.baseWebView];
    [self.baseWebView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(self.mas_topLayoutGuideBottom);
        make.bottom.mas_equalTo(self.mas_bottomLayoutGuideTop);
    }];
}

-(void)initWebConfig{
    if (self.webManagerClass) {
        id manager = [[self.webManagerClass alloc] init];
        if ([manager isKindOfClass:ZTWebManager.class]) {
            self.webManager = [[self.webManagerClass alloc] initWithWebView:self.baseWebView];
        }else{
            self.webManager = [[ZTWebManager alloc] initWithWebView:self.baseWebView];
        }
    }else{
        self.webManager = [[ZTWebManager alloc] initWithWebView:self.baseWebView];
    }
}

-(void)goBack{
    if ([self.baseWebView canGoBack]) {
        [self.baseWebView goBack];
        ZTDismissProgressDialog(self.view);
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}
-(void)closeClick{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - public method

/**
 清除网页缓存
 */
-(void)clearWebCache{
    [self.webManager clearWebCache];
}

/**
 加载html

 @param urlString html地址
 */
-(void)loadHtml:(NSString *)urlString{
    [self clearWebCache];
    [self.webManager loadHtml:urlString];
}


/**
 js调用OC 添加处理脚本
 
 @param messageNames OC方法名数组
 */
-(void)addJavaScriptMessages:(NSArray<NSString *> *)messageNames{
    [self.webManager addJavaScriptMessages:messageNames];
}

-(void)addUserScript:(NSArray<NSString*>*)userScripts{
    [self.webManager addUserScript:userScripts];
}
-(void)callJavaScript:(NSString *)jsMethod completionHandler:(CompletionHandler)completionHandler{
    [self.webManager callJavaScript:jsMethod completionHandler:^(id _Nullable result, NSError * _Nullable error) {
        if (completionHandler) {
            completionHandler(result,error);
        }
    }];
}


#pragma mark - ZTWebViewDelegate

-(void)webView:(ZTWebView *)webView didReceiveScriptMessageWithFunctionName:(NSString *)name functionParameters:(id)parameters{
    [self.webManager webView:webView didReceiveScriptMessageWithFunctionName:name functionParameters:parameters];
}

// 页面开始加载时调用
-(void)webView:(ZTWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    
}
// 当内容开始返回时调用
-(void)webView:(ZTWebView *)webView didCommitNavigation:(WKNavigation *)navigation{

}
// 页面加载完成之后调用
-(void)webView:(ZTWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    if ([webView canGoBack]) {
        self.navigationItem.leftBarButtonItems = @[self.backItem,self.closeItem];
    }else{
        self.navigationItem.leftBarButtonItems = @[self.backItem];
    }
}
// 页面加载失败时调用
-(void)webView:(ZTWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error{
    
}

#pragma mark - setter
-(void)setIsShowProgress:(BOOL)isShowProgress{
    _isShowProgress = isShowProgress;
}

-(void)setIsUseWebTitle:(BOOL)isUseWebTitle{
    _isUseWebTitle = isUseWebTitle;
}

#pragma mark - getter
-(ZTWebView *)baseWebView{
    if (!_baseWebView) {
        _baseWebView = [[ZTWebView alloc] initWithFrame:CGRectZero webType:self.isUseUIWeb];
        _baseWebView.delegate = self;
        _baseWebView.backgroundColor = ZTBackColor;
        _baseWebView.allowsInlineMediaPlayback = YES;
        _baseWebView.mediaPlaybackRequiresUserAction = YES;
        if (@available(iOS 11.0, *)) {
            _baseWebView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            // Fallback on earlier versions
        }
        @WeakObj(self);
        _baseWebView.webTitleHandler = ^(NSString * _Nonnull title) {
            @StrongObj(self);
            if (self.isUseWebTitle) {
                self.navigationItem.title = ZTStringFromNullableString(title);
            }
        };
        _baseWebView.estimatedProgressHandler = ^(CGFloat estimatedProgress, NSError * _Nonnull error) {
            @StrongObj(self);
            if (self.isShowProgress) {
                [self.navigationController setSGProgressPercentage:estimatedProgress*100 andTintColor:self.progressColor];
            }
        };
    }
    return _baseWebView;
}


-(UIBarButtonItem *)closeItem{
    if (!_closeItem) {
        _closeItem = [[UIBarButtonItem alloc] initWithImage:ZTImageWithNamed(@"web_guanbi") style:(UIBarButtonItemStylePlain) target:self action:@selector(closeClick)];
    }
    return _closeItem;
}

-(UIBarButtonItem *)backItem{
    if (!_backItem) {
        _backItem = [[UIBarButtonItem alloc] initWithImage:ZTImageWithNamed(@"nav_back") style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];
    }
    return _backItem;
}


-(void)dealloc{
    [self.webManager removeScript];
    [NFCenter removeObserver:self];
}

@end
