//
//  ZTAnimationManager.m
//  ZTCarOwner
//
//  Created by ZWL on 2018/7/24.
//  Copyright © 2018 ZWL. All rights reserved.
//

#import "ZTAnimationManager.h"

@implementation ZTAnimationManager

+(void)alertView:(UIView *)alertView animationInStyle:(ZTAlertViewAnimationStyle)style completion:(ZTAnimationCompletion)completion{
    switch (style) {
        case ZTAlertViewAnimationStyleSlideFromBottom:
        {
            CGRect rect = alertView.frame;
            CGRect originalRect = rect;
            rect.origin.y = alertView.bounds.size.height;
            alertView.frame = rect;
            [UIView animateWithDuration:0.25
                             animations:^{
                                 alertView.frame = originalRect;
                             }
                             completion:^(BOOL finished) {
                                 if (completion) {
                                     completion();
                                 }
                             }];
        }
            break;
        case ZTAlertViewAnimationStyleSlideFromTop:
        {
            CGRect rect = alertView.frame;
            CGRect originalRect = rect;
            rect.origin.y = -rect.size.height;
            alertView.frame = rect;
            [UIView animateWithDuration:0.3
                             animations:^{
                                 alertView.frame = originalRect;
                             }
                             completion:^(BOOL finished) {
                                 if (completion) {
                                     completion();
                                 }
                             }];
        }
            break;
        case ZTAlertViewAnimationStyleFade:
        {
            alertView.alpha = 0;
            [UIView animateWithDuration:0.3
                             animations:^{
                                 alertView.alpha = 1;
                             }
                             completion:^(BOOL finished) {
                                 if (completion) {
                                     completion();
                                 }
                             }];
        }
            break;
        case ZTAlertViewAnimationStyleBounce:
        {
            CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
            animation.values = @[@(0.01), @(1.2), @(0.9), @(1)];
            animation.keyTimes = @[@(0), @(0.4), @(0.6), @(1)];
            animation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear], [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear], [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
            animation.duration = 0.5;
            animation.delegate = (id)self;
            [animation setValue:completion forKey:@"handler"];
            [alertView.layer addAnimation:animation forKey:@"bounce"];
        }
            break;
        case ZTAlertViewAnimationStyleAlertBounce:
        {
            CAKeyframeAnimation * animation;
            animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
            animation.duration = 0.5;
            animation.delegate = (id)self;
            animation.removedOnCompletion = YES;
            animation.fillMode = kCAFillModeForwards;
            
            NSMutableArray *values = [NSMutableArray array];
            [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
            [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1.0)]];
            [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 0.9)]];
            [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
            
            animation.values = values;
            animation.timingFunction = [CAMediaTimingFunction functionWithName: @"easeInEaseOut"];
            [animation setValue:completion forKey:@"handler"];
            [alertView.layer addAnimation:animation forKey:@"alertBounce"];
        }
            break;
        case ZTAlertViewAnimationStyleDropDown:
        {
            CGFloat y = alertView.center.y;
            CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position.y"];
            animation.values = @[@(y - alertView.bounds.size.height), @(y + 20), @(y - 10), @(y)];
            animation.keyTimes = @[@(0), @(0.5), @(0.75), @(1)];
            animation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut], [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear], [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
            animation.duration = 0.4;
            animation.delegate = (id)self;
            [animation setValue:completion forKey:@"handler"];
            [alertView.layer addAnimation:animation forKey:@"dropdown"];
        }
            break;
        default:
            break;
    }
}

+(void)alertView:(UIView *)alertView animationOutStyle:(ZTAlertViewAnimationStyle)style completion:(ZTAnimationCompletion)completion{
    switch (style) {
        case ZTAlertViewAnimationStyleSlideFromBottom:
        {
            CGRect rect = alertView.frame;
            rect.origin.y = alertView.bounds.size.height;
            [UIView animateWithDuration:0.3
                                  delay:0
                                options:UIViewAnimationOptionCurveEaseIn
                             animations:^{
                                 alertView.frame = rect;
                             }
                             completion:^(BOOL finished) {
                                 if (completion) {
                                     completion();
                                 }
                             }];
        }
            break;
        case ZTAlertViewAnimationStyleSlideFromTop:
        {
            CGRect rect = alertView.frame;
            rect.origin.y = -rect.size.height;
            [UIView animateWithDuration:0.3
                                  delay:0
                                options:UIViewAnimationOptionCurveEaseIn
                             animations:^{
                                 alertView.frame = rect;
                             }
                             completion:^(BOOL finished) {
                                 if (completion) {
                                     completion();
                                 }
                             }];
        }
            break;
        case ZTAlertViewAnimationStyleFade:
        {
            [UIView animateWithDuration:0.25
                             animations:^{
                                 alertView.alpha = 0;
                             }
                             completion:^(BOOL finished) {
                                 if (completion) {
                                     completion();
                                 }
                             }];
        }
            break;
        case ZTAlertViewAnimationStyleBounce:
        {
            CGPoint point = alertView.center;
            point.y += alertView.bounds.size.height;
            [UIView animateWithDuration:0.3
                                  delay:0
                                options:UIViewAnimationOptionCurveEaseIn
                             animations:^{
                                 alertView.center = point;
                                 CGFloat angle = ((CGFloat)arc4random_uniform(100) - 50.f) / 100.f;
                                 alertView.transform = CGAffineTransformMakeRotation(angle);
                             }
                             completion:^(BOOL finished) {
                                 if (completion) {
                                     completion();
                                 }
                             }];
        }
            break;
        case ZTAlertViewAnimationStyleAlertBounce:
        {
            [UIView animateWithDuration:0.25
                             animations:^{
                                 alertView.alpha = 0;
                             }
                             completion:^(BOOL finished) {
                                 if (completion) {
                                     completion();
                                 }
                             }];
        }
            break;
        case ZTAlertViewAnimationStyleDropDown:
        {
            CGPoint point = alertView.center;
            point.y += alertView.bounds.size.height;
            [UIView animateWithDuration:0.3
                                  delay:0
                                options:UIViewAnimationOptionCurveEaseIn
                             animations:^{
                                 alertView.center = point;
                                 CGFloat angle = ((CGFloat)arc4random_uniform(100) - 50.f) / 100.f;
                                 alertView.transform = CGAffineTransformMakeRotation(angle);
                             }
                             completion:^(BOOL finished) {
                                 if (completion) {
                                     completion();
                                 }
                             }];
        }
            break;
        default:
            break;
    }
}

@end
