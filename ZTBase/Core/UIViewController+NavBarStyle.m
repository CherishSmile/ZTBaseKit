//
//  UIViewController+NavBarAlpha.m
//  ZTCarOwner
//
//  Created by ZWL on 2018/8/15.
//  Copyright © 2018 ZWL. All rights reserved.
//

#import "UIViewController+NavBarStyle.h"
#import <objc/runtime.h>
#import <KMNavigationBarTransition/KMNavigationBarTransition.h>
#import "UIImage+Color.h"
#import "ZTBaseDefines.h"
#import "ZTBaseFunction.h"

@interface UIViewController ()
@property(nonatomic, assign) BOOL  isSetedStyle;
@end

@implementation UIViewController (NavBarStyle)

-(void)setIsSetedStyle:(BOOL)isSetedStyle{
    objc_setAssociatedObject(self, @selector(isSetedStyle), @(isSetedStyle), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(BOOL)isSetedStyle{
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

-(CGFloat)navBarHeight{
    return CGRectGetHeight(UIApplication.sharedApplication.statusBarFrame)+CGRectGetHeight(self.navigationController.navigationBar.frame);
}

/**
 导航样式
 */
-(void)setBarStyle:(ZTNavBarStyle)barStyle{
    objc_setAssociatedObject(self, @selector(barStyle), @(barStyle), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(ZTNavBarStyle)barStyle{
    return [objc_getAssociatedObject(self, _cmd) integerValue];
}

/**
 导航样式状态
 */
-(void)setBarStatus:(ZTNavBarStatus)barStatus{
    objc_setAssociatedObject(self, @selector(barStatus), @(barStatus), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(ZTNavBarStatus)barStatus{
    return [objc_getAssociatedObject(self, _cmd) integerValue];
}

/**
 导航透明度
 */
-(void)setBarAlpha:(CGFloat)alpha{
    objc_setAssociatedObject(self, @selector(barAlpha), @(alpha), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (alpha<=0) {
        [self setBarStatus:ZTNavBarStatusClear];
        [self.navigationController.navigationBar setBackgroundImage:UIImage.new forBarMetrics:(UIBarMetricsDefault)];
    }else if(alpha<1){
        [self setBarStatus:ZTNavBarStatusTranslucent];
        UIImage *newBackgroundImage = [UIImage imageWithColor:self.navigationController.navigationBar.barTintColor];
        newBackgroundImage = [newBackgroundImage imageByApplyingAlpha:alpha];
        [self.navigationController.navigationBar setBackgroundImage:newBackgroundImage forBarMetrics:(UIBarMetricsDefault)];
    }else{
        [self setBarStatus:ZTNavBarStatusOpacity];
        [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:(UIBarMetricsDefault)];
    }
}
-(CGFloat)barAlpha{
    return [objc_getAssociatedObject(self, _cmd) floatValue];
}

-(void)setNavBarTintColor:(UIColor *)navBarTintColor{
    objc_setAssociatedObject(self, @selector(navBarTintColor), navBarTintColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    self.navigationController.navigationBar.barTintColor = navBarTintColor;
}
-(UIColor *)navBarTintColor{
    return objc_getAssociatedObject(self, _cmd);
}

/**
 导航栏上字体颜色
 */
-(void)setNavTintColor:(UIColor *)navTintColor{
    objc_setAssociatedObject(self, @selector(navTintColor), navTintColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    self.navigationController.navigationBar.tintColor = navTintColor;
    
}
-(UIColor *)navTintColor{
    return objc_getAssociatedObject(self, _cmd);
}

/**
 导航栏标题颜色
 */
-(void)setNavTitleColor:(UIColor *)navTitleColor{
    objc_setAssociatedObject(self, @selector(navTitleColor), navTitleColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self setNavBarTitleTextAttributes:navTitleColor];
}
-(UIColor *)navTitleColor{
    return objc_getAssociatedObject(self, _cmd);
}

/**
 设置导航样式(放在viewWillAppear中，可控制每个不同的NavBar)
 
 @param style 样式
 */
-(void)setNavBarStyle:(ZTNavBarStyle)style{
    UINavigationController * naviController = self.navigationController;
    UINavigationBar * naviBar = self.navigationController.navigationBar;
    switch (style) {
        case ZTNavBarStyleWhite:
        {
            if (!self.isSetedStyle) {
                [self setNavBarTitleTextAttributes:ZTTextPaleGrayColor];
                self.navTitleColor = ZTTextPaleGrayColor;
                naviBar.tintColor = ZTTextPaleGrayColor;
                self.navTintColor = ZTTextPaleGrayColor;
                naviBar.shadowImage = UIImage.new;
                naviBar.barTintColor = UIColor.whiteColor;
                self.navBarTintColor = UIColor.whiteColor;
                [self setBarAlpha:1];
                self.isSetedStyle = YES;
            }else{
                [self setNavBarTitleTextAttributes:self.navTitleColor];
                naviBar.tintColor = self.navTintColor;
                naviBar.barTintColor = self.navBarTintColor;
                [self setBarAlpha:self.barAlpha];
                naviBar.shadowImage = UIImage.new;
            }
            
        }
            break;
        case ZTNavBarStyleBlack:
        {
            if (!self.isSetedStyle) {
                
                /**设置导航标题颜色*/
                [self setNavBarTitleTextAttributes:UIColor.whiteColor];
                self.navTitleColor = UIColor.whiteColor;
                
                /**设置导航左右字体颜色*/
                naviBar.tintColor = UIColor.whiteColor;
                self.navTintColor = UIColor.whiteColor;
                
                /**设置导航背景颜色*/
                naviBar.barTintColor = UIColor.blackColor;
                self.navBarTintColor = UIColor.blackColor;
                
                /**设置导航透明度*/
                [self setBarAlpha:1];
                /**设置导航底部线条*/
                naviBar.shadowImage = UIImage.new;
                
                self.isSetedStyle = YES;
            }else{
                [self setNavBarTitleTextAttributes:self.navTitleColor];
                naviBar.tintColor = self.navTintColor;
                naviBar.barTintColor = self.navBarTintColor;
                [self setBarAlpha:self.barAlpha];
                naviBar.shadowImage = UIImage.new;
            }
            
        }
            break;
        case ZTNavBarStyleClear:
        {
            if (!self.isSetedStyle) {
                naviBar.shadowImage = UIImage.new;
                [self setNavBarTitleTextAttributes:ZTTextPaleGrayColor];
                self.navTitleColor = ZTTextPaleGrayColor;
                naviBar.tintColor = UIColor.whiteColor;
                self.navTintColor = UIColor.whiteColor;
                naviBar.barTintColor = UIColor.whiteColor;
                self.navBarTintColor = UIColor.whiteColor;
                [self setBarAlpha:0];
    
                self.isSetedStyle = YES;
            }else{
                [self setNavBarTitleTextAttributes:self.navTitleColor];
                naviBar.tintColor = self.navTintColor;
                naviBar.barTintColor = self.navBarTintColor;
                [self setBarAlpha:self.barAlpha];
                naviBar.shadowImage = UIImage.new;
            }
        }
            break;
            
        default:
            break;
    }
    if (naviController.navigationBarHidden != NO) {
        naviController.navigationBarHidden = NO;
    }
    if (naviBar.translucent != YES) {
        naviBar.translucent = YES;
    }
    [self setBarStyle:style];
}


-(void)setNavBarTitleTextAttributes:(UIColor *)textColor{
    self.navigationController.navigationBar.titleTextAttributes=@{
                                                                  NSForegroundColorAttributeName:textColor,
                                                                  NSFontAttributeName:GetBoldFont(F7)
                                                                  };
}
@end
