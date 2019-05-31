//
//  QQStyleQRScanViewController.h
//
//  github:https://github.com/MxABC/LBXScan
//  Created by lbxia on 15/10/21.
//  Copyright © 2015年 lbxia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "ZTScanResult.h"
#import "ZTScanView.h"
#import "ZTScanNative.h" //原生扫码封装


/**
 扫码结果delegate,也可通过继承本控制器，override方法scanResultWithArray即可
 */
@protocol ZTScanViewControllerDelegate <NSObject>
@optional

- (void)scanResultWithArray:(NSArray<ZTScanResult*>*)array;

@end


@interface ZTScanViewController : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate>


#pragma mark ---- 需要初始化参数 ------


//扫码结果委托，另外一种方案是通过继承本控制器，override方法scanResultWithArray即可
@property (nonatomic, weak) id<ZTScanViewControllerDelegate> delegate;


/**
 @brief 是否需要扫码图像
 */
@property (nonatomic, assign) BOOL isNeedScanImage;

@property (nonatomic, assign) BOOL isAutoVideoZoom;


/**
 @brief  启动区域识别功能
 */
@property(nonatomic,assign) BOOL isOpenInterestRect;


/**
 相机启动提示,如 相机启动中...
 */
@property (nonatomic, copy) NSString *cameraInvokeMsg;

/**
 *  界面效果参数
 */
@property (nonatomic, strong) ZTScanViewStyle *style;


/**
 扫码区域
 */
@property(nonatomic, assign, readonly) CGRect  scanRect;


#pragma mark -----  扫码使用的库对象 -------
/**
 @brief  扫码功能封装对象
 */
@property (nonatomic,strong) ZTScanNative * scanObj;


#pragma mark - 扫码界面效果及提示等
/**
 @brief  扫码区域视图,二维码一般都是框
 */

@property (nonatomic,strong) ZTScanView * qRScanView;

/**
 @brief  扫码存储的当前图片
 */
@property(nonatomic,strong) UIImage * scanImage;


/**
 @brief  闪关灯开启状态记录
 */
@property(nonatomic,assign)BOOL isOpenFlash;

//打开相册
- (void)openLocalPhoto:(BOOL)allowsEditing;

//开关闪光灯
- (void)openOrCloseFlash;

//启动扫描
- (void)reStartDevice;

//关闭扫描
- (void)stopScan;


@end
