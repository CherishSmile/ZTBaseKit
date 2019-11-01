//
//  ZTWeakObject.h
//  ZTCloudMirror
//
//  Created by ZWL on 2018/3/29.
//  Copyright © 2018年 ZWL. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark - 内置weak对象（可用于分类定义weak属性）

NS_ASSUME_NONNULL_BEGIN
@interface ZTWeakObject : NSObject

@property (nullable, nonatomic, weak, readonly) id weakObject;

- (instancetype)initWithWeakObject:(id)obj;

+ (instancetype)weakObject:(id)obj;

@end
NS_ASSUME_NONNULL_END
