//
//  UIAlertController+Custom.m
//  ZTCarOwner
//
//  Created by ZWL on 2018/1/18.
//  Copyright © 2018年 ZWL. All rights reserved.
//

#import "UIAlertController+Custom.h"
#import <objc/runtime.h>

static char *titleC = "titleColor";
static char *titleF = "titleFont";
static char *titleA = "titleAligment";

static char *messageC = "messageColor";
static char *messageF = "messageFont";
static char *messageA = "messageAligment";

@interface UIAlertController ()
@property (nonatomic,strong) UILabel *titlelbl;
@property (nonatomic,strong) UILabel *messagelbl;
@end

@implementation UIAlertController (Custom)

-(UILabel *)titlelbl{
    return [self.view valueForKey:@"_titleLabel"];
}

-(UILabel *)messagelbl{
    return [self.view valueForKey:@"_messageLabel"];
}

#pragma mark - 设置title相关属性
-(void)setTitleColor:(UIColor *)titleColor{
    objc_setAssociatedObject(self, titleC, titleColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    self.titlelbl.textColor = titleColor;
}
-(UIColor *)titleColor{
    return objc_getAssociatedObject(self, &titleC);
}

-(void)setTitleFont:(UIFont *)titleFont{
    objc_setAssociatedObject(self, titleF, titleFont, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    self.titlelbl.font = titleFont;
}
-(UIFont *)titleFont{
    return objc_getAssociatedObject(self, &titleF);
}

-(void)setTitleAligment:(NSTextAlignment)titleAligment{
    objc_setAssociatedObject(self, titleA, @(titleAligment), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    self.titlelbl.textAlignment = titleAligment;
}
-(NSTextAlignment)titleAligment{
    NSNumber *alignmentNumber = objc_getAssociatedObject(self, &titleA);
    return alignmentNumber.integerValue;
}

#pragma mark - 设置message相关属性
-(void)setMessageColor:(UIColor *)messageColor{
    objc_setAssociatedObject(self, messageC, messageColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    self.messagelbl.tintColor = messageColor;
}
-(UIColor *)messageColor{
    return objc_getAssociatedObject(self, &messageC);
}

-(void)setMessageFont:(UIFont *)messageFont{
    objc_setAssociatedObject(self, messageF, messageFont, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    self.messagelbl.font = messageFont;
}
-(UIFont *)messageFont{
    return objc_getAssociatedObject(self, &messageF);
}

-(void)setMessageAligment:(NSTextAlignment)messageAligment{
    objc_setAssociatedObject(self, messageA, @(messageAligment), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    self.messagelbl.textAlignment = messageAligment;
}
-(NSTextAlignment)messageAligment{
    NSNumber *alignmentNumber = objc_getAssociatedObject(self, &messageA);
    return alignmentNumber.integerValue;
}

@end
