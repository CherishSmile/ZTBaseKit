//
//  ZTInputModel.m
//  ZTCloudMirror
//
//  Created by ZWL on 2017/11/23.
//  Copyright © 2017年 中通四局. All rights reserved.
//

#import "ZTInputModel.h"

@implementation ZTInputModel
-(instancetype)initWithTitle:(NSString *)title content:(NSString *)content placeholder:(NSString *)placeholder keyboardType:(UIKeyboardType)type alignment:(NSTextAlignment)textAlignment enable:(BOOL)isEnable{
    if (self = [super init]) {
        self.title = title;
        self.content = content;
        self.placeholder = placeholder;
        self.isEnable = isEnable;
        self.textAlignment = textAlignment;
        self.keyboardType = type;
    }
    return self;
}
@end
