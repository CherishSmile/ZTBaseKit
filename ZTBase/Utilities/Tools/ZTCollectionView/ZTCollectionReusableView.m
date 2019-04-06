//
//  ZTCollectionReusableView.m
//  Notice
//
//  Created by ZWL on 15/9/7.
//  Copyright (c) 2015年 ZWL. All rights reserved.
//

#import "ZTCollectionReusableView.h"
#import "ZTCollectionViewLayoutAttributes.h"

@implementation ZTCollectionReusableView

- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes
{
    [super applyLayoutAttributes:layoutAttributes];
    if ([layoutAttributes isKindOfClass:[ZTCollectionViewLayoutAttributes class]]) {
        ZTCollectionViewLayoutAttributes *attr = (ZTCollectionViewLayoutAttributes *)layoutAttributes;
        self.backgroundColor = attr.backgroundColor;
    }
}
@end
