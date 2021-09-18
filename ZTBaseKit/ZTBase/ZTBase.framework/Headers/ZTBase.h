//
//  ZTBase.h
//  ZTBase
//
//  Created by Alvin on 2021/7/19.
//  Copyright © 2021 CITCC. All rights reserved.
//

#import <Foundation/Foundation.h>

//! Project version number for ZTBase.
FOUNDATION_EXPORT double ZTBaseVersionNumber;

//! Project version string for ZTBase.
FOUNDATION_EXPORT const unsigned char ZTBaseVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <ZTBase/PublicHeader.h>

#import <ZTBase/ZTBaseFunc.h>
#import <ZTBase/UIColor+Dynamic.h>
#import <ZTBase/UIImage+Color.h>
#import <ZTBase/ZTScriptMessageHandler.h>
#import <ZTBase/ZTWeakObject.h>
#import <ZTBase/ZTUserDefaults.h>
#import <ZTBase/UIImage+Orientation.h>
#import <ZTBase/NSNotification+Sender.h>
#import <ZTBase/NSNotificationCenter+Sender.h>
#import <ZTBase/UIAlertAction+Custom.h>
#import <ZTBase/UIAlertController+Custom.h>
#import <ZTBase/NSObject+Swizzling.h>


#ifdef DEBUG
#define NSLog(FORMAT, ...) fprintf(stderr,"%s:%d\n%s\n-----------------------------------------\n",[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define NSLog(...)
#endif


#define SuppressPerformSelectorLeakWarning(Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0)

/*********************************************Frame*********************************/
#define SCREEN_HEIGHT     UIScreen.mainScreen.bounds.size.height
#define SCREEN_WIDTH      UIScreen.mainScreen.bounds.size.width
#define SCREEN_NAVWIDTH   (UIScreen.mainScreen.bounds.size.width*UIScreen.mainScreen.scale)
#define SCREEN_NAVHEIGHT  (UIScreen.mainScreen.bounds.size.height*UIScreen.mainScreen.scale)

#define SCREEN_MAX_LENGTH MAX(SCREEN_WIDTH, SCREEN_HEIGHT)
#define SCREEN_MIN_LENGTH MIN(SCREEN_WIDTH, SCREEN_HEIGHT)

#define PixelCoefficient  1/750.0  //以6s机型分辨率为例，1/750≈0.00133

/*********************************************颜色设置*******************************/

#define ZTThemeColor          UIColor.zt_themeColor
#define ZTDeputyThemeColor   UIColor.zt_deputyThemeColor

///背景颜色
#define ZTBackColor          UIColor.zt_backgroudGrayColor

#define ZTShadowColor        UIColorFromRGB(0x999999)

#define ZTImageBackColor     UIColorFromRGB(0xe8e8e8)

///分割线颜色
#define ZTSeparatorColor     UIColor.zt_separatorColor

///字体颜色
#define ZTTextColor          UIColor.zt_textColor
#define ZTTextDarkColor      UIColor.zt_textDarkColor
#define ZTTextPaleGrayColor  UIColor.zt_textPaleGrayColor
#define ZTTextGrayColor      UIColor.zt_textGrayColor
#define ZTTextLightGrayColor UIColor.zt_textLightGrayColor

/********************************************字体设置******************************/

#define Font(x)     [UIFont systemFontOfSize:x]
#define BFont(x)    [UIFont boldSystemFontOfSize:x]

#define FontN(name,x)     [UIFont fontWithName:name size:x]
#define BFontN(name,x)    [UIFont fontWithName:name size:x]

#define FontPF(x)     [UIFont fontWithName:@"PingFangSC-Regular" size:x]
#define BFontPF(x)    [UIFont fontWithName:@"PingFangSC-Semibold" size:x]


#define IsNil(x)  ZTStringFromNullableString(x)

#define GetPt(px) ZTPtFromPx(px)
#define F(x) GetPt(20+x*2)

#define F0   GetPt(20.f)
#define F1   GetPt(22.f)
#define F2   GetPt(24.f)
#define F3   GetPt(26.f)
#define F4   GetPt(28.f)
#define F5   GetPt(30.f)
#define F6   GetPt(32.f)
#define F7   GetPt(34.f)
#define F8   GetPt(36.f)
#define F9   GetPt(38.f)
#define F10  GetPt(40.f)
/********************************************默认图片******************************/
#define GetImg(imageName) [UIImage imageNamed:imageName]
/********************************************标题*********************************/
static CGFloat    const HUDTIME     = 2.f;
static NSString * const NETWORKERRO = @"网络异常，请检查您的网络设置";
static NSString * const REQUESTERRO = @"请求失败，请稍后重试";

/********************************************其他*********************************/

#define WeakObj(o)    autoreleasepool{} __weak typeof(o) o##Weak = o
#define StrongObj(o)  autoreleasepool{} __strong typeof(o) o = o##Weak

#define VERSION        NSBundle.mainBundle.infoDictionary[@"CFBundleShortVersionString"]
#define APPNAME        NSBundle.mainBundle.infoDictionary[@"CFBundleDisplayName"]
#define MINOSVERSION   NSBundle.mainBundle.infoDictionary[@"MinimumOSVersion"]


#define NFCenter     NSNotificationCenter.defaultCenter
#define NSUser       NSUserDefaults.standardUserDefaults

static CGFloat const PADDING = 10.0;


