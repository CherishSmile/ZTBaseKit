//
//  ZTUIWebViewProgress.h
//  ZTCarOwner
//
//  Created by ZWL on 2018/3/10.
//  Copyright © 2018年 ZWL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#undef zt_weak
#if __has_feature(objc_arc_weak)
#define zt_weak weak
#else
#define zt_weak unsafe_unretained
#endif

extern const float ZTInitialProgressValue;
extern const float ZTInteractiveProgressValue;
extern const float ZTFinalProgressValue;

typedef void (^ZTUIWebViewProgressBlock)(float progress);
@protocol ZTUIWebViewProgressDelegate;
@interface ZTUIWebViewProgress : NSObject<UIWebViewDelegate>
@property (nonatomic, zt_weak) id<ZTUIWebViewProgressDelegate>progressDelegate;
@property (nonatomic, zt_weak) id<UIWebViewDelegate>webViewProxyDelegate;
@property (nonatomic, copy) ZTUIWebViewProgressBlock progressBlock;
@property (nonatomic, readonly) float progress; // 0.0..1.0

- (void)reset;
@end

@protocol ZTUIWebViewProgressDelegate <NSObject>
- (void)webViewProgress:(ZTUIWebViewProgress *)webViewProgress updateProgress:(float)progress;
@end

