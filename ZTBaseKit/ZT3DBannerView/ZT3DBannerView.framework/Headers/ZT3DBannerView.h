//
//  ZT3DBannerView.h
//
//  Created by ZWL on 2017/12/26.
//  Copyright © 2017年 CITCC4 All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

//! Project version number for ZT3DBannerView.
FOUNDATION_EXPORT double ZT3DBannerViewVersionNumber;

//! Project version string for ZT3DBannerView.
FOUNDATION_EXPORT const unsigned char ZT3DBannerViewVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <ZT3DBannerView/PublicHeader.h>
#import <ZT3DBannerView/ZTPageControl.h>
#import <ZT3DBannerView/UIView+Banner.h>

#import "ZTPageControl.h"

@class ZT3DBannerView;
@protocol ZT3DBannerViewDelegate <UIScrollViewDelegate>

@optional

-(void)bannerView:(ZT3DBannerView *)bannerView didClickImageAtIndex:(NSInteger)currentIndex;

@end


@interface ZT3DBannerView : UIView<UIScrollViewDelegate>
/**
 图片间有间距  又要有翻页效果～～
 @param imageSpacing 图片间 间距
 @param imageWidth 图片宽
 */
+(instancetype)initWithFrame:(CGRect)frame
                imageSpacing:(CGFloat)imageSpacing
                  imageWidth:(CGFloat)imageWidth;
/**
 图片间有间距  又要有翻页效果～～
 @param imageSpacing 图片间 间距
 @param imageWidth 图片宽
 @param data 数据
 */
+(instancetype)initWithFrame:(CGRect)frame
                imageSpacing:(CGFloat)imageSpacing
                  imageWidth:(CGFloat)imageWidth
                        data:(NSArray *)data;


@property(nonatomic, weak) id<ZT3DBannerViewDelegate> delegate;

/** 点击中间图片的回调 */
@property (nonatomic, copy) void (^clickImageBlock)(NSInteger currentIndex);
/** 图片的圆角半径 */
@property (nonatomic, assign) CGFloat imageRadius;
/** 数据源 */
@property (nonatomic, strong) NSArray * imageData;
/** 图片高度差 默认0 */
@property (nonatomic, assign) CGFloat imageHeightPoor;
/** 初始alpha默认1 */
@property (nonatomic, assign) CGFloat initAlpha;

/** 是否显示分页控件 */
@property (nonatomic, assign) BOOL showPageControl;
/** 分页控件的位置*/
@property (nonatomic, assign) ZTPageControlContentMode pageControlContentMode;
/** 分页控件的样式 */
@property (nonatomic, assign) ZTPageControlStyle pageControlStyle;
/** 分页控件相对于左右底的边距，顶部设置无效 */
@property (nonatomic, assign) UIEdgeInsets  pageControlInsets;
/** 当前控制器颜色 */
@property (nonatomic,retain)UIColor * curPageControlColor;
/** 其余控制器颜色  */
@property (nonatomic,retain)UIColor * otherPageControlColor;


/** 占位图*/
@property (nonatomic,strong) UIImage  *placeHolderImage;
/** 是否在只有一张图时隐藏pagecontrol，默认为YES */
@property (nonatomic) BOOL hidesForSinglePage;
/** 自动滚动间隔时间,默认2s */
@property (nonatomic, assign) CGFloat autoScrollTimeInterval;
/** 是否自动滚动,默认Yes */
@property (nonatomic,assign) BOOL autoScroll;

@end


