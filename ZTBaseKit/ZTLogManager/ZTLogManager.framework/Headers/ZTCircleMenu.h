//
//  ZTCircleMenu.h
//  ZTCloudMirror
//
//  Created by Alvin on 2021/7/1.
//  Copyright © 2021 CITCC4. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger,ZTIconType) {
    ZTIconTypePlus,
    ZTIconTypeCustom,
    ZTIconTypeImage
};

@interface ZTCircleMenu : UIControl
/**
 *  中间按钮大小 ; 默认(50,50)
 */
@property (nonatomic, assign) CGSize centerButtonSize;

/**
 *  类型
 */
@property (nonatomic, assign) ZTIconType centerIconType;

/**
 *  默认为 nil,  KFIconTypeCustomImage 才有效
 */
@property (nonatomic, strong) UIImage * centerIcon;

/**
 *  主色
 */
@property (nonatomic, strong) UIColor * mainColor;

/**
 *  config function
 *
 *  @param icons        icon 数组
 *  @param innerCircleRadius  内径半径
 */
- (void)loadButtonWithIcons:(NSArray<UIImage*>*)icons innerCircleRadius:(CGFloat)innerCircleRadius;

/**
 *
 */
@property (nonatomic, strong) BOOL (^buttonClickBlock) (NSInteger idx);

/**
 *  KFIconTypeUserDraw, 可在这里自定义
 */
@property (nonatomic, strong) void (^drawCenterButtonIconBlock)(CGRect rect , UIControlState state);


@property (nonatomic, assign) BOOL isOpened;


/**
 * 打开菜单后的偏移量
 */
@property (nonatomic, assign) CGSize offsetAfterOpened;

@end

NS_ASSUME_NONNULL_END
