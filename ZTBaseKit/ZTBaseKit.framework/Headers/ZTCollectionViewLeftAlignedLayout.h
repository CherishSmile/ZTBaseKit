//
//  ZTCollectionViewLeftAlignedLayout.h
//  ZTCloudMirror
//
//  Created by ZWL on 2018/7/10.
//  Copyright © 2018 ZWL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZTCollectionViewLeftAlignedLayout : UICollectionViewFlowLayout

@end

/**
 *  Just a convenience protocol to keep things consistent.
 *  Someone could find it confusing for a delegate object to conform to UICollectionViewDelegateFlowLayout
 *  while using ZTCollectionViewLeftAlignedLayout.
 */
@protocol ZTCollectionViewDelegateLeftAlignedLayout <UICollectionViewDelegateFlowLayout>

@end
