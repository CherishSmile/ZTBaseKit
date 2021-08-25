//
//  UIView+Attach.h
//  ZTCloudMirror
//
//  Created by ZWL on 2019/11/18.
//  Copyright © 2019 CITCC4. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


typedef NS_ENUM(NSInteger,Anchor) {
    AnchorTop,
    AnchorBottom
};

@interface UIView (Attach)
-(void)attachWithAnchor:(Anchor)anchor toView:(UIView *)view;
@end

NS_ASSUME_NONNULL_END
