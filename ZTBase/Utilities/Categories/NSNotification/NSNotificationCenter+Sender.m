//
//  NSNotificationCenter+Sender.m
//  ZTCarOwner
//
//  Created by ZWL on 2018/8/23.
//  Copyright © 2018 ZWL. All rights reserved.
//

#import "NSNotificationCenter+Sender.h"

@implementation NSNotificationCenter (Sender)

-(void)postNotificationName:(NSNotificationName)aName sender:(Class)aSender{
    NSNotification *notification = [NSNotification notificationWithName:aName object:nil sender:aSender];
    [self postNotification:notification];
}

- (void)postNotificationName:(NSNotificationName)aName object:(nullable id)anObject sender:(nullable Class)aSender{
    NSNotification *notification = [NSNotification notificationWithName:aName object:anObject sender:aSender];
    [self postNotification:notification];
}
- (void)postNotificationName:(NSNotificationName)aName object:(nullable id)anObject userInfo:(nullable NSDictionary *)aUserInfo sender:(nullable Class)aSender{
    NSNotification *notification = [NSNotification notificationWithName:aName object:anObject userInfo:aUserInfo sender:aSender];
    [self postNotification:notification];
}

@end
