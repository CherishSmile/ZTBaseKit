//
//  ZTScriptMessageHandler.h
//  ZTCarOwner
//
//  Created by ZWL on 2018/3/10.
//  Copyright © 2018年 ZWL. All rights reserved.
//

#import <Foundation/Foundation.h>

@import WebKit;

NS_ASSUME_NONNULL_BEGIN

@interface ZTScriptMessageHandler : NSObject<WKScriptMessageHandler>

@property (nullable, nonatomic, weak)id <WKScriptMessageHandler> delegate;

/** 创建方法 */
- (instancetype)initWithDelegate:(id <WKScriptMessageHandler>)delegate;

/** 便利构造器 */
+ (instancetype)scriptWithDelegate:(id <WKScriptMessageHandler>)delegate;;

@end

NS_ASSUME_NONNULL_END

