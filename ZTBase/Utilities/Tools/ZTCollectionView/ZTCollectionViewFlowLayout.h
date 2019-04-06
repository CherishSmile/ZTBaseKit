//
//  ZTCollectionViewFlowLayout.h
//  Notice
//
//  Created by ZWL on 15/9/7.
//  Copyright (c) 2015年 ZWL. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ZTCollectionViewDelegateFlowLayout <UICollectionViewDelegateFlowLayout>

@optional
- (UIColor *)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout backgroundColorForSection:(NSInteger)section;

@end

@interface ZTCollectionViewFlowLayout : UICollectionViewFlowLayout

@property (nonatomic, strong) NSMutableArray<UICollectionViewLayoutAttributes *> *decorationViewAttrs;

@end
