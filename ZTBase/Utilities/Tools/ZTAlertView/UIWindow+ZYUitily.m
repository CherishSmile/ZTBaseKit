//
//  UIWindow+ZYUitily.m
//  ZYAlertView
//
//  Created by ZWL on 16/3/15.
//  Copyright © 2016年 ZWL. All rights reserved.
//

#import "UIWindow+ZYUitily.h"

@implementation UIWindow (ZYUitily)
-(UIViewController *)currentViewController
{
    UIViewController * viewController = self.rootViewController;
    while (viewController.presentedViewController) {
        viewController = viewController.presentedViewController;
    }
    return viewController;
}

@end
