//
//  ZTBadgeView.h
//  ZTBadgeView
//
//  Created by Alvin on 2021/7/28.
//  Copyright © 2021 CITCC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

//! Project version number for ZTBadgeView.
FOUNDATION_EXPORT double ZTBadgeViewVersionNumber;

//! Project version string for ZTBadgeView.
FOUNDATION_EXPORT const unsigned char ZTBadgeViewVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <ZTBadgeView/PublicHeader.h>


typedef NS_ENUM(NSUInteger, ZTBadgeViewAlignment)
{
    ZTBadgeViewAlignmentTopLeft = 1,
    ZTBadgeViewAlignmentTopRight,
    ZTBadgeViewAlignmentTopCenter,
    ZTBadgeViewAlignmentCenterLeft,
    ZTBadgeViewAlignmentCenterRight,
    ZTBadgeViewAlignmentBottomLeft,
    ZTBadgeViewAlignmentBottomRight,
    ZTBadgeViewAlignmentBottomCenter,
    ZTBadgeViewAlignmentCenter
};

@interface ZTBadgeView : UIView

@property (nonatomic, copy) NSString *badgeText;

#pragma mark - Customization

@property (nonatomic, assign) ZTBadgeViewAlignment badgeAlignment UI_APPEARANCE_SELECTOR;

/**
 角标文字的颜色
 */
@property (nonatomic, strong) UIColor *badgeTextColor UI_APPEARANCE_SELECTOR;

/**
 角标文字阴影的偏移量
 */
@property (nonatomic, assign) CGSize badgeTextShadowOffset UI_APPEARANCE_SELECTOR;

/**
 角标文字阴影颜色
 */
@property (nonatomic, strong) UIColor *badgeTextShadowColor UI_APPEARANCE_SELECTOR;

/**
 角标字体大小
 */
@property (nonatomic, strong) UIFont *badgeTextFont UI_APPEARANCE_SELECTOR;

/**
 角标背景颜色
 */
@property (nonatomic, strong) UIColor *badgeBackgroundColor UI_APPEARANCE_SELECTOR;

/**
 * Color of the overlay circle at the top. Default is semi-transparent white.
 
 */
@property (nonatomic, strong) UIColor *badgeOverlayColor UI_APPEARANCE_SELECTOR;

/**
 * Color of the badge shadow. Default is semi-transparent black.
 */
@property (nonatomic, strong) UIColor *badgeShadowColor UI_APPEARANCE_SELECTOR;

/**
 * Offset of the badge shadow. Default is 3.0 points down.
 */
@property (nonatomic, assign) CGSize badgeShadowSize UI_APPEARANCE_SELECTOR;

/**
 * Width of the circle around the badge. Default is 2.0 points.
 */
@property (nonatomic, assign) CGFloat badgeStrokeWidth UI_APPEARANCE_SELECTOR;

/**
 * Color of the circle around the badge. Default is white.
 */
@property (nonatomic, strong) UIColor *badgeStrokeColor UI_APPEARANCE_SELECTOR;

/**
 * Allows to shift the badge by x and y points.
 */
@property (nonatomic, assign) CGPoint badgePositionAdjustment UI_APPEARANCE_SELECTOR;

/**
 * You can use this to position the view if you're drawing it using drawRect instead of `-addSubview:`
 * (optional) If not provided, the superview frame is used.
 */
@property (nonatomic, assign) CGRect frameToPositionInRelationWith UI_APPEARANCE_SELECTOR;

/**
 * The minimum width of a badge circle. We need this to avoid elipse shapes when using small fonts.
 */
@property (nonatomic, assign) CGFloat badgeMinWidth UI_APPEARANCE_SELECTOR;

/**
 * Optionally init using this method to have the badge automatically added to another view.
 */
- (id)initWithParentView:(UIView *)parentView alignment:(ZTBadgeViewAlignment)alignment;

@end


