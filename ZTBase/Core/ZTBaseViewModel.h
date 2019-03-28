//
//  ZTBaseViewModel.h
//  ZTCloudMirror
//
//  Created by ZWL on 2018/8/30.
//  Copyright © 2018 ZWL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZTBaseViewModel : NSObject

@property(nullable, nonatomic, strong, readonly) UIViewController * viewController;
@property(nullable, nonatomic, strong, readonly) UINavigationController * navigationController;
@property(nullable, nonatomic, strong, readonly) UINavigationItem * navigationItem;
@property(nullable, nonatomic, strong, readonly) UIView * view;

/**
 navbar是否是半透明
 */
@property(nonatomic, assign, readonly) BOOL navBarTranslucent;

/**
 tabbar是否是半透明
 */
@property(nonatomic, assign, readonly) BOOL tabBarTranslucent;


/**
 实例方法初始化viewModel

 @param viewController viewModel所在的viewController
 @return viewModel
 */
-(instancetype)initWithViewController:(nullable UIViewController *)viewController NS_REQUIRES_SUPER;


/**
 类方法初始化viewModel

 @return viewModel
 */
+(instancetype)viewModel;

/**
 类方法初始化viewModel

 @param viewController viewModel所在的viewController
 @return viewModel
 */
+(instancetype)viewModelWithViewController:(nullable UIViewController *)viewController NS_REQUIRES_SUPER;


/**
 设置viewModel所在的viewController

 @param viewController viewModel所在的viewController
 */
-(void)setViewContainingController:(nullable UIViewController *)viewController;


/**
 重写此方法，在viewController的viewDidLoad方法中调用
 */
-(void)viewDidLoad;

@end

NS_ASSUME_NONNULL_END
