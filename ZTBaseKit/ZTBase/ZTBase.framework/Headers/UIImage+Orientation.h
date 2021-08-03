//
//  UIImage+Orientation.h
//  ZTCarOwner
//
//  Created by ZWL on 2017/11/20.
//  Copyright © 2017年 CITCC4. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Orientation)

/**
 修正图片方向

 @param aImage 原始图片
 @return 修正后的图片
 */
+ (UIImage *)fixOrientation:(UIImage *)aImage;

/** 按给定的方向旋转图片 */
- (UIImage *)rotate:(UIImageOrientation)orient;

/** 将图片旋转弧度radians */
- (UIImage *)imageRotatedByRadians:(CGFloat)radians;

@end
