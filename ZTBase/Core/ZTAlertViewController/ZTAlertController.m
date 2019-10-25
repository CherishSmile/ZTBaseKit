//
//  ZTAlertController.m
//  ZTCarOwner
//
//  Created by ZWL on 2018/7/10.
//  Copyright © 2018 ZWL. All rights reserved.
//

#import "ZTAlertController.h"
#import "ZTActivityAlertView.h"
#import "ZTAlertView.h"
#import "ZTDatePicker.h"
#import "ZTAnimationManager.h"
#import "ZTUpdateAlertView.h"
#import "ZTBaseDefines.h"
#import "ZTBaseFunction.h"
#import <objc/runtime.h>

@interface ZTAlertAction ()

@property(nullable, nonatomic) NSString *title;
@property(nonatomic, copy) ZTAlertActionHandler handler;
@property(nonatomic, copy) ZTAlertActionHandler clikcHandler;
@property(nonatomic, assign) ZTAlertActionStyle style;

@end

@implementation ZTAlertAction

+ (instancetype)actionWithTitle:(NSString *)title style:(ZTAlertActionStyle)style handler:(ZTAlertActionHandler)handler{
    ZTAlertAction *action = [ZTAlertAction buttonWithType:UIButtonTypeCustom];
    
    action.title = title;
    action.handler = handler;
    action.style = style;
    
    [action setTitle:title forState:UIControlStateNormal];
    [action addTarget:action action:@selector(actionHandler) forControlEvents:UIControlEventTouchUpInside];
    
    UIColor * titleColor = [UIColor blueColor];
    switch (style) {
        case ZTAlertActionStyleDefault:
        {
            titleColor = ZTConfig.themeColor?:ZTThemeColor;
        }
            break;
        case ZTAlertActionStyleCancel:
        {
            titleColor = ZTConfig.themeColor?:ZTThemeColor;
        }
            break;
        default:
            break;
    }
    [action setTitleColor:titleColor forState:UIControlStateNormal];
    
    return action;
}


-(void)actionHandler{
    if (self.clikcHandler) {
        self.clikcHandler(self);
    }
}

-(void)setTitleColor:(UIColor *)titleColor{
    _titleColor = titleColor;
    [self setTitleColor:titleColor forState:UIControlStateNormal];
}


@end


@interface ZTAlertController ()
@property(nonatomic, assign) ZTAlertControllerStyle  preferredStyle;

@property(nonatomic, strong) ZTActivityAlertView * activityView;
@property(nonatomic, strong) ZTAlertView * alertView;
@property(nonatomic, strong) ZTDatePicker * datePiker;
@property(nonatomic, strong) ZTUpdateAlertView * updateView;

@property(nonatomic, copy) NSString * alertTitle;
@property(nonatomic, strong) id alertMessage;

@property(nonatomic, strong, readwrite) NSArray<ZTAlertAction *> * actions;
@property(nonatomic, strong, readwrite) NSArray<UITextField *> * textFields;


@end

@implementation ZTAlertController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.05 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.25 animations:^{
            self.view.backgroundColor = UIColorRGBLight(0x000000, 0.5);
        }];
        [self createSubviews];
    });
}


+ (instancetype)alertControllerWithTitle:(NSString *)title message:(NSString *)message preferredStyle:(ZTAlertControllerStyle)preferredStyle{
    ZTAlertController *alertVC = [[ZTAlertController alloc] init];
    alertVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    alertVC.modalPresentationStyle = UIModalPresentationOverFullScreen;
    alertVC.preferredStyle = preferredStyle;
    alertVC.alertTitle = title;
    alertVC.alertMessage = message;
    alertVC.messageAlignment = NSTextAlignmentCenter;
    return alertVC;
}

-(void)addAction:(ZTAlertAction *)action{
    @WeakObj(self);
    if (self.preferredStyle!=ZTAlertControllerStyleActivity) {
        action.clikcHandler = ^(ZTAlertAction * _Nonnull action) {
            @StrongObj(self);
            [self callbackHandle:action];
            if (action.clickAlertNoAction) {
                if (action.handler) {
                    action.handler(action);
                }
            }else{
                [self animationDismissViewController:^{
                    if (action.handler) {
                        action.handler(action);
                    }
                }];
            }
        };
    }
    self.actions = self.actions?[self.actions arrayByAddingObject:action]:@[action];
}

