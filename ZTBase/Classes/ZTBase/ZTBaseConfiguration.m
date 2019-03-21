//
//  ZTBaseConfiguration.m
//  ZTBase
//
//  Created by ZWL on 2019/1/17.
//  Copyright © 2019 CITCC4. All rights reserved.
//

#import "ZTBaseConfiguration.h"

@implementation ZTBaseConfiguration
+ (instancetype)defaultConfig{
    static ZTBaseConfiguration * config = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        config = [[self alloc] init];
    });
    return config;
}

@end
