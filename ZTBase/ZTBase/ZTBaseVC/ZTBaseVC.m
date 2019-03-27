//
//  ZTBaseVC.m
//  Notice
//
//  Created by ZWL on 15/9/7.
//  Copyright (c) 2015年 ZWL. All rights reserved.
//

#import "ZTBaseVC.h"
#import "ZTBase.h"

@interface ZTBaseVC ()
@property(nonatomic, assign) BOOL navBarTranslucent;
@property(nonatomic, assign) BOOL tabBarTranslucent;
@end

@implementation ZTBaseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.whiteColor;
    self.automaticallyAdjustsScrollViewInsets = YES;
    
    self.isClosePopGestureRecognizer = self.navigationController.viewControllers.count==1;
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    self.navigationItem.hidesBackButton = YES;
    if (self.navigationController.viewControllers.count>1) {
        self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithImage:imageNamed(@"nav_back") style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];
    }else{
        self.navigationItem.leftBarButtonItem = nil;
    }
    
    if ([self.baseViewModel respondsToSelector:@selector(viewDidLoad)]) {
        [self.baseViewModel performSelector:@selector(viewDidLoad) withObject:nil];
    }
}

-(void)goBack{
    if (self.popViewController) {
        self.popViewController();
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if (self.viewDidAppear) {
        self.viewDidAppear();
    }
    self.navigationController.interactivePopGestureRecognizer.enabled = !self.isClosePopGestureRecognizer;
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    if (self.viewWillDisappear) {
        self.viewWillDisappear();
    }
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setNavBarStyle:(ZTNavBarStyleDefault)];
    if (ZTBaseConfiguration.defaultConfig.themeColor) {
        self.navBarTintColor = ZTBaseConfiguration.defaultConfig.themeColor;
    }
    if (self.viewWillAppear) {
        self.viewWillAppear();
    }
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    if (self.viewDidDisappear) {
        self.viewDidDisappear();
    }
}

#pragma mark - setter
-(void)setIsClosePopGestureRecognizer:(BOOL)isClosePopGestureRecognizer{
    _isClosePopGestureRecognizer = isClosePopGestureRecognizer;
    self.navigationController.interactivePopGestureRecognizer.enabled = !isClosePopGestureRecognizer;
}

#pragma mark - getter
-(BOOL)navBarTranslucent{
    return self.navigationController.navigationBar.translucent;
}
-(BOOL)tabBarTranslucent{
    return self.tabBarController.tabBar.translucent;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    NSLog(@"%@ dealloc",[self class]);
}


@end