-(void)addTextFieldWithConfigurationHandler:(void (^)(UITextField * _Nonnull))configurationHandler{
    UITextField *textField = UITextField.new;
    textField.layer.cornerRadius = 3;
    textField.layer.borderWidth = 1;
    textField.layer.borderColor = UIColor.lightGrayColor.CGColor;
    textField.textColor = UIColor.blackColor;
    textField.placeholder = @"请输入";
    textField.font = [UIFont boldSystemFontOfSize:14];
    textField.textAlignment = NSTextAlignmentCenter;
    if (configurationHandler) {
        configurationHandler(textField);
    }
    self.textFields = self.textFields?[self.textFields arrayByAddingObject:textField]:@[textField];
}

- (void)createSubviews{
    switch (self.preferredStyle) {
        case ZTAlertControllerStyleActionSheet:
        {
            
        }
            break;
        case ZTAlertControllerStyleAlert:
        {
            [self.view addSubview:self.alertView];
        }
            break;
        case ZTAlertControllerStylePicker:
        {
            
        }
            break;
        case ZTAlertControllerStyleDatePicker:
        {
            [self.view addSubview:self.datePiker];
        }
            break;
        case ZTAlertControllerStyleActivity:
        {
            [self.view addSubview:self.activityView];
        }
            break;
        case ZTAlertControllerStyleUpdate:
        {
            [self.view addSubview:self.updateView];
        }
            break;
        default:
            break;
    }
    [self animationIn:nil];
}

#pragma mark - handle
/**
 动画出现
 
 @param completion 动画出现完成
 */
-(void)animationIn:(ZTAnimationCompletion)completion{
    switch (self.preferredStyle) {
        case ZTAlertControllerStyleActivity:
        {
            [ZTAnimationManager alertView:self.activityView
                         animationInStyle:(ZTAlertViewAnimationStyleFade)
                               completion:completion];
        }
            break;
        case ZTAlertControllerStyleAlert:
        {
            [ZTAnimationManager alertView:self.alertView
                         animationInStyle:(ZTAlertViewAnimationStyleAlertBounce)
                               completion:completion];
        }
            break;
        case ZTAlertControllerStyleUpdate:
        {
            [ZTAnimationManager alertView:self.updateView
                         animationInStyle:(ZTAlertViewAnimationStyleFade)
                               completion:completion];
        }
            break;
        case ZTAlertControllerStyleActionSheet:
        {
            
        }
            break;
        case ZTAlertControllerStylePicker:
        {
            
        }
            break;
        case ZTAlertControllerStyleDatePicker:
        {
            [ZTAnimationManager alertView:self.datePiker
                         animationInStyle:(ZTAlertViewAnimationStyleSlideFromBottom)
                               completion:completion];
        }
            break;
        default:
            break;
    }
}
/**
 动画消失
 
 @param completion 动画消失完成
 */
-(void)animationOut:(ZTAnimationCompletion)completion{
    switch (self.preferredStyle) {
        case ZTAlertControllerStyleActivity:
        {
            [ZTAnimationManager alertView:self.activityView
                        animationOutStyle:(ZTAlertViewAnimationStyleFade)
                               completion:completion];
        }
            break;
        case ZTAlertControllerStyleAlert:
        {
            [ZTAnimationManager alertView:self.alertView
                        animationOutStyle:(ZTAlertViewAnimationStyleAlertBounce)
                               completion:completion];
            
        }
            break;
        case ZTAlertControllerStyleUpdate:
        {
            [ZTAnimationManager alertView:self.updateView
                        animationOutStyle:(ZTAlertViewAnimationStyleFade)
                               completion:completion];
            
        }
            break;
        case ZTAlertControllerStyleActionSheet:
        {
            
        }
            break;
        case ZTAlertControllerStylePicker:
        {
            
        }
            break;
        case ZTAlertControllerStyleDatePicker:
        {
            [ZTAnimationManager alertView:self.datePiker
                        animationOutStyle:(ZTAlertViewAnimationStyleSlideFromBottom)
                               completion:completion];
            
        }
            break;
        default:
            break;
    }
}

