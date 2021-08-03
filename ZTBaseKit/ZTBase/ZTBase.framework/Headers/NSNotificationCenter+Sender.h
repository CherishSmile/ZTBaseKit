//
//  NSNotificationCenter+Sender.h
//  ZTCarOwner
//
//  Created by ZWL on 2018/8/23.
//  Copyright © 2018 ZWL. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSNotificationCenter (Sender)

- (void)postNotificationName:(NSNotificationName)aName sender:(nullable Class)aSender;

- (void)postNotificationName:(NSNotificationName)aName object:(nullable id)anObject sender:(nullable Class)aSender;

- (void)postNotificationName:(NSNotificationName)aName object:(nullable id)anObject userInfo:(nullable NSDictionary *)aUserInfo sender:(nullable Class)aSender;

@end
NS_ASSUME_NONNULL_END
