//
//  NSNotification+Sender.m
//  ZTCarOwner
//
//  Created by ZWL on 2018/8/23.
//  Copyright © 2018 ZWL. All rights reserved.
//

#import "NSNotification+Sender.h"
#import <objc/runtime.h>

@interface NSNotification ()

@property(nonatomic, strong) Class sender;

@end

@implementation NSNotification (Sender)

-(void)setSender:(Class)sender{
    objc_setAssociatedObject(self, @selector(sender), sender, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(Class)sender{
    return objc_getAssociatedObject(self, _cmd);
}

- (instancetype)initWithName:(NSNotificationName)name object:(nullable id)object userInfo:(nullable NSDictionary *)userInfo sender:(nullable Class)sender{
    NSNotification * nf =  [self initWithName:name object:object userInfo:userInfo];
    nf.sender = sender;
    return nf;
}

+ (instancetype)notificationWithName:(NSNotificationName)aName object:(nullable id)anObject sender:(nullable Class)aSender{
    NSNotification * nf = [self notificationWithName:aName object:anObject];
    nf.sender = aSender;
    return nf;
}

+ (instancetype)notificationWithName:(NSNotificationName)aName object:(nullable id)anObject userInfo:(nullable NSDictionary *)aUserInfo sender:(nullable Class)aSender{
    NSNotification * nf = [self notificationWithName:aName object:anObject userInfo:aUserInfo];
    nf.sender = aSender;
    return nf;
}


@end
