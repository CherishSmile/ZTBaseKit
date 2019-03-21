//
//  ZTInputDelegate.h
//  ZTCloudMirror
//
//  Created by ZWL on 2018/3/6.
//  Copyright © 2018年 ZWL. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ZTInputDelegate <NSObject>

-(void)inputViewDidChange:(UIView *)inputView textString:(NSString *)text;

@end
