//
//  ZTTextView.h
//  ZTCloudMirror
//
//  Created by ZWL on 2017/12/12.
//  Copyright © 2017年 中通四局. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

//! Project version number for ZTTextView.
FOUNDATION_EXPORT double ZTTextViewVersionNumber;

//! Project version string for ZTTextView.
FOUNDATION_EXPORT const unsigned char ZTTextViewVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <ZTTextView/PublicHeader.h>


@interface ZTTextView : UITextView

/**
 预加载文字
 */
@property(nonatomic, copy)  NSString *placeholder;

/**
 预加载文字颜色
 */
@property(nonatomic, strong) UIColor *placeholderColor;

@end
