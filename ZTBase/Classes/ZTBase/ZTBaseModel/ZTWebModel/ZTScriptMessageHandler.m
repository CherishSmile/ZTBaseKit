//
//  ZTScriptMessageHandler.m
//  ZTCarOwner
//
//  Created by ZWL on 2018/3/10.
//  Copyright © 2018年 ZWL. All rights reserved.
//

#import "ZTScriptMessageHandler.h"

@implementation ZTScriptMessageHandler

-(instancetype)initWithDelegate:(id<WKScriptMessageHandler>)delegate
{
    if (self = [super init])
    {
        _delegate = delegate;
    }
    
    return self;
}


+(instancetype)scriptWithDelegate:(id<WKScriptMessageHandler>)delegate
{
    return [[ZTScriptMessageHandler alloc]initWithDelegate:delegate];
}


#pragma mark - <WKScriptMessageHandler>
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
{
    [self.delegate userContentController:userContentController didReceiveScriptMessage:message];
}

@end
