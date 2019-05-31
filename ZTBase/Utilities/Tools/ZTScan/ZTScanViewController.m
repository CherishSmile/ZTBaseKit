//
//
//  
//
//  Created by lbxia on 15/10/21.
//  Copyright © 2015年 lbxia. All rights reserved.
//

#import "ZTScanViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/Photos.h>


#define APPNAME  [[NSBundle mainBundle] infoDictionary][@"CFBundleDisplayName"]


@interface ZTScanViewController ()
@property(nonatomic, assign) CGRect  scanRect;
@property(nonatomic, strong) UIButton * flashBtn;
@end

@implementation ZTScanViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColor.blackColor;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self drawScanView];
    [self requestCameraPemissionWithResult:^(BOOL granted) {
        if (granted) {
            [self performSelector:@selector(startScan) withObject:nil afterDelay:0.05];
        }else{
            [self showAlert:@"提示" message:[NSString stringWithFormat:@"您暂无权限打开相机\n请在“iPhone->设置->%@”中开启",APPNAME] sureTitle:@"去设置" sureBlock:^{
                NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                if ([[UIApplication sharedApplication] canOpenURL:url]) {
                    [[UIApplication sharedApplication] openURL:url];
                }
            } cancleTitle:@"取消" cancleBlock:^{
                if (self.presentingViewController) {
                    [self dismissViewControllerAnimated:YES completion:nil];
                }else{
                    [self.navigationController popViewControllerAnimated:YES];
                }
            }];
        }
    }];
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    [self.qRScanView bringSubviewToFront:self.flashBtn];
}

-(void)showAlert:(NSString *)title message:(NSString *)message sureTitle:(NSString *)sureTitle sureBlock:(void(^)(void))sureBlock cancleTitle:(NSString *)cancleTitle cancleBlock:(void(^)(void))cancleBlock{
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:(UIAlertControllerStyleAlert)];
    
    if (cancleTitle&&cancleTitle.length) {
        UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:cancleTitle style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
            if (cancleBlock) {
                cancleBlock();
            }
        }];
        [alertVC addAction:cancleAction];
    }
    if (sureTitle&&sureTitle.length) {
        UIAlertAction *sureAction = [UIAlertAction actionWithTitle:sureTitle style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            if (sureBlock) {
                sureBlock();
            }
        }];
        [alertVC addAction:sureAction];
    }
    [self presentViewController:alertVC animated:YES completion:nil];
}

//绘制扫描区域
- (void)drawScanView
{
    if (!_qRScanView)
    {
        self.qRScanView = [[ZTScanView alloc]initWithFrame:self.view.bounds style:_style];
        
        self.qRScanView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        
        [self.view addSubview:self.qRScanView];
        
    }
}

-(void)flashClick{
    self.flashBtn.selected = !self.flashBtn.selected;
    [self openOrCloseFlash];
}

- (void)reStartDevice
{
    [_scanObj startScan];
    self.flashBtn.selected = NO;
}

//启动设备
- (void)startScan
{
    UIView *videoView = [[UIView alloc]initWithFrame:self.view.bounds];
    videoView.backgroundColor = [UIColor clearColor];
    videoView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    [self.view insertSubview:videoView atIndex:0];
    __weak __typeof(self) weakSelf = self;
    
    if (!_scanObj )
    {
        CGRect cropRect = CGRectZero;
        
        if (_isOpenInterestRect) {
            
            //设置只识别框内区域
            cropRect = [ZTScanView getScanRectWithPreView:self.view style:_style];
        }
        
        //AVMetadataObjectTypeITF14Code 扫码效果不行,另外只能输入一个码制，虽然接口是可以输入多个码制
        NSArray * scanTypes = nil;
        switch (self.style.scanType) {
            case ZTScanTypeAll:
            {
                scanTypes = @[AVMetadataObjectTypeEAN13Code,
                              AVMetadataObjectTypeEAN8Code,
                              AVMetadataObjectTypeUPCECode,
                              AVMetadataObjectTypeCode39Code,
                              AVMetadataObjectTypeCode39Mod43Code,
                              AVMetadataObjectTypeCode93Code,
                              AVMetadataObjectTypeCode128Code,
                              AVMetadataObjectTypePDF417Code,
                              AVMetadataObjectTypeQRCode
                              ];
            }
                break;
            case ZTScanTypeQR:
            {
                scanTypes = @[AVMetadataObjectTypeQRCode];
            }
                break;
            case ZTScanTypeBarCode:
            {
                scanTypes = @[AVMetadataObjectTypeEAN13Code,
                              AVMetadataObjectTypeEAN8Code,
                              AVMetadataObjectTypeUPCECode,
                              AVMetadataObjectTypeCode39Code,
                              AVMetadataObjectTypeCode39Mod43Code,
                              AVMetadataObjectTypeCode93Code,
                              AVMetadataObjectTypeCode128Code,
                              AVMetadataObjectTypePDF417Code
                              ];
            }
                break;
            default:
            {
                scanTypes = @[AVMetadataObjectTypeEAN13Code,
                              AVMetadataObjectTypeEAN8Code,
                              AVMetadataObjectTypeUPCECode,
                              AVMetadataObjectTypeCode39Code,
                              AVMetadataObjectTypeCode39Mod43Code,
                              AVMetadataObjectTypeCode93Code,
                              AVMetadataObjectTypeCode128Code,
                              AVMetadataObjectTypePDF417Code,
                              AVMetadataObjectTypeQRCode
                              ];
            }
                break;
        }
        self.scanObj = [[ZTScanNative alloc] initWithPreView:videoView ObjectType:scanTypes cropRect:cropRect success:^(NSArray<ZTScanResult *> *array) {
            
            [weakSelf scanResultWithArray:array];
        }];
        [_scanObj setNeedCaptureImage:_isNeedScanImage];
        [_scanObj setNeedAutoVideoZoom:_isAutoVideoZoom];

        __weak typeof(self) weakSelf = self;
        self.scanObj.scanCameraBrightnessHandler = ^(CGFloat brightnessValue, CGFloat brightnessThresholdValue) {
            __strong typeof(self) strongSelf = weakSelf;
            if (brightnessValue<brightnessThresholdValue) {
                strongSelf.flashBtn.hidden = NO;
            }else{
                if (!strongSelf.flashBtn.isSelected) {
                    strongSelf.flashBtn.hidden = YES;
                }
            }
        };
    }
    [_scanObj startScan];
    
    [_qRScanView startScanAnimation];
    
    self.view.backgroundColor = UIColor.clearColor;
    self.scanRect = self.qRScanView.scanRetangleRect;
    self.flashBtn.frame = CGRectMake(CGRectGetMidX(self.scanRect)-25, CGRectGetMaxY(self.scanRect)-60, 50, 50);
    [self setButtonAttr:_flashBtn];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
 
    [self stopScan];
    [_qRScanView stopScanAnimation];
    self.flashBtn.selected = NO;
    [self.scanObj setTorch:NO];
}

