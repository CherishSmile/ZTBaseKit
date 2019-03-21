//
//  ZTSetting.h
//  Notice
//
//  Created by ZWL on 15/9/7.
//  Copyright (c) 2015年 ZWL. All rights reserved.
//
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
#define SCREEN_HEIGHT     [UIScreen mainScreen].bounds.size.height
#define SCREEN_WIDTH      [UIScreen mainScreen].bounds.size.width
#define SCREEN_NAVWIDTH   ([UIScreen mainScreen].bounds.size.width*[UIScreen mainScreen].scale)
#define SCREEN_NAVHEIGHT  ([UIScreen mainScreen].bounds.size.height*[UIScreen mainScreen].scale)

#define SCREEN_MAX_LENGTH MAX(SCREEN_WIDTH, SCREEN_HEIGHT)
#define SCREEN_MIN_LENGTH MIN(SCREEN_WIDTH, SCREEN_HEIGHT)

#define PixelCoefficient  1/750.0  //以6s机型分辨率为例，1/750≈0.00133
/*********************************************iPhone型号*******************************/
#define iPhone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(320, 480), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone4S ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)

#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

#define iPhone8 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone8Plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)

#define iPhoneXR ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhoneXS ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhoneXSMax ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size) : NO)


/*********************************************颜色设置*******************************/
#define UIColorFromRGB(rgbValue)    [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define UIColorRGBLight(rgbValue,x) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:x]

///背景颜色
#define ZTBackColor          UIColorFromRGB(0xf0f3f5)

#define ZTShadowColor        UIColorFromRGB(0x999999)

#define ZTImageBackColor     UIColorFromRGB(0xe8e8e8)

///分割线颜色
#define ZTSeparatorColor     UIColorFromRGB(0xf0f1f3)

///字体颜色
#define ZTTextPaleGrayColor  UIColorFromRGB(0x333333)
#define ZTTextGrayColor      UIColorFromRGB(0x666666)
#define ZTTextLightGrayColor UIColorFromRGB(0x999999)

/********************************************字体设置******************************/
#define CornerRadius getPtW(10.f)

#define GetFont(x)     [UIFont fontWithName:@"PingFangSC-Regular" size:x]
#define GetBoldFont(x) [UIFont fontWithName:@"PingFangSC-Semibold" size:x]

//#define GetFont(x)     [UIFont systemFontOfSize:x]
//#define GetBoldFont(x) [UIFont boldSystemFontOfSize:x]

#define F0  getPtW(20.f)
#define F1  getPtW(22.f)
#define F2  getPtW(24.f)
#define F3  getPtW(26.f)
#define F4  getPtW(28.f)
#define F5  getPtW(30.f)
#define F6  getPtW(32.f)
#define F7  getPtW(34.f)
#define F8  getPtW(36.f)
#define F9  getPtW(38.f)
#define F10 getPtW(40.f)
/********************************************默认图片******************************/
#define GetImg(imageName) [UIImage imageNamed:imageName]
/********************************************标题*********************************/
#define HUDTIME      2.f
#define NETWORKERRO  @"网络异常，请检查您的网络设置"
#define REQUESTERRO  @"服务器繁忙，请稍后重试"
#define SEVERERRO    @"服务器异常，请联系客服"
#define LASTPAGETEXT @"已经是最后一页了"

/********************************************其他*********************************/

#define WeakObj(o)    autoreleasepool{} __weak typeof(o) o##Weak = o
#define StrongObj(o)  autoreleasepool{} __strong typeof(o) o = o##Weak

#define VERSION  [[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"]
#define APPNAME  [[NSBundle mainBundle] infoDictionary][@"CFBundleDisplayName"]

#define ZTBaseBundle [NSBundle bundleWithPath:[[NSBundle bundleForClass:[ZTPublicMethod class]] pathForResource:@"ZTBase" ofType:@"bundle"]]


#define NFCenter     NSNotificationCenter.defaultCenter
#define NSUser       NSUserDefaults.standardUserDefaults
#define ZTConfig     ZTBaseConfiguration.defaultConfig


#define PADDING       10.0

#define NAVHEIGHT(vc) navHeight(vc)
#define TOOLBARHEIGHT tabBarHeight()

#define CELLHEIGHT    getPtH(100)




