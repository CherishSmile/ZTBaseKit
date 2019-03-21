//
//  UIAlertAction+Custom.m
//  ZTCarOwner
//
//  Created by ZWL on 2018/1/18.
//  Copyright © 2018年 ZWL. All rights reserved.
//

#import "UIAlertAction+Custom.h"
#import <objc/runtime.h>

static char *titleC = "titleColor";

@implementation UIAlertAction (Custom)


-(void)setTitleColor:(UIColor *)titleColor{
    objc_setAssociatedObject(self, titleC, titleColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self setValue:titleColor forKey:@"titleTextColor"];
}
-(UIColor *)titleColor{
    return objc_getAssociatedObject(self, &titleC);
}


@end
