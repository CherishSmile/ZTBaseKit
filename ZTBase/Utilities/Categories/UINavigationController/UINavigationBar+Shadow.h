//
//  UINavigationBar+Shadow.h
//  ZTCarOwner
//
//  Created by ZWL on 2018/8/15.
//  Copyright © 2018 ZWL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationBar (Shadow)

- (void)drawShadow;


- (void)drawShadowWithColor:(UIColor *)color;


- (void)drawShadowWithOffset:(CGSize)offset
                      radius:(CGFloat)radius
                       color:(UIColor *)color
                     opacity:(CGFloat)opacity;

-(void)removeShadow;

@end
