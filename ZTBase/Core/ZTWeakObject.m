//
//  ZTWeakObject.m
//  ZTCloudMirror
//
//  Created by ZWL on 2018/3/29.
//  Copyright © 2018年 ZWL. All rights reserved.
//

#import "ZTWeakObject.h"

@implementation ZTWeakObject

-(instancetype)initWithWeakObject:(id)obj{
    if (self = [super init]) {
        _weakObject = obj;
    }
    return self;
}

+(instancetype)weakObject:(id)obj{
    return [[ZTWeakObject alloc] initWithWeakObject:obj];
}

- (id)forwardingTargetForSelector:(SEL)selector {
    return _weakObject;
}

- (void)forwardInvocation:(NSInvocation *)invocation {
    void *null = NULL;
    [invocation setReturnValue:&null];
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)selector {
    return [NSObject instanceMethodSignatureForSelector:@selector(init)];
}

- (BOOL)respondsToSelector:(SEL)aSelector {
    return [_weakObject respondsToSelector:aSelector];
}

- (BOOL)isEqual:(id)object {
    return [_weakObject isEqual:object];
}

- (NSUInteger)hash {
    return [_weakObject hash];
}

- (Class)superclass {
    return [_weakObject superclass];
}

- (Class)class {
    return [_weakObject class];
}

- (BOOL)isKindOfClass:(Class)aClass {
    return [_weakObject isKindOfClass:aClass];
}

- (BOOL)isMemberOfClass:(Class)aClass {
    return [_weakObject isMemberOfClass:aClass];
}

- (BOOL)conformsToProtocol:(Protocol *)aProtocol {
    return [_weakObject conformsToProtocol:aProtocol];
}

- (BOOL)isProxy {
    return YES;
}

- (NSString *)description {
    return [_weakObject description];
}

- (NSString *)debugDescription {
    return [_weakObject debugDescription];
}
@end
