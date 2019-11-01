//
//  ZTCollectionReusableView
//  Notice
//
//  Created by ZWL on 15/9/7.
//  Copyright (c) 2015年 ZWL. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef enum {
    ZTWaterFlowVerticalEqualWidth = 0, /** 竖向瀑布流 item等宽不等高 */
    ZTWaterFlowHorizontalEqualHeight = 1, /** 水平瀑布流 item等高不等宽 不支持头脚视图*/
    ZTWaterFlowVerticalEqualHeight = 2,  /** 竖向瀑布流 item等高不等宽 */
    ZTWaterFlowHorizontalGrid = 3,  /** 特为国务院客户端原创栏目滑块样式定制-水平栅格布局  仅供学习交流*/
    ZTLineWaterFlow = 4 /** 线性布局 待完成，敬请期待 */
} ZTWaterFlowLayoutStyle; //样式

@class ZTWaterFlowLayout;

@protocol ZTWaterFlowLayoutDelegate <NSObject>

/**
 返回item的大小
 注意：根据当前的瀑布流样式需知的事项：
 当样式为ZTWaterFlowVerticalEqualWidth 传入的size.width无效 ，所以可以是任意值，因为内部会根据样式自己计算布局
 ZTWaterFlowHorizontalEqualHeight 传入的size.height无效 ，所以可以是任意值 ，因为内部会根据样式自己计算布局
 ZTWaterFlowHorizontalGrid   传入的size宽高都有效， 此时返回列数、行数的代理方法无效，
 ZTWaterFlowVerticalEqualHeight 传入的size宽高都有效， 此时返回列数、行数的代理方法无效
 */
- (CGSize)waterFlowLayout:(ZTWaterFlowLayout *)waterFlowLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath;

/** 头视图Size */
-(CGSize )waterFlowLayout:(ZTWaterFlowLayout *)waterFlowLayout sizeForHeaderViewInSection:(NSInteger)section;
/** 脚视图Size */
-(CGSize )waterFlowLayout:(ZTWaterFlowLayout *)waterFlowLayout sizeForFooterViewInSection:(NSInteger)section;

@optional //以下都有默认值
/** 列数*/
-(CGFloat)columnCountInWaterFlowLayout:(ZTWaterFlowLayout *)waterFlowLayout;
/** 行数*/
-(CGFloat)rowCountInWaterFlowLayout:(ZTWaterFlowLayout *)waterFlowLayout;

/** 列间距*/
-(CGFloat)columnMarginInWaterFlowLayout:(ZTWaterFlowLayout *)waterFlowLayout;
/** 行间距*/
-(CGFloat)rowMarginInWaterFlowLayout:(ZTWaterFlowLayout *)waterFlowLayout;
/** 边缘之间的间距*/
-(UIEdgeInsets)edgeInsetInWaterFlowLayout:(ZTWaterFlowLayout *)waterFlowLayout;

@end

@interface ZTWaterFlowLayout : UICollectionViewLayout

/** delegate*/
@property (nonatomic, weak) id<ZTWaterFlowLayoutDelegate> delegate;
/** 瀑布流样式*/
@property (nonatomic, assign) ZTWaterFlowLayoutStyle  flowLayoutStyle;

@end
