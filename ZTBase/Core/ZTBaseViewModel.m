//
//  ZTBaseViewModel.m
//  ZTCloudMirror
//
//  Created by ZWL on 2018/8/30.
//  Copyright © 2018 ZWL. All rights reserved.
//

#import "ZTBaseViewModel.h"
#import "ZTWeakObject.h"
#import "ZTBaseDefines.h"

@interface ZTBaseViewModel ()
@property(nonatomic, strong) UIViewController * viewController;
@property(nonatomic, strong) UINavigationController * navigationController;
@property(nonatomic, strong) UINavigationItem * navigationItem;
@property(nonatomic, strong) UIView * view;
@end

@implementation ZTBaseViewModel

- (instancetype)initWithViewController:(UIViewController *)viewController{
    if (self = [super init]) {
        
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
        if ([viewController respondsToSelector:@selector(setBaseViewModel:)]) {
            [viewController performSelector:@selector(setBaseViewModel:) withObject:self];
        }
#pragma clang diagnostic pop
        UIViewController *weakVC = (UIViewController *)[ZTWeakObject weakObject:viewController];
        self.viewController = weakVC;
    }
    return self;
}


-(void)setViewContainingController:(UIViewController *)viewController{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
    if ([viewController respondsToSelector:@selector(setBaseViewModel:)]) {
        [viewController performSelector:@selector(setBaseViewModel:) withObject:self];
    }
#pragma clang diagnostic pop
    UIViewController *weakVC = (UIViewController *)[ZTWeakObject weakObject:viewController];
    self.viewController = weakVC;
}

-(BOOL)navBarTranslucent{
    return self.viewController.navigationController.navigationBar.translucent;
}
-(BOOL)tabBarTranslucent{
    return self.viewController.tabBarController.tabBar.translucent;
}
-(UIView *)view{
    return self.viewController.view;
}
-(UINavigationItem *)navigationItem{
    return self.viewController.navigationItem;
}
-(UINavigationController *)navigationController{
    return self.viewController.navigationController;
}

+ (instancetype)viewModel{
    return [[self alloc] init];
}

+ (instancetype)viewModelWithViewController:(UIViewController *)viewController{
    return [[self alloc] initWithViewController:viewController];
}

-(void)viewDidLoad{
    
}



@end
