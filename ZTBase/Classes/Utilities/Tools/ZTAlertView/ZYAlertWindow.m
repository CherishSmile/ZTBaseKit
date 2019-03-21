//
//  ZYAlertWindow.m
//  ZYAlertView
//
//  Created by ZWL on 16/3/15.
//  Copyright © 2016年 ZWL. All rights reserved.
//

#import "ZYAlertWindow.h"

@implementation ZYAlertWindow
-(instancetype)initWithFrame:(CGRect)frame
{
    self =  [super initWithFrame:frame];
    if (self) {
        self.opaque = NO;
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.7];
    }
    return self;
}
@end
