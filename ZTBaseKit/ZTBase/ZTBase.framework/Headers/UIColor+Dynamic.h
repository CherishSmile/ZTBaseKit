//
//  UIColor+Dynamic.h
//  ZTCloudMirror
//
//  Created by ZWL on 2019/10/16.
//  Copyright © 2019 CITCC4. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


#define UIColorFromRGB(rgbValue)    [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define UIColorRGBLight(rgbValue,x) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:x]


@interface UIColor (Dynamic)

#pragma mark - single color

@property(nonatomic, strong, class, readonly) UIColor * zt_theme1Color;
@property(nonatomic, strong, class, readonly) UIColor * zt_theme2Color;


@property(nonatomic, strong, class, readonly) UIColor * zt_dark1Color;
@property(nonatomic, strong, class, readonly) UIColor * zt_dark2Color;
@property(nonatomic, strong, class, readonly) UIColor * zt_dark3Color;


@property(nonatomic, strong, class, readonly) UIColor * zt_gray1Color;
@property(nonatomic, strong, class, readonly) UIColor * zt_gray2Color;
@property(nonatomic, strong, class, readonly) UIColor * zt_gray3Color;
@property(nonatomic, strong, class, readonly) UIColor * zt_gray4Color;
@property(nonatomic, strong, class, readonly) UIColor * zt_gray5Color;
@property(nonatomic, strong, class, readonly) UIColor * zt_gray6Color;
@property(nonatomic, strong, class, readonly) UIColor * zt_gray7Color;

@property(nonatomic, strong, class, readonly) UIColor * zt_white1Color;
@property(nonatomic, strong, class, readonly) UIColor * zt_white2Color;
@property(nonatomic, strong, class, readonly) UIColor * zt_white3Color;
@property(nonatomic, strong, class, readonly) UIColor * zt_white4Color;

#pragma mark - dynamic color
@property(nonatomic, strong, class, readonly) UIColor * zt_themeColor;
@property(nonatomic, strong, class, readonly) UIColor * zt_deputyThemeColor;
@property(nonatomic, strong, class, readonly) UIColor * zt_separatorColor;

@property(nonatomic, strong, class, readonly) UIColor * zt_backgroudWhiteColor;//light is white

@property(nonatomic, strong, class, readonly) UIColor * zt_backgroudGrayColor;//light is gray
@property(nonatomic, strong, class, readonly) UIColor * zt_scrollBackgroudColor;
@property(nonatomic, strong, class, readonly) UIColor * zt_cellBackgroudColor;
@property(nonatomic, strong, class, readonly) UIColor * zt_tabbarBackgroudColor;
@property(nonatomic, strong, class, readonly) UIColor * zt_navbarBackgroudColor;

@property(nonatomic, strong, class, readonly) UIColor * zt_textColor;
@property(nonatomic, strong, class, readonly) UIColor * zt_textDarkColor;

@property(nonatomic, strong, class, readonly) UIColor * zt_textPaleGrayColor;
@property(nonatomic, strong, class, readonly) UIColor * zt_textGrayColor;
@property(nonatomic, strong, class, readonly) UIColor * zt_textLightGrayColor;


+(UIColor *)dynamicColorWithLight:(UIColor *)lightColor dark:(UIColor *)darkColor;

@end

NS_ASSUME_NONNULL_END
