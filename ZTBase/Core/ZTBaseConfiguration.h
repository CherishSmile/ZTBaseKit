//
//  ZTBaseConfiguration.h
//  ZTBase
//
//  Created by ZWL on 2019/1/17.
//  Copyright © 2019 CITCC4. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZTBaseConfiguration : NSObject

+(instancetype)defaultConfig;
/** 是否开启debug */
@property(nonatomic, assign) BOOL  isOpenDebug;
/** 主题色 */
@property(nonatomic, strong) UIColor * themeColor;
/// UIWebView js调用原生方法，定义的的协议名称
@property(nonatomic, copy) NSString * webScheme;

@end

NS_ASSUME_NONNULL_END