/**
 处理回调参数
 */
-(void)callbackHandle:(ZTAlertAction *)action{
    switch (self.preferredStyle) {
        case ZTAlertControllerStyleActionSheet:
        case ZTAlertControllerStyleAlert:
        {
            
        }
            break;
        case ZTAlertControllerStyleDatePicker:
        case ZTAlertControllerStylePicker:
        {
            action.extra = self.datePiker.selectedDate;
        }
            break;
        default:
            break;
    }
}


/**
 动画消失ViewController
 
 @param completion 完成回调
 */
-(void)animationDismissViewController: (void (^ __nullable)(void))completion{
    [UIView animateWithDuration:0.25 animations:^{
        self.view.backgroundColor = UIColorRGBLight(0x000000, 0);
    }];
    [self animationOut:^{
        [self dismissViewControllerAnimated:NO completion:completion];
    }];
}

/**
 动画关闭ViewController
 
 @param style 关闭类型，确定or取消
 */
-(void)animationCloseViewController:(ZTAlertActionStyle)style{
    [self.actions enumerateObjectsUsingBlock:^(ZTAlertAction * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.style==style) {
            [self callbackHandle:obj];
            if (obj.clickAlertNoAction) {
                if (obj.handler) {
                    obj.handler(obj);
                }
            }else{
                [self animationDismissViewController:^{
                    if (obj.handler) {
                        obj.handler(obj);
                    }
                }];
            }
            
            *stop = YES;
        }
    }];
}

#pragma mark - setter
-(void)setMessageAlignment:(NSTextAlignment)messageAlignment{
    _messageAlignment = messageAlignment;
    switch (self.preferredStyle) {
        case ZTAlertControllerStyleActionSheet:
        case ZTAlertControllerStyleAlert:
        {
            _alertView.messageAlignment = messageAlignment;
        }
            break;
        default:
            break;
    }
}

