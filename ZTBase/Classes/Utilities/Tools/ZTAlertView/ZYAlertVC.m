//
//  ZYAlertVC.m
//  ZYAlertView
//
//  Created by ZWL on 16/3/15.
//  Copyright © 2016年 ZWL. All rights reserved.
//

#import "ZYAlertVC.h"
#import "ZYAlertView.h"
#import "UIWindow+ZYUitily.h"

@implementation ZYAlertVC

-(void)loadView
{
    [super loadView];
    self.view = self.alertView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator{
    if ([self respondsToSelector:@selector(setNeedsStatusBarAppearanceUpdate)]) {
        [self setNeedsStatusBarAppearanceUpdate];
    }
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    UIViewController *viewController = [self.alertView.oldKeyWindow currentViewController];
    if (viewController) {
        return [viewController supportedInterfaceOrientations];
    }
    return UIInterfaceOrientationMaskAll;
}
- (BOOL)shouldAutorotate
{
    UIViewController *viewController = [self.alertView.oldKeyWindow currentViewController];
    if (viewController) {
        return [viewController shouldAutorotate];
    }
    return YES;
}

@end
