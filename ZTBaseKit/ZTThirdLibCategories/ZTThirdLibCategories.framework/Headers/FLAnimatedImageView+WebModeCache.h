//
//  FLAnimatedImageView+WebModeCache.h
//  ZTCloudMirror
//
//  Created by ZWL on 2019/9/2.
//  Copyright © 2019 CITCC4. All rights reserved.
//

#import <FLAnimatedImage/FLAnimatedImage.h>

NS_ASSUME_NONNULL_BEGIN

@interface FLAnimatedImageView (WebModeCache)

/**
 加载网路图片
 
 @param url 图片url
 @param placeholder 预加载图片
 */
-(void)setWebImageWithURL:(NSURL *)url placeholderImage:(nullable UIImage *)placeholder;


/**
 加载网络图片
 
 @param url 图片url
 @param placeholder 预加载图片
 @param mode 图片显示模式
 */
-(void)setWebImageWithURL:(NSURL *)url placeholderImage:(nullable UIImage *)placeholder contentMode:(UIViewContentMode)mode;


/**
 加载网络图片
 
 @param url 图片url
 @param placeholder 预加载图片
 @param mode 图片显示模式
 @param completion 图片加载完成回调
 */
-(void)setWebImageWithURL:(NSURL *)url placeholderImage:(nullable UIImage *)placeholder contentMode:(UIViewContentMode)mode completion:(void(^)(BOOL isRequestSuccess))completion;

@end

NS_ASSUME_NONNULL_END