#pragma mark - getter
-(ZTActivityAlertView *)activityView{
    if (!_activityView) {
        _activityView = [[ZTActivityAlertView alloc] init];
        @WeakObj(self);
        _activityView.closeBlock = ^{
            @StrongObj(self);
            [self animationCloseViewController:ZTAlertActionStyleCancel];
        };
        _activityView.sureBlock = ^{
            @StrongObj(self);
            [self animationCloseViewController:ZTAlertActionStyleDefault];
        };
        _activityView.imageObject = self.activityImage;
    }
    return _activityView;
}
-(ZTAlertView *)alertView{
    if (!_alertView) {
        _alertView = [[ZTAlertView alloc] initWithTitle:self.alertTitle message:self.alertMessage actions:self.actions textFields:self.textFields];
        _alertView.messageAlignment = self.messageAlignment;
    }
    return _alertView;
}
-(ZTDatePicker *)datePiker{
    if (!_datePiker) {
        _datePiker = [[ZTDatePicker alloc] initWithActions:self.actions];
        @WeakObj(self);
        _datePiker.closeBlock = ^{
            @StrongObj(self);
            [self animationCloseViewController:ZTAlertActionStyleCancel];
        };
        _datePiker.datePickerMode = self.datePickerModel;
        
    }
    return _datePiker;
}
-(ZTUpdateAlertView *)updateView{
    if (!_updateView) {
        _updateView = [[ZTUpdateAlertView alloc] initWithTitle:self.alertTitle message:self.alertMessage actions:self.actions];
    }
    return _updateView;
}
- (void)dealloc
{
    NSLog(@"%@ dealloc",self.class);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end


@implementation ZTAlertController (AlertView)


-(void)setMessage:(id)message{
    objc_setAssociatedObject(self, @selector(message), message, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    switch (self.preferredStyle) {
        case ZTAlertControllerStyleAlert:
        {
            _alertView.message = message;
        }
            break;
        default:
            break;
    }
}
- (id)message{
    return objc_getAssociatedObject(self, _cmd);
}

-(void)setLinkAttributes:(NSDictionary *)linkAttributes{
    objc_setAssociatedObject(self, @selector(linkAttributes), linkAttributes, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    switch (self.preferredStyle) {
        case ZTAlertControllerStyleAlert:
        {
            _alertView.linkAttributes = linkAttributes;
        }
            break;
        default:
            break;
    }
}
-(NSDictionary *)linkAttributes{
    return objc_getAssociatedObject(self, _cmd);
}


+ (instancetype)alertControllerWithTitle:(nullable NSString *)title attributedMessage:(nullable NSAttributedString *)message preferredStyle:(ZTAlertControllerStyle)preferredStyle{
    ZTAlertController *alertVC = [[ZTAlertController alloc] init];
    alertVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    alertVC.modalPresentationStyle = UIModalPresentationOverFullScreen;
    alertVC.preferredStyle = preferredStyle;
    alertVC.alertTitle = title;
    alertVC.alertMessage = message;
    alertVC.messageAlignment = NSTextAlignmentCenter;
    return alertVC;
}

- (void)addLinkToURL:(NSURL *)url withRange:(NSRange)range tapCompleteHandler:(ZTAlertCompleteHandler)completeHandler{
    [self.alertView addLinkToURL:url withRange:range tapCompleteHandler:completeHandler];
}

- (void)addLinkToPhoneNumber:(NSString *)phoneNumber withRange:(NSRange)range tapCompleteHandler:(ZTAlertCompleteHandler)completeHandler{
    [self addLinkToPhoneNumber:phoneNumber withRange:range tapCompleteHandler:completeHandler];
}

- (void)addLinkToTransitInformation:(NSDictionary *)components withRange:(NSRange)range tapCompleteHandler:(ZTAlertCompleteHandler)completeHandler{
    [self addLinkToTransitInformation:components withRange:range tapCompleteHandler:completeHandler];
}

@end

@implementation ZTAlertController (DatePicker)

-(void)setDatePickerModel:(UIDatePickerMode)datePickerModel{
    objc_setAssociatedObject(self, @selector(datePickerModel), @(datePickerModel), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    switch (self.preferredStyle) {
        case ZTAlertControllerStyleDatePicker:
        {
            _datePiker.datePickerMode = datePickerModel;
        }
            break;
        default:
            break;
    }
}
- (UIDatePickerMode)datePickerModel{
    return [objc_getAssociatedObject(self, _cmd) integerValue];
}

@end

@implementation ZTAlertController (ActivityView)

-(void)setActivityImage:(id)activityImage{
    objc_setAssociatedObject(self, @selector(activityImage), activityImage, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    switch (self.preferredStyle) {
        case ZTAlertControllerStyleActivity:
        {
            _activityView.imageObject = activityImage;
        }
            break;
        default:
            break;
    }
}
- (id)activityImage{
    return objc_getAssociatedObject(self, _cmd);
}

@end



ZTAlertController * showCustomAlertController(NSString * title,NSString * message,NSString * sureTitle,ZTAlertCompleteHandler sureClick,NSString *cancleTitle,ZTAlertCompleteHandler cancleClick){
    ZTAlertController *alertVC = [ZTAlertController alertControllerWithTitle:title message:message preferredStyle:(ZTAlertControllerStyleAlert)];
    
    if (cancleTitle&&cancleTitle.length) {
        ZTAlertAction *cancleAction = [ZTAlertAction actionWithTitle:cancleTitle style:(ZTAlertActionStyleCancel) handler:^(ZTAlertAction * _Nonnull action) {
            if (cancleClick) {
                cancleClick();
            }
        }];
        if (ZTConfig.themeColor) {
            cancleAction.titleColor = ZTConfig.themeColor;
        }
        [alertVC addAction:cancleAction];
    }
    if (sureTitle&&sureTitle.length) {
        ZTAlertAction *sureAction = [ZTAlertAction actionWithTitle:sureTitle style:(ZTAlertActionStyleDefault) handler:^(ZTAlertAction * _Nonnull action) {
            if (sureClick) {
                sureClick();
            }
        }];
        if (ZTConfig.themeColor) {
            sureAction.titleColor = ZTConfig.themeColor;
        }
        [alertVC addAction:sureAction];
    }
    [ZTActivityController() presentViewController:alertVC animated:YES completion:nil];
    return alertVC;
}


