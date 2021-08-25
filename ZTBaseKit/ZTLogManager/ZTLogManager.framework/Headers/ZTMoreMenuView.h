//
//  ZTMoreMenuView.h
//  ZTCloudMirror
//
//  Created by Alvin on 2021/7/5.
//  Copyright © 2021 CITCC4. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


typedef void(^ZTMoreMenuCloseBlock)(void);
typedef void(^ZTMoreMenuClickBlock)(NSInteger idx);

@interface ZTMoreMenuView : UIVisualEffectView

@property(nonatomic, strong) NSArray<UIImage *> * icons;

@property(nonatomic, strong) ZTMoreMenuCloseBlock closeBlock;

@property(nonatomic, strong) ZTMoreMenuClickBlock clickBlock;

@end

NS_ASSUME_NONNULL_END
