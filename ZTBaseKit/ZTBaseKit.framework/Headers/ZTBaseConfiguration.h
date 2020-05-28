//
//  ZTBaseConfiguration.h
//  ZTBase
//
//  Created by ZWL on 2019/1/17.
//  Copyright © 2019 CITCC4. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZTBaseConfiguration : NSObject

+(instancetype)defaultConfig;
/** 是否开启debug */
@property(nonatomic, assign) BOOL  isOpenDebug;
/** 主题色 */
@property(nonatomic, strong) UIColor * themeColor;

@end

NS_ASSUME_NONNULL_END
