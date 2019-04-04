//
//  UIImageView+WebModeCache.m
//  ZTCarOwner
//
//  Created by ZWL on 2017/12/21.
//  Copyright © 2017年 CITCC4. All rights reserved.
//

#import "UIImageView+WebModeCache.h"
#import "ZTBaseDefines.h"
#import <SDWebImage/SDWebImageDownloader.h>

@implementation UIImageView (WebModeCache)

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.clipsToBounds = YES;
    }
    return self;
}

-(void)setWebImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder{
    
    self.contentMode = UIViewContentModeScaleAspectFit;
    [SDWebImageDownloader.sharedDownloader setValue:@"text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8" forHTTPHeaderField:@"Accept"];
    @WeakObj(self);
    [self sd_setImageWithURL:url placeholderImage:placeholder completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        @StrongObj(self);
        if (!error&&image) {
            self.contentMode = UIViewContentModeScaleAspectFill;
        }
    }];
}

-(void)setWebImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder contentMode:(UIViewContentMode)mode{
    self.contentMode = UIViewContentModeScaleAspectFit;
    @WeakObj(self);
    [SDWebImageDownloader.sharedDownloader setValue:@"text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8" forHTTPHeaderField:@"Accept"];
    [self sd_setImageWithURL:url placeholderImage:placeholder completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        @StrongObj(self);
        if (!error&&image) {
            self.contentMode = mode;
        }
    }];
}

-(void)setWebImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder contentMode:(UIViewContentMode)mode completion:(void(^)(BOOL isRequestSuccess))completion{
    self.contentMode = UIViewContentModeScaleAspectFit;
    [SDWebImageDownloader.sharedDownloader setValue:@"text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8" forHTTPHeaderField:@"Accept"];
    @WeakObj(self);
    [self sd_setImageWithURL:url placeholderImage:placeholder completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        @StrongObj(self);
        if (!error&&image) {
            self.contentMode = mode;
            if (completion) {
                completion(YES);
            }
        }else{
            if (completion) {
                completion(NO);
            }
        }
    }];
}
@end
