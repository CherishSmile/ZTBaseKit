//
//  LBXScanViewStyle.m
//
//
//  Created by lbxia on 15/11/15.
//  Copyright © 2015年 lbxia. All rights reserved.
//

#import "ZTScanViewStyle.h"


#define ZTScanViewStyleBundle [NSBundle bundleWithPath:[[NSBundle bundleForClass:[ZTScanViewStyle class]] pathForResource:@"ZTBase" ofType:@"bundle"]]


@implementation ZTScanViewStyle
    
- (id)init
    {
        if (self =  [super init])
        {
            _isNeedShowRetangle = YES;
            _whRatio = 1.0;
            _colorRetangleLine = [UIColor whiteColor];
            _centerUpOffset = 44;
            _xScanRetangleOffset = 60;
            _anmiationStyle = ZTScanViewAnimationStyle_NetGrid;
            _photoframeAngleStyle = ZTScanViewPhotoframeAngleStyle_Outer;
            _colorAngle = [UIColor colorWithRed:0. green:167./255. blue:231./255. alpha:1.0];
            _notRecoginitonArea = [UIColor colorWithRed:0. green:.0 blue:.0 alpha:.5];
            _photoframeAngleW = 24;
            _photoframeAngleH = 24;
            _photoframeLineW = 7;
            _scanType = ZTScanTypeAll;
            _animationImage = [self imageWithNamed:@"scan_grid"];
        }
        return self;
    }
    
- (UIImage *)imageWithNamed:(NSString *)name{
    UIImage * image = nil;
    if (name.length) {
        image = [UIImage imageNamed:name];
        if (!image) {
            image = [UIImage imageNamed:name inBundle:ZTScanViewStyleBundle compatibleWithTraitCollection:nil];
        }
    }
    return image;
}
    @end
