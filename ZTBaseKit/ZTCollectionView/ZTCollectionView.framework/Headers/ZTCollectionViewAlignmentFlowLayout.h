//
//  ZTCollectionViewFlowLayout.m
//  Notice
//
//  Created by ZWL on 15/9/7.
//  Copyright (c) 2015年 ZWL. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,ZTCollectionViewCellAlignment){
    ZTCollectionViewCellAlignmentLeft,
    ZTCollectionViewCellAlignmentCenter,
    ZTCollectionViewCellAlignmentRight
};
@interface ZTCollectionViewAlignmentFlowLayout: UICollectionViewFlowLayout
//两个Cell之间的距离
@property (nonatomic,assign)CGFloat betweenOfCellPadding;

//cell对齐方式
@property (nonatomic,assign)ZTCollectionViewCellAlignment cellAlignment;

-(instancetype)initWithAlignment:(ZTCollectionViewCellAlignment)cellAlignment;
//全能初始化方法 其他方式初始化最终都会走到这里
-(instancetype)initWithAlignment:(ZTCollectionViewCellAlignment)cellAlignment betweenOfCellPadding:(CGFloat)cellPadding;

@end
