//
//  UINavigationBar+Shadow.m
//  ZTCarOwner
//
//  Created by ZWL on 2018/8/15.
//  Copyright © 2018 ZWL. All rights reserved.
//

#import "UINavigationBar+Shadow.h"

@implementation UINavigationBar (Shadow)


- (void)drawShadow{
    [self drawShadowWithOffset:CGSizeMake(0, 2)
                        radius:3
                         color:UIColor.lightGrayColor
                       opacity:1];
}

- (void)drawShadowWithColor:(UIColor *)color{
    [self drawShadowWithOffset:CGSizeMake(0, 2)
                        radius:3
                         color:color
                       opacity:1];
}

-(void)drawShadowWithOffset:(CGSize)offset radius:(CGFloat)radius color:(UIColor *)color opacity:(CGFloat)opacity{
    
    self.shadowImage = UIImage.new;
    
    // Creating shadow path for better performance
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, self.bounds);
    self.layer.shadowPath = path;
    CGPathCloseSubpath(path);
    CGPathRelease(path);
    
    self.layer.shadowColor = color.CGColor;
    self.layer.shadowOffset = offset;
    self.layer.shadowRadius = radius;
    self.layer.shadowOpacity = opacity;
    
    // Default clipsToBounds is YES, will clip off the shadow, so we disable it.
    self.clipsToBounds = NO;
}

-(void)removeShadow{
    self.shadowImage = nil;
    self.layer.shadowColor = nil;
    self.layer.shadowOffset = CGSizeZero;
    self.layer.shadowRadius = 0;
    self.layer.shadowOpacity = 0;
    self.clipsToBounds = YES;
}

@end
