//
//  ZTScanViewController.h
//  ZTScanViewController
//
//  Created by Alvin on 2021/7/28.
//  Copyright © 2021 CITCC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

//! Project version number for ZTScanViewController.
FOUNDATION_EXPORT double ZTScanViewControllerVersionNumber;

//! Project version string for ZTScanViewController.
FOUNDATION_EXPORT const unsigned char ZTScanViewControllerVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <ZTScanViewController/PublicHeader.h>


NS_ASSUME_NONNULL_BEGIN

@interface ZTScanBarInfo : NSObject
@property (nonatomic, strong) UIView * codeView;
@property (nonatomic, copy)   NSString * codeResult;
@end

@class ZTScanViewController;
@protocol ZTScanViewControllerDelegate <NSObject>
@optional
- (void)scanViewController:(ZTScanViewController *)scanViewController disFinishScanWithInfo:(NSString *)info;
- (void)scanViewController:(ZTScanViewController *)scanViewController disScreenCapture:(UIImage *)captureImage;
- (void)scanViewControllerDidCancel:(ZTScanViewController *)scanViewController;
@end

@interface ZTScanViewController : UIViewController

@property (nonatomic, assign) id<ZTScanViewControllerDelegate> delegate;

- (void)takeScreenCapture;

- (void)startRunning;

- (void)stopRunning;

- (void)setButtonUpImageAndDownText:(UIButton *)button;

- (void)closeViewController;

@end

NS_ASSUME_NONNULL_END
