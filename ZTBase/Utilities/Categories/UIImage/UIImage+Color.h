//
//  UIImage+Color.h
//  ZTCarOwner
//
//  Created by ZWL on 2017/11/21.
//  Copyright © 2017年 CITCC4. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Color)

/**
 *  @brief  根据颜色生成纯色图片
 *
 *  @param color 颜色
 *
 *  @return 纯色图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color;
/**
 *  @brief  根据颜色生成纯色图片
 *
 *  @param color 颜色
 *
 *  @param imageRect 图片大小
 *
 *  @return 纯色图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color frame:(CGRect)imageRect;
/**
 *  @brief  取图片某一点的颜色
 *
 *  @param point 某一点
 *
 *  @return 颜色
 */
- (UIColor *)colorAtPoint:(CGPoint )point;
//more accurate method ,colorAtPixel 1x1 pixel
/**
 *  @brief  取某一像素的颜色
 *
 *  @param point 一像素
 *
 *  @return 颜色
 */
- (UIColor *)colorAtPixel:(CGPoint)point;
/**
 *  @brief  返回该图片是否有透明度通道
 *
 *  @return 是否有透明度通道
 */
- (BOOL)hasAlphaChannel;

/**
 *  @brief  获得灰度图
 *
 *  @param sourceImage 图片
 *
 *  @return 获得灰度图片
 */
+ (UIImage*)covertToGrayImageFromImage:(UIImage*)sourceImage;

/**
 *  @brief  改变图片的透明度
 *
 *  @param alpha 透明度
 *
 *  @return 修改透明度后的图片
 */
- (UIImage*)imageByApplyingAlpha:(CGFloat)alpha;

@end
