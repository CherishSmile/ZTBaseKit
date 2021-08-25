//
//  ZTLogSearchBar.h
//  ZTCloudMirror
//
//  Created by Alvin on 2021/7/6.
//  Copyright © 2021 CITCC4. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^ZTLogSearchCloseBlock)(void);
typedef void(^ZTLogSearchTextBlock)(NSString * text);

@interface ZTLogSearchBar : UIVisualEffectView

@property(nonatomic, strong, readonly) NSString * keyword;
@property(nonatomic, strong) ZTLogSearchCloseBlock closeBlock;
@property(nonatomic, strong) ZTLogSearchTextBlock textChangeBlock;

@end

NS_ASSUME_NONNULL_END
