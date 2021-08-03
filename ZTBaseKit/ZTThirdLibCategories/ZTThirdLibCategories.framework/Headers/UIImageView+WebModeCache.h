//
//  UIImageView+WebModeCache.h
//  ZTCarOwner
//
//  Created by ZWL on 2017/12/21.
//  Copyright © 2017年 CITCC4. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (WebModeCache)

/**
 加载网路图片

 @param url 图片url
 @param placeholder 预加载图片
 */
-(void)setWebImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder;


/**
 加载网络图片

 @param url 图片url
 @param placeholder 预加载图片
 @param mode 图片显示模式
 */
-(void)setWebImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder contentMode:(UIViewContentMode)mode;


/**
 加载网络图片

 @param url 图片url
 @param placeholder 预加载图片
 @param mode 图片显示模式
 @param completion 图片加载完成回调
 */
-(void)setWebImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder contentMode:(UIViewContentMode)mode completion:(void(^)(BOOL isRequestSuccess))completion;

@end
