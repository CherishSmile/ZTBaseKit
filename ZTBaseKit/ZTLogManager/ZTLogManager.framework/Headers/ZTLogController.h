//
//  ZTLogController.h
//  ZTCloudMirror
//
//  Created by ZWL on 2019/11/18.
//  Copyright © 2019 CITCC4. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class ZTLogViewController;
@interface ZTLogController : UIViewController

@property(nonatomic, strong) UIViewController * mainViewController;

@property(nonatomic, strong, readonly) ZTLogViewController * logViewController;

@end

NS_ASSUME_NONNULL_END