- (void)stopScan
{
    [_scanObj stopScan];
}

#pragma mark -扫码结果处理

- (void)scanResultWithArray:(NSArray<ZTScanResult*>*)array
{
    //设置了委托的处理
    if (_delegate) {
        [_delegate scanResultWithArray:array];
    }
    
    //也可以通过继承LBXScanViewController，重写本方法即可
}



//开关闪光灯
- (void)openOrCloseFlash
{
    [_scanObj changeTorch];
}


#pragma mark --打开相册并识别图片

/*!
 *  打开本地照片，选择图片识别
 */
- (void)openLocalPhoto:(BOOL)allowsEditing
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    picker.delegate = self;
   
    //部分机型有问题
    picker.allowsEditing = allowsEditing;
    
    
    [self presentViewController:picker animated:YES completion:nil];
}



//当选择一张图片后进入这里

-(void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];    
    
    __block UIImage* image = [info objectForKey:UIImagePickerControllerEditedImage];
    
    if (!image){
        image = [info objectForKey:UIImagePickerControllerOriginalImage];
    }
    
    __weak __typeof(self) weakSelf = self;
    if ([[[UIDevice currentDevice]systemVersion]floatValue] >= 8.0)
    {
        [ZTScanNative recognizeImage:image success:^(NSArray<ZTScanResult *> *array) {
            [weakSelf scanResultWithArray:array];
        }];
    }
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    NSLog(@"cancel");
    [picker dismissViewControllerAnimated:YES completion:nil];
}


- (void)requestCameraPemissionWithResult:(void(^)( BOOL granted))completion
{
    if ([AVCaptureDevice respondsToSelector:@selector(authorizationStatusForMediaType:)])
    {
        AVAuthorizationStatus permission =
        [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        
        switch (permission) {
            case AVAuthorizationStatusAuthorized:
                completion(YES);
                break;
            case AVAuthorizationStatusDenied:
            case AVAuthorizationStatusRestricted:
                completion(NO);
                break;
            case AVAuthorizationStatusNotDetermined:
            {
                [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo
                                         completionHandler:^(BOOL granted) {
                                             
                                             dispatch_async(dispatch_get_main_queue(), ^{
                                                 if (granted) {
                                                     completion(true);
                                                 } else {
                                                     completion(false);
                                                 }
                                             });
                                             
                                         }];
            }
                break;
                
        }
    }
}

-(void)setButtonAttr:(UIButton*)btn{
    
    CGSize imageSize = btn.imageView.bounds.size;
    CGSize titleSize = btn.titleLabel.bounds.size;
    CGSize textSize = [btn.titleLabel.text sizeWithAttributes:@{NSFontAttributeName:btn.titleLabel.font}];
    CGSize frameSize = CGSizeMake(ceilf(textSize.width), ceilf(textSize.height));
    if (titleSize.width + 0.5 < frameSize.width) {
        titleSize.width = frameSize.width;
    }
    CGFloat totalHeight = (imageSize.height + titleSize.height + 5);
    btn.imageEdgeInsets = UIEdgeInsetsMake(- (totalHeight - imageSize.height), 0.0, 0.0, - titleSize.width);
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, - imageSize.width, - (totalHeight - titleSize.height), 0);
    
}

#pragma mark - getter
-(UIButton *)flashBtn{
    if (!_flashBtn) {
        _flashBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_flashBtn setTitle:@"轻点照亮" forState:(UIControlStateNormal)];
        _flashBtn.titleLabel.font = [UIFont systemFontOfSize:11];
        _flashBtn.hidden = YES;
        _flashBtn.selected = NO;
        [_flashBtn setTitle:@"轻点关闭" forState:(UIControlStateSelected)];
        [_flashBtn setImage:[UIImage imageNamed:@"scan_shoudiantong"] forState:(UIControlStateNormal)];
        [_flashBtn addTarget:self action:@selector(flashClick) forControlEvents:(UIControlEventTouchUpInside)];
        [self.qRScanView addSubview:_flashBtn];
    }
    return _flashBtn;
}

-(BOOL)isOpenFlash{
    return self.flashBtn.selected;
}

@end
