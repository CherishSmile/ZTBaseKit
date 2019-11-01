//
//  ZTAnimationManager.h
//  ZTCarOwner
//
//  Created by ZWL on 2018/7/24.
//  Copyright © 2018 ZWL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
/**
 alert弹出的动画样式
 
 - ZTAlertViewAnimationStyleSlideFromBottom: 从底部弹出
 - ZTAlertViewAnimationStyleSlideFromTop: 从顶部弹出
 - ZTAlertViewAnimationStyleFade: 渐变出现
 - ZTAlertViewAnimationStyleBounce: 弹性出现
 - ZTAlertViewAnimationStyleDropDown: 水滴降落出现
 */
typedef NS_ENUM(NSInteger,ZTAlertViewAnimationStyle) {
    ZTAlertViewAnimationStyleSlideFromBottom = 0,
    ZTAlertViewAnimationStyleSlideFromTop,
    ZTAlertViewAnimationStyleFade,
    ZTAlertViewAnimationStyleBounce,
    ZTAlertViewAnimationStyleAlertBounce,
    ZTAlertViewAnimationStyleDropDown
};

typedef void(^ZTAnimationCompletion)(void);

@interface ZTAnimationManager : NSObject

+(void)alertView:(UIView *)alertView animationInStyle:(ZTAlertViewAnimationStyle)style completion:(ZTAnimationCompletion)completion;

+(void)alertView:(UIView *)alertView animationOutStyle:(ZTAlertViewAnimationStyle)style completion:(ZTAnimationCompletion)completion;

@end
