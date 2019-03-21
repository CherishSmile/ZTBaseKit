//
//  NSNotification+Sender.h
//  ZTCarOwner
//
//  Created by ZWL on 2018/8/23.
//  Copyright © 2018 ZWL. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSNotification (Sender)

@property(readonly, nonatomic, strong) Class sender;

- (instancetype)initWithName:(NSNotificationName)name object:(nullable id)object userInfo:(nullable NSDictionary *)userInfo sender:(nullable Class)sender;

+ (instancetype)notificationWithName:(NSNotificationName)aName object:(nullable id)anObject sender:(nullable Class)aSender;

+ (instancetype)notificationWithName:(NSNotificationName)aName object:(nullable id)anObject userInfo:(nullable NSDictionary *)aUserInfo sender:(nullable Class)aSender;

@end
NS_ASSUME_NONNULL_END

