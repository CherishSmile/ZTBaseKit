//
//  ZTPageControl.h
//  
//
//  Created by ZWL on 2018/11/7.
//  Copyright © 2018 CITCC4. All rights reserved.
//

#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, ZTPageControlContentMode){
    
    ZTPageControlContentModeLeft = 0,
    ZTPageControlContentModeCenter,
    ZTPageControlContentModeRight,
};

typedef NS_ENUM(NSInteger, ZTPageControlStyle)
{
    /** 默认按照 controlSize 设置的值,如果controlSize未设置 则按照大小为5的小圆点 */
    ZTPageControlStyelDefault = 0,
    /** 长条样式 */
    ZTPageControlStyelRectangle,
    /** 圆点 + 长条 样式 */
    ZTPageControlStyelDotAndRectangle,
    
};


@class ZTPageControl;
@protocol ZTPageControlDelegate <NSObject>

-(void)pageControl:(ZTPageControl*_Nonnull)pageControl didClickIndex:(NSInteger)clickIndex;

@end


@interface ZTPageControl : UIControl

/**
 位置 默认居中
 */
@property(nonatomic,assign) ZTPageControlContentMode pageControlContentMode;

/**
 滚动条样式 默认按照 controlSize 设置的值,如果controlSize未设置 则为大小为5的小圆点
 */
@property(nonatomic,assign) ZTPageControlStyle pageControlStyle;

@property(nonatomic,assign) NSInteger numberOfPages;          // default is 0
@property(nonatomic,assign) NSInteger currentPage;            // default is 0. value pinned to 0..numberOfPages-1


/**
 距离初始位置 间距  默认10
 */
@property(nonatomic,assign) CGFloat marginSpacing;

/**
 pageIndicator 间距 默认3
 */
@property(nonatomic,assign) CGFloat controlSpacing;

/**
 大小 默认(5,5)。默认样式下生效
 */
@property(nonatomic,assign) CGSize controlSize;


/**
 其他page颜色
 */
@property(nonatomic,strong) UIColor * pageIndicatorTintColor;

/**
 当前page颜色
 */
@property(nonatomic,strong) UIColor * currentPageIndicatorTintColor;

/**
 设置图片
 */
@property(nonatomic,strong) UIImage * currentPageIndicatorImage;

@property(nonatomic,weak) id<ZTPageControlDelegate> delegate;

@end

NS_ASSUME_NONNULL_END


