//
//  ZTPublicMethod.m
//  ZTCloudMirror
//
//  Created by ZWL on 2017/9/30.
//  Copyright © 2017年 中通四局. All rights reserved.
//

#import "ZTPublicMethod.h"
#import <AVFoundation/AVFoundation.h>
#import <CoreLocation/CoreLocation.h>
#import <sys/utsname.h>
#import "UIAlertController+Custom.h"
#import "UIAlertAction+Custom.h"
#import "ZTFileManager.h"
#import <SafariServices/SafariServices.h>


UITextField * initTextField(NSString * placeholder,UIFont * font)
{
    UITextField * textfield=[UITextField new];
    textfield.font = font;
    textfield.placeholder = placeholder;
    textfield.leftViewMode = UITextFieldViewModeAlways;
    textfield.clearButtonMode = UITextFieldViewModeWhileEditing;
    return textfield;
}
UITextView * initTextView(UIFont * font){
    UITextView *textView = [UITextView new];
    textView.font = font;
    return textView;
}
UILabel * initLable(NSString *text,UIFont * font)
{
    UILabel * lbl=[UILabel new];
    lbl.backgroundColor=[UIColor clearColor];
    lbl.font = font;
    lbl.text = text;
    return lbl;
}
UIButton * initButton(NSString *title,UIButtonType type,UIFont * font){
    UIButton *button = [UIButton buttonWithType:type];
    [button setTitle:title forState:UIControlStateNormal];
    button.titleLabel.font = font;
    return button;
}
UITableView * initTabView(id instanceObject,UITableViewStyle style)
{
    ZTTableView *  tableView=[[ZTTableView alloc]initWithFrame:CGRectZero style:style];
    tableView.backgroundColor = ZTBackColor;
    tableView.separatorColor = ZTSeparatorColor;
    tableView.delegate = instanceObject;
    tableView.dataSource = instanceObject;
    tableView.estimatedRowHeight = 0;
    tableView.estimatedSectionFooterHeight = 0;
    tableView.estimatedSectionHeaderHeight = 0;
    return tableView;
}
UIImage * createImage(CGRect frame,UIColor * color)
{
    UIGraphicsBeginImageContext(frame.size);
    CGContextRef context= UIGraphicsGetCurrentContext();
    [color set];
    CGContextFillRect(context, frame);
    UIImage * image=UIGraphicsGetImageFromCurrentImageContext();;
    UIGraphicsEndImageContext();
    return image;
}

UIImage * placeholderImage( NSString * _Nonnull  imageName)  {
    
    UIImage * image = GetImg(imageName);
    if (image) {
        return image;
    }else{
        NSString * imagePath = [ZTBaseBundle pathForResource:@"prelook" ofType:@"png"];
        image = [UIImage imageWithContentsOfFile:imagePath];
        return image;
    }
}


/**
 *  navbar高度
 */
CGFloat navHeight(UIViewController *currentVC){
    if (currentVC) {
        return currentVC.navBarHeight;
    }else{
        return getActiVC().navBarHeight;
    }
}
/**
 *  tabbar高度
 */
CGFloat tabBarHeight(void){
    UIViewController *currentVC = getActiVC();
    CGFloat tabHeight = 0;
    if (currentVC.tabBarController) {
        tabHeight += CGRectGetHeight(currentVC.tabBarController.tabBar.bounds);
    }
    return tabHeight;
}
void drawShadow(UIView *view,UIColor *color){
    drawShadowWithDirection(view, color, NO);
}

void drawShadowWithDirection(UIView *view,UIColor *color,BOOL isUp){
//    CGMutablePathRef path = CGPathCreateMutable();
//    CGPathAddRect(path, NULL, view.bounds);
//    view.layer.shadowPath = path;
//    CGPathCloseSubpath(path);
//    CGPathRelease(path);
    view.layer.shadowColor = color.CGColor;
    view.layer.shadowOffset = CGSizeMake(0, isUp?-3:3);
    view.layer.shadowOpacity = 0.8;
    view.layer.masksToBounds = NO;
}

void drawBorder(UIView * view,UIColor * color,float radiuce)
{
    drawBorderWidth( view,color,0.5,radiuce);
}
void drawBorderWidth(UIView * view,UIColor * color,float width,float radiuce)
{
    view.layer.borderColor=color.CGColor;
    view.layer.borderWidth=width;
    view.layer.cornerRadius=radiuce;
    view.layer.masksToBounds=YES;
}
void drawRoundedCorner(UIView *view,UIRectCorner corners,CGSize cornerRadii){
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:view.bounds byRoundingCorners:corners cornerRadii:cornerRadii];
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.frame = view.bounds;
    layer.path = path.CGPath;
    view.layer.mask = layer;
}
void drawLine(UIView *view,UIColor *lineColor,CGPoint startPoint,CGPoint endPoint){
    // 线的路径
    UIBezierPath *linePath = [UIBezierPath bezierPath];
    // 起点
    [linePath moveToPoint:startPoint];
    // 其他点
    [linePath addLineToPoint:endPoint];
    
    CAShapeLayer *lineLayer = [CAShapeLayer layer];
    lineLayer.lineWidth = 1;
    lineLayer.strokeColor = lineColor.CGColor;
    lineLayer.path = linePath.CGPath;
    
    [view.layer addSublayer:lineLayer];
}
void drawLineWithWidth(UIView *view,UIColor *lineColor,CGFloat lineWidth,CGPoint startPoint,CGPoint endPoint){
    // 线的路径
    UIBezierPath *linePath = [UIBezierPath bezierPath];
    // 起点
    [linePath moveToPoint:startPoint];
    // 其他点
    [linePath addLineToPoint:endPoint];
    
    CAShapeLayer *lineLayer = [CAShapeLayer layer];
    lineLayer.lineWidth = lineWidth;
    lineLayer.strokeColor = lineColor.CGColor;
    lineLayer.path = linePath.CGPath;
    
    [view.layer addSublayer:lineLayer];
}
/******************转json字符串*********************/
NSString * changeToJsonDicString(NSDictionary * jsonDict){
    NSError *error;
    if (!jsonDict) {
        return nil;
    }else{
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonDict options:NSJSONWritingPrettyPrinted error:&error];//此处data参数是我上面提到的key为"data"的数组
        NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        return jsonString;
    }
}
NSString * changeToJsonAryString(NSArray * jsonArr){
    NSError *error;
    if (!jsonArr) {
        return nil;
    }else{
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonArr options:NSJSONWritingPrettyPrinted error:&error];//此处data参数是我上面提到的key为"data"的数组
        NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        return jsonString;
    }
}
NSString * changeToJsonString(id jsonObject){
    NSError *error;
    NSString * jsonString = [NSString stringWithFormat:@"%@",jsonObject];
    if([jsonObject isKindOfClass:[NSDictionary class]]||[jsonObject isKindOfClass:[NSArray class]]){
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonObject options:NSJSONWritingPrettyPrinted error:&error];
        NSString *jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        jsonString = jsonStr;
    }
    return jsonString;
}

UIBarButtonItem * setRightItem(UIViewController * mySelf,id imageOrTitle,SEL action)
{
    return  setBarItem(mySelf, imageOrTitle, action, YES);
}
UIBarButtonItem * setBarItem(UIViewController * mySelf,id imageOrTitle,SEL action,BOOL isRight)
{
    UIBarButtonItem * item = nil;
    if ([imageOrTitle isKindOfClass:[NSString class]]) {
        item = [[UIBarButtonItem alloc] initWithTitle:imageOrTitle style:(UIBarButtonItemStylePlain) target:mySelf action:action];
    }
    
    if ([imageOrTitle isKindOfClass:[UIImage class]]) {
        item = [[UIBarButtonItem alloc] initWithImage:imageOrTitle style:(UIBarButtonItemStylePlain) target:mySelf action:action];
    }
    if (mySelf) {
        if (isRight) {
            mySelf.navigationItem.rightBarButtonItem = item;
        }
        else
        {
            mySelf.navigationItem.leftBarButtonItem = item;
        }
    }
    
    return item;
}

UIBarButtonItem * setBarItemWithUrl(UIViewController * mySelf,NSURL *imageUrl,id target,SEL action,ZTNavBarItemPosition positon, NSInteger itemTag)
{
    UIButton * itemBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    itemBtn.bounds = CGRectMake(0, 0, 40, 40);
    [itemBtn sd_setImageWithURL:imageUrl forState:(UIControlStateNormal) placeholderImage:nil completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        
    }];
    [itemBtn addTarget:target action:action forControlEvents:(UIControlEventTouchUpInside)];
    itemBtn.tag = itemTag;
    UIBarButtonItem * item = [[UIBarButtonItem alloc] initWithCustomView:itemBtn];
    if (mySelf) {
        if (positon) {
            NSMutableArray * rightItems = mySelf.navigationItem.rightBarButtonItems.mutableCopy;
            [rightItems addObject:item];
            mySelf.navigationItem.rightBarButtonItems = rightItems?rightItems.copy:@[item];
        }
        else
        {
            NSMutableArray * leftItems = mySelf.navigationItem.leftBarButtonItems.mutableCopy;
            [leftItems addObject:item];
            mySelf.navigationItem.leftBarButtonItems = leftItems?leftItems.copy:@[item];
        }
    }
    return item;
}

BOOL validatePhone(NSString *candidate)
{
    
    if (candidate.length != 11)
    {
        return NO;
    }else{
        return YES;
    }
    /**
     * 手机号码:
     * 13[0-9], 14[5,7], 15[0, 1, 2, 3, 5, 6, 7, 8, 9], 17[6, 7, 8], 18[0-9], 170[0-9]
     * 移动号段: 134,135,136,137,138,139,150,151,152,157,158,159,182,183,184,187,188,147,178,1705
     * 联通号段: 130,131,132,155,156,185,186,145,176,1709
     * 电信号段: 133,153,180,181,189,177,1700
     */
//    NSString *MOBILE = @"^1(3[0-9]|4[57]|5[0-35-9]|8[0-9]|7[0678])\\d{8}$";
//    /**
//     * 中国移动：China Mobile
//     * 134,135,136,137,138,139,150,151,152,157,158,159,182,183,184,187,188,147,178,1705
//     */
//    NSString *CM = @"(^1(3[4-9]|4[7]|5[0-27-9]|7[8]|8[2-478])\\d{8}$)|(^1705\\d{7}$)";
//    /**
//     * 中国联通：China Unicom
//     * 130,131,132,155,156,185,186,145,176,1709
//     */
//    NSString *CU = @"(^1(3[0-2]|4[5]|5[56]|7[6]|8[56])\\d{8}$)|(^1709\\d{7}$)";
//    /**
//     * 中国电信：China Telecom
//     * 133,153,180,181,189,177,1700
//     */
//    NSString *CT = @"(^1(33|53|77|8[019])\\d{8}$)|(^1700\\d{7}$)";
//    /**
//     25     * 大陆地区固话及小灵通
//     26     * 区号：010,020,021,022,023,024,025,027,028,029
//     27     * 号码：七位或八位
//     28     */
//    //  NSString * PHS = @"^(0[0-9]{2})\\d{8}$|^(0[0-9]{3}(\\d{7,8}))$";
//    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
//    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
//    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
//    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
//    if (([regextestmobile evaluateWithObject:candidate] == YES)
//        || ([regextestcm evaluateWithObject:candidate] == YES)
//        || ([regextestct evaluateWithObject:candidate] == YES)
//        || ([regextestcu evaluateWithObject:candidate] == YES))
//    {
//        return YES;
//    }
//    else
//    {
//        return NO;
//    }
}
BOOL validateIdCard(NSString * idCard)
{
    BOOL flag;
    if (idCard.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *idCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [idCardPredicate evaluateWithObject:idCard];
}

BOOL validateCarID(NSString *carID) {
    
    /**
     *  车牌号正则表达式
     *  ---前两位---
     *  ([冀豫云辽黑湘皖鲁苏浙赣鄂桂甘晋蒙陕吉闽贵粤青藏川宁琼渝京津沪新京军空海北沈兰济南广成使领][A-Z])
     *  注：云A-V 前四位：([云][A][-][V])
     *  ---后面几位---
     *  1、普通车辆：
     *  ([A-HJ-NP-Z0-9]{4}[A-HJ-NP-Z0-9挂学警港澳])
     *  2、新能源：
     *  小型车：([DF][A-HJ-NP-Z0-9][0-9]{4})
     *  大型车：([0-9]{5}[DF])
     */
    NSString *carRegex = @"^(([冀豫云辽黑湘皖鲁苏浙赣鄂桂甘晋蒙陕吉闽贵粤青藏川宁琼渝京津沪新京军空海北沈兰济南广成使领][A-Z])|([云][A][-][V]))(([A-HJ-NP-Z0-9]{4}[A-HJ-NP-Z0-9挂学警港澳])|(([DF][A-HJ-NP-Z0-9][0-9]{4})|([0-9]{5}[DF])))$";
    NSPredicate *carTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",carRegex];
    return [carTest evaluateWithObject:carID];
}
BOOL validatePW(NSString *pswStr) {
    NSString * pattern  =   @"^[A-Za-z0-9_]{6,12}$";
    NSPredicate * pred  =   [NSPredicate predicateWithFormat:@"SELF MATCHES %@",pattern];
    return [pred evaluateWithObject:pswStr];
}
BOOL validateAllNumber(NSString *string){
    NSString *condition = @"^[0-9]*$";//是否都是数字
    //    NSString *condition = @"^[A-Za-z]+$";//是否都是字母
    //    NSString *condition = @"^[A-Za-z0-9]+$";//是否都是字母和数字{6,16}
    //    NSString *condition = @"^[A-Za-z0-9]{6,16}$";//是否都是字母和数字且长度在[6,16]
    //    NSString *condition = @"^[\u4e00-\u9fa5]{0,}$";//只能输入汉字
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",condition];
    return [predicate evaluateWithObject:string];
}

BOOL validateAllLetter(NSString *string){
    NSString *condition = @"^[A-Za-z]+$";//是否都是字母
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",condition];
    return [predicate evaluateWithObject:string];
}

BOOL validateNumberOrLetter(NSString *string){
    NSString * pattern  =   @"^[A-Za-z0-9]$";
    NSPredicate * pred  =   [NSPredicate predicateWithFormat:@"SELF MATCHES %@",pattern];
    return [pred evaluateWithObject:string];
}
BOOL validateBankCard(NSString * bankCard)
{
    if (bankCard.length < 16) {
        return NO;
    }
    NSInteger oddsum = 0;     //奇数求和
    NSInteger evensum = 0;    //偶数求和
    NSInteger allsum = 0;
    NSInteger cardNoLength = (NSInteger)[bankCard length];
    // 取了最后一位数
    NSInteger lastNum = [[bankCard substringFromIndex:cardNoLength-1] intValue];
    //测试的是除了最后一位数外的其他数字
    bankCard = [bankCard substringToIndex:cardNoLength - 1];
    for (NSInteger i = cardNoLength -1 ; i>=1;i--) {
        NSString *tmpString = [bankCard substringWithRange:NSMakeRange(i-1, 1)];
        NSInteger tmpVal = [tmpString integerValue];
        if (cardNoLength % 2 ==1 ) {//卡号位数为奇数
            if((i % 2) == 0){//偶数位置
                tmpVal *= 2;
                if(tmpVal>=10)
                    tmpVal -= 9;
                evensum += tmpVal;
            }else{//奇数位置
                oddsum += tmpVal;
            }
        }else{
            if((i % 2) == 1){
                tmpVal *= 2;
                if(tmpVal>=10)
                    tmpVal -= 9;
                evensum += tmpVal;
            }else{
                oddsum += tmpVal;
            }
        }
    }
    
    allsum = oddsum + evensum;
    allsum += lastNum;
    if((allsum % 10) == 0)
        return YES;
    else
        return NO;
}
BOOL validateEmail(NSString * email)
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

BOOL validateQQ(NSString * QQ)
{
    NSString *emailRegex = @"^[1-9]\\d{4,11}$";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:QQ];
}

BOOL validatewechat(NSString * wechat)
{
    NSString *emailRegex = @"^[A-Za-z][A-Z0-9a-z_-]{5,19}$";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:wechat];
}

ZTAlertController * showCustomAlert(NSString * title,NSString *message,NSString *sureTitle,NSString *cancleTitle,ZTGlobalNOParameterBlock sureClick,ZTGlobalNOParameterBlock cancleClick){
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

    [getActiVC() presentViewController:alertVC animated:YES completion:nil];
    
    return alertVC;
}

BOOL showLocationPermissionAlert(void(^CompletionBlock)(BOOL isCancle)){
    if (!isAllowLoction()) {
        showCustomAlert(@"提示", @"您暂无权限开启定位\n请在“iPhone->设置->和路宝”中开启", @"去设置", @"取消", ^{
            openSettingsURL();
            if (CompletionBlock) {
                CompletionBlock(NO);
            }
        },^{
            if (CompletionBlock) {
                CompletionBlock(YES);
            }
        });
    }
    return isAllowLoction();
}

UIAlertController * showActionSheet(NSString * title,NSString *message,NSArray *selectTitles,NSString *cancleTitle,ZTGlobalStringBlock sureClick,ZTGlobalNOParameterBlock cancleClick){
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:(UIAlertControllerStyleActionSheet)];
    
    for (NSString *selectTitle in selectTitles) {
        UIAlertAction *selectAction = [UIAlertAction actionWithTitle:selectTitle style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            if (sureClick) {
                sureClick(action.title);
            }
        }];
        [alertVC addAction:selectAction];
    }
    
    if (cancleTitle&&cancleTitle.length) {
        UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:cancleTitle style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
            if (cancleClick) {
                cancleClick();
            }
        }];
        [alertVC addAction:cancleAction];
    }
    
    [getActiVC() presentViewController:alertVC animated:YES completion:nil];

    return alertVC;
}


NSData * compressImageQuality(UIImage *image ,int maxLength)
{
    //二分法压缩图片质量
    CGFloat compression = 1;
    NSData *data = UIImageJPEGRepresentation(image, compression);
    if (data.length < maxLength) return data;
    CGFloat max = 1;
    CGFloat min = 0;
    for (int i = 0; i < 6; ++i) {
        compression = (max + min) / 2;
        data = UIImageJPEGRepresentation(image, compression);
        if (data.length < maxLength * 0.9) {
            min = compression;
        } else if (data.length > maxLength) {
            max = compression;
        } else {
            break;
        }
    }
    NSLog(@"压缩图片质量：%@,%@",@(data.length),[NSValue valueWithCGSize:[UIImage imageWithData:data].size]);
    return data;
}
NSString * isNil(NSString * string)
{
    if (!string||[string isKindOfClass:[NSNull class]]||[string isEqual:[NSNull null]]) {
        return @"";
    }
    else
    {
        return [NSString stringWithFormat:@"%@",string];
    }
}
id isNilObject(id object){
    if ([object isKindOfClass:[NSNull class]]||[object isEqual:[NSNull null]]) {
        return nil;
    }else{
        return object;
    }
}

NSString * stringFromZeroOrNil(id object){
    NSString * nullString = [NSString stringWithFormat:@"%@",object];
    if ([object isKindOfClass:[NSNull class]]||[object isEqual:[NSNull null]]||nullString.integerValue==0) {
        nullString = @"";
    }else{
        nullString = isNil(nullString);
    }
    return nullString;
}

void showProgressDialog(NSString *showText,UIView *locationView,MBProgressHUDMode hudMode,NSTimeInterval delay,BOOL isUserAction)
{
    if (!locationView) {
        return;
    }
    MBProgressHUD *HUD = [MBProgressHUD HUDForView:locationView];
    if (!HUD) {
        HUD = [MBProgressHUD showHUDAddedTo:locationView animated:true];
        HUD.label.font = GetFont(F5);
        HUD.label.numberOfLines = 0;
        HUD.animationType = MBProgressHUDAnimationFade;
        HUD.bezelView.color = UIColorRGBLight(0x000000, 0.7);
        HUD.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
        HUD.contentColor = [UIColor whiteColor];
        HUD.margin = 12;
        [HUD showAnimated:YES];
    }
    HUD.label.text = isNil(showText);
    HUD.userInteractionEnabled = isUserAction;
    if (hudMode == MBProgressHUDModeCustomView) {
        UIImage * image = [imageNamed(@"hud_success") imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        HUD.customView = [[UIImageView alloc] initWithImage:image];
    }
    else
    {
        HUD.customView=nil;
    }
    HUD.mode=hudMode;
    if (delay>0) {
        [HUD hideAnimated:YES afterDelay:delay];
    }
    
}
void showToast(NSString *showText,UIView *locationView,NSTimeInterval delay,void(^CompleteHandler)(void)){
    if (!locationView) {
        return;
    }
    MBProgressHUD *HUD = [MBProgressHUD HUDForView:locationView];
    if (!HUD) {
        HUD = [MBProgressHUD showHUDAddedTo:locationView animated:true];
        HUD.label.font=GetFont(F5);
        HUD.label.numberOfLines = 0;
        HUD.animationType = MBProgressHUDAnimationZoomOut;
        HUD.bezelView.color = UIColorRGBLight(0x000000, 0.7);
        HUD.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
        HUD.contentColor = [UIColor whiteColor];
        HUD.margin = 12;
        [HUD showAnimated:YES];
    }
    HUD.label.text = isNil(showText);
    HUD.mode = MBProgressHUDModeText;
    [HUD hideAnimated:YES afterDelay:delay];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(fabs(delay) * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (CompleteHandler) {
            CompleteHandler();
        }
    });
}

void showCustomToast(NSString *showText,UIView *locationView,NSTimeInterval delay,void(^CompleteHandler)(void)){
    if (!locationView) {
        return;
    }
    MBProgressHUD *HUD = [MBProgressHUD HUDForView:locationView];
    if (!HUD) {
        HUD = [MBProgressHUD showHUDAddedTo:locationView animated:true];
        HUD.label.font = GetFont(F5);
        HUD.label.numberOfLines = 0;
        HUD.animationType = MBProgressHUDAnimationZoomOut;
        HUD.bezelView.color = UIColorRGBLight(0x000000, 0.7);
        HUD.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
        HUD.contentColor = [UIColor whiteColor];
        HUD.margin = 12;
        [HUD showAnimated:YES];
    }
    HUD.label.text = isNil(showText);
    HUD.mode = MBProgressHUDModeCustomView;
    UIImage * image = [imageNamed(@"hud_success") imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    HUD.customView = [[UIImageView alloc] initWithImage:image];
    [HUD hideAnimated:YES afterDelay:delay];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(fabs(delay) * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (CompleteHandler) {
            CompleteHandler();
        }
    });
}

void dissmissProgressDialog(UIView *locationView)
{
    if (!locationView) {
        return;
    }
    [MBProgressHUD hideHUDForView:locationView animated:YES];
}
UIWindow *getWindonw(void)
{
    return [UIApplication sharedApplication].keyWindow;
}
UIWindow * getKeyBoardWindow(){
    if (@available(iOS 10.0, *)) {
        return [UIApplication sharedApplication].windows.lastObject;
    } else {
        UIWindow *keyboardWindow = [UIApplication sharedApplication].windows.lastObject;
        UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
        if (CGRectEqualToRect(keyboardWindow.frame, keyWindow.frame)) {
            return keyboardWindow;
        }else{
            return keyWindow;
        }
    }
}
UIInterfaceOrientation getStatusBarOrientation(){
    return [UIApplication sharedApplication].statusBarOrientation;
}

BOOL isAVCaptureActive(void)
{
    AVCaptureDevice *aDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    NSError *inputError = nil;
    AVCaptureDeviceInput *aInput = [AVCaptureDeviceInput deviceInputWithDevice:aDevice error:&inputError];
    
    if (!aInput)
    {
        return NO;
    }
    return YES;
}
BOOL isAllowLoction ()
{
    if ([CLLocationManager locationServicesEnabled]&&([CLLocationManager authorizationStatus]==kCLAuthorizationStatusNotDetermined||[CLLocationManager authorizationStatus]==kCLAuthorizationStatusAuthorizedAlways||[CLLocationManager authorizationStatus]==kCLAuthorizationStatusAuthorizedWhenInUse)) {
        return YES;
    }
    else
        if (![CLLocationManager locationServicesEnabled]||([CLLocationManager authorizationStatus]==kCLAuthorizationStatusDenied)) {
            return NO;
        }
    return NO;
    
}
BOOL isAllowNotfication(void){
    return [[UIApplication sharedApplication] isRegisteredForRemoteNotifications];
}


NSString * getTimeStringFromDate(NSDate *timeDate,NSString * timeformat)
{
    //
    NSDateFormatter *formatter =  [[NSDateFormatter alloc] init];
    [formatter setDateFormat:timeformat];
    NSTimeZone * timeZone = [NSTimeZone timeZoneWithName:@"GMT+0800"];
    [formatter setTimeZone:timeZone];
    
    NSString * strTime= [formatter stringFromDate:timeDate];
    return strTime;
}
NSString * getTimeDate(long long time,NSString * timeformat)
{
    //
    NSDate * date=[NSDate dateWithTimeIntervalSince1970:time/1000];
    NSDateFormatter *formatter =  [[NSDateFormatter alloc] init];
    [formatter setDateFormat:timeformat];
    NSTimeZone * timeZone = [NSTimeZone timeZoneWithName:@"GMT+0800"];
    [formatter setTimeZone:timeZone];
    
    NSString * strTime= [formatter stringFromDate:date];
    return strTime;
}
NSString * getCurrentTime(NSString * timeformat){
    NSDate * currentDate=[NSDate date];
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:timeformat];
    NSString * timeString=[dateFormatter stringFromDate:currentDate];
    return timeString;
}
NSTimeInterval  getCurrentTimeInterval(void){
    return [[NSDate date] timeIntervalSince1970]*1000;
}
NSTimeInterval  getTimeInterval(NSString *formatTime,NSString *format){
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:format]; //(@"YYYY-MM-dd hh:mm:ss") ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    NSTimeZone* timeZone = [NSTimeZone localTimeZone];
    [formatter setTimeZone:timeZone];
    NSDate* date = [formatter dateFromString:formatTime]; //------------将字符串按formatter转成nsdate
    return [date timeIntervalSince1970]*1000;
}

void callNumberByWeb(UIView * view,NSString * phoneNumber)
{
    if (phoneNumber.length!=0) {
        if (checkDevice()) {
            UIWebView * webView=[UIWebView new];
            NSURL * url=[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",phoneNumber]];
            [webView loadRequest:[NSURLRequest requestWithURL:url]];
            [view addSubview:webView];
        }
    }
}
void callNumber(NSString * phoneNumber){
    if (phoneNumber.length!=0) {
        if (checkDevice()) {
            NSURL *numberUrl = [NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",phoneNumber]];
            [[UIApplication sharedApplication] openURL:numberUrl];
        }
    }
}
BOOL checkDevice ()
{
    NSString* deviceType = [UIDevice currentDevice].model;
    NSRange range = [deviceType rangeOfString:@"iPhone"];
    return range.location != NSNotFound;
}

CGFloat floatRoundDown(CGFloat number){
    NSDecimalNumberHandler *roundDown = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:(NSRoundDown) scale:5 raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:YES];
    NSDecimalNumber *decimalNumber = [[NSDecimalNumber decimalNumberWithDecimal:@(number).decimalValue] decimalNumberByRoundingAccordingToBehavior:roundDown];
    return decimalNumber.doubleValue;
}
CGFloat floatRoundDownWithScale(CGFloat number,NSInteger scale){
    NSDecimalNumberHandler *roundDown = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:(NSRoundDown) scale:scale raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:YES];
    NSDecimalNumber *decimalNumber = [[NSDecimalNumber decimalNumberWithDecimal:@(number).decimalValue] decimalNumberByRoundingAccordingToBehavior:roundDown];
    return decimalNumber.doubleValue;
}

//像素适配（宽）
CGFloat getPtW(CGFloat width){
    CGFloat pixelW ;
    if (UIInterfaceOrientationIsPortrait(UIApplication.sharedApplication.statusBarOrientation)) {
        pixelW = width * SCREEN_WIDTH * PixelCoefficient;
    }else if(UIInterfaceOrientationIsLandscape(UIApplication.sharedApplication.statusBarOrientation)){
        pixelW = width * SCREEN_HEIGHT * PixelCoefficient;
    }else{
        pixelW = width/2;
    }
    return pixelW;

}
//像素适配（高）
CGFloat getPtH(CGFloat height){
    return getPtW(height);
}

BOOL isBlankString(NSString *string){
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}

UIViewController * getActiVC()
{
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [window subviews].firstObject;
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    
    if ([result isKindOfClass:[UITabBarController class]]) {
        UITabBarController * tab=(UITabBarController *)result;
        UINavigationController * selectNav=tab.selectedViewController;
        result = selectNav.visibleViewController;
    }
    if ([result isKindOfClass:[UINavigationController class]]) {
        UINavigationController *selectNav = (UINavigationController*)result;
        result = selectNav.visibleViewController;
    }
    
    return result;
}

NSString * byteSizeConversion(CGFloat bSize){
    NSString *size ;
    if (bSize < 1024) {
        size = [NSString stringWithFormat:@"%.0f字节",bSize];
    }else if (bSize < 1024*1024){
        size = [NSString stringWithFormat:@"%.2fK",bSize/1024.0];
    }else if (bSize < 1024*1024*1024){
        size = [NSString stringWithFormat:@"%.2fM",bSize/1024.0/1024.0];
    }else{
        size = [NSString stringWithFormat:@"%.2fG",bSize/1024.0/1024.0/1024.0];
    }
    return size;
}
NSArray<UIViewController*> * getViewControllersFromNavSubControllers(UINavigationController *nav,Class vcClass){
    NSString *classString = NSStringFromClass(vcClass);
    NSMutableArray<UIViewController*> *vcs = [NSMutableArray array];
    for (UIViewController *vc in nav.viewControllers) {
        if ([NSStringFromClass(vc.class) isEqualToString:classString]) {
            [vcs addObject:vc];
        }
    }
    return vcs.copy;
}

UIViewController *controllerFromString(NSString *string){
    Class vcClass = NSClassFromString(string);
    UIViewController *vc = [[vcClass alloc] init];
    return vc;
}

//对一个字符串进行base64编码,并且返回
NSString *base64EncodeString(NSString *string)
{
    //1.先转换为二进制数据
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    
    //2.对二进制数据进行base64编码,完成之后返回字符串
    return [data base64EncodedStringWithOptions:0];
}
//对base64编码之后的字符串解码,并且返回
NSString *base64DecodeString(NSString *string)
{
    //注意:该字符串是base64编码后的字符串
    //1.转换为二进制数据(完成了解码的过程)
    NSData *data = [[NSData alloc]initWithBase64EncodedString:string options:0];
    
    //2.把二进制数据在转换为字符串
    return [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
}


NSString *base64FromImage(id image){
    NSString *imageBase64 = @"";
    if ([image isKindOfClass:[UIImage class]]) {
        imageBase64 = [UIImageJPEGRepresentation(image, 1) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    }
    if ([image isKindOfClass:[NSData class]]) {
        imageBase64 = [image base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    }
    return imageBase64;
}

NSString *base64FromVideo(NSData *videoData){
    return [videoData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
}

NSDictionary *dictionaryWithJsonString(NSString *jsonString) {
    
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
    
}

NSURL *urlFromString(NSString *originImageUrl){
    NSString *nowImageUrl = [NSString stringWithFormat:@"%@",originImageUrl];
    nowImageUrl  = [nowImageUrl stringByAddingPercentEncodingWithAllowedCharacters:NSCharacterSet.URLQueryAllowedCharacterSet];
    NSURL *url = [NSURL URLWithString:nowImageUrl];
    return url;
}
NSURL *urlFromStringByWidth(NSString *originImageUrl,NSInteger width){
    NSString *nowImageUrl = [originImageUrl stringByReplacingOccurrencesOfString:@".jpg" withString:[NSString stringWithFormat:@"_%@x10000.jpg",@(width)]];
    nowImageUrl  = [nowImageUrl stringByAddingPercentEncodingWithAllowedCharacters:NSCharacterSet.URLQueryAllowedCharacterSet];
    NSURL *url = [NSURL URLWithString:nowImageUrl];
    return url;
}


UIImage *drawTextOnImage(NSString *text,UIImage *image){
    //设置字体样式
    UIFont *font = [UIFont systemFontOfSize:80];
    NSDictionary *dict =@{NSFontAttributeName:font,NSForegroundColorAttributeName:[UIColor whiteColor]};
    CGSize textSize = [text sizeWithAttributes:dict];
    //绘制上下文
    UIGraphicsBeginImageContext(image.size);
    [image drawInRect:CGRectMake(0,0, image.size.width, image.size.height)];
    NSInteger border = 20;
    CGRect re = {CGPointMake(image.size.width- textSize.width- 2*border, image.size.height- textSize.height- border), textSize};
    //此方法必须写在上下文才生效
    [text drawInRect:re withAttributes:dict];
    UIImage *newImage =UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
void openSettingsURL(void){
    NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        [[UIApplication sharedApplication] openURL:url];
    }
}

void openSafari(NSURL * url){
    if (@available(iOS 9.0, *)) {
        SFSafariViewController *safariVC = [[SFSafariViewController alloc] initWithURL:url];
        [getActiVC() presentViewController:safariVC animated:YES completion:nil];
    }else{
        if ([[UIApplication sharedApplication] canOpenURL:url]) {
            [[UIApplication sharedApplication] openURL:url];
        }
    }
}


void setButtonTextAndImage(UIButton *btn){
    
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

NSString *dateStringFormTimeInterval(NSTimeInterval time){
    NSString *daraString = @"";
    NSInteger currentYear = getCurrentTime(@"yyyy").integerValue;
    NSInteger timeYear = getTimeDate(time, @"yyyy").integerValue;
    NSInteger currentDay = getCurrentTime(@"dd").integerValue;
    NSInteger timeDay = getTimeDate(time, @"dd").integerValue;
    if (currentDay==timeDay) {
        daraString = getTimeDate(time, @"HH:mm");
    }else if ((currentDay-timeDay)==1){
        daraString = getTimeDate(time, @"昨天");
    }else {
        if (currentYear==timeYear) {
            daraString = getTimeDate(time, @"yyyy.MM.dd");
        }else{
            daraString = getTimeDate(time, @"yyyy.MM.dd");
        }
    }
    return daraString;
}


ZTVersionType compareVersion(NSString *originVersion,NSString *currentVersion){
    // 都为空，相等，返回0
    if (!originVersion && !currentVersion) {
        return ZTVersionTypeEqual;
    }
    
    // v1为空，v2不为空，返回-1
    if (!originVersion && currentVersion) {
        return ZTVersionTypeOld;
    }
    
    // v2为空，v1不为空，返回1
    if (originVersion && !currentVersion) {
        return ZTVersionTypeNew;
    }
    
    // 获取版本号字段
    NSArray *v1Array = [originVersion componentsSeparatedByString:@"."];
    NSArray *v2Array = [currentVersion componentsSeparatedByString:@"."];
    // 取字段最少的，进行循环比较
    NSInteger smallCount = (v1Array.count > v2Array.count) ? v2Array.count : v1Array.count;
    
    for (int i = 0; i < smallCount; i++) {
        NSInteger value1 = [[v1Array objectAtIndex:i] integerValue];
        NSInteger value2 = [[v2Array objectAtIndex:i] integerValue];
        if (value1 > value2) {
            // v1版本字段大于v2版本字段，返回1
            return ZTVersionTypeNew;
        } else if (value1 < value2) {
            // v2版本字段大于v1版本字段，返回-1
            return ZTVersionTypeOld;
        }
        // 版本相等，继续循环。
    }
    // 版本可比较字段相等，则字段多的版本高于字段少的版本。
    if (v1Array.count > v2Array.count) {
        return ZTVersionTypeNew;
    } else if (v1Array.count < v2Array.count) {
        return ZTVersionTypeOld;
    } else {
        return ZTVersionTypeEqual;
    }
    return ZTVersionTypeEqual;
}


NSString * encryptString(NSString *orignString,NSRange range){
    if (isNil(orignString).length) {
        NSString *encryStr = @"";
        for (NSInteger i=range.location; i<range.length+range.location; i++) {
            encryStr = [encryStr stringByAppendingString:@"*"];
        }
        return [orignString stringByReplacingCharactersInRange:range withString:encryStr];
    }else{
        return @"";
    }
    
}


NSAttributedString *attributeStringFromJointString(NSString *firstString,UIColor *firstColor ,NSString *secondString,UIColor *secondColor){
    NSMutableAttributedString *firstAttr = [[NSMutableAttributedString alloc] initWithString:firstString attributes:@{NSForegroundColorAttributeName:firstColor}];
    NSMutableAttributedString *secondAttr = [[NSMutableAttributedString alloc] initWithString:secondString attributes:@{NSForegroundColorAttributeName:secondColor}];
    [firstAttr appendAttributedString:secondAttr];
    return firstAttr.copy;
}

NSAttributedString *attributeStringFromString(NSString *originString ,NSString *replaceString, UIColor *replaceColor){
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:originString];
    [attr addAttribute:NSForegroundColorAttributeName value:replaceColor range:[originString rangeOfString:replaceString]];
    return attr;
}

NSAttributedString * attributedStringFromHtml(NSString *htmlString){
    NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[htmlString dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    return attrStr;
}

NSAttributedString * attributedStringFromStringWithLineSpace(NSString *textString,CGFloat lineSpace){
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = lineSpace;
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    NSAttributedString * attrStr = [[NSAttributedString alloc] initWithString:textString attributes:@{NSParagraphStyleAttributeName:paragraphStyle,NSFontAttributeName:GetFont(F5)}];
    return attrStr;
}

NSString * calculateCacheSize(void){
    return [ZTFileManager sizeFormattedOfDirectoryAtPath:[ZTFileManager cachesDir]];
}
BOOL clearCache(void){
    [[SDImageCache sharedImageCache] clearMemory];
    [[SDImageCache sharedImageCache] clearDiskOnCompletion:^{
        
    }];
    return [ZTFileManager clearCachesDirectory];
}

unsigned long hexColorFromString(NSString *string){
    unsigned long hexColor = strtoul([string UTF8String],0,16);
    return hexColor;
}


BOOL isHttpOrHttpsUrl(NSString *url){
    BOOL isUrl = NO;
    NSString *linkUrl = isNil(url).lowercaseString;
    if ([linkUrl hasPrefix:@"http://"]||[linkUrl hasPrefix:@"https://"]) {
        isUrl = YES;
    }
    return isUrl;
}

NSString *RMBStringFromPirce(id price){
    NSString *rmbString = nil;
    if (price) {
        rmbString = [NSString stringWithFormat:@"%@",price];
        if (isNil(rmbString).length) {
            if (!([rmbString containsString:@"¥"]||[rmbString containsString:@"￥"])) {
                rmbString = [NSString stringWithFormat:@"¥%@",rmbString];
            }
        }
    }else{
        rmbString = @"¥0.00";
    }
    return rmbString;
}

NSString *goodsNumberStringFromNumber(id number){
    
    NSString *numberString = nil;
    if (number) {
        numberString = [NSString stringWithFormat:@"%@",number];
        if (isNil(numberString).length) {
            if (!([numberString containsString:@"x"]||[numberString containsString:@"X"]||[numberString containsString:@"×"])) {
                numberString = [NSString stringWithFormat:@"x%@",numberString];
            }
        }
    }else{
        numberString = @"";
    }
    
    return numberString;
}
NSString *CNPhoneNumberStringFromNumber(id number){
    NSString *numberString = nil;
    if (number) {
        numberString = [NSString stringWithFormat:@"%@",number];
        if (isNil(numberString).length) {
            if (![numberString hasPrefix:@"86"]&&![numberString hasPrefix:@"+86"]) {
                numberString = [NSString stringWithFormat:@"86%@",numberString];
            }
        }
    }else{
        numberString = @"";
    }
    return numberString;
}

void invokeFunctionFromString(id instanceObject,NSString *methodName,id object){
    if (!instanceObject||!isNil(methodName).length||isBlankString(methodName)) {
        return;
    }
//    id obj = isNilObject(object);
//    methodName = [methodName hasSuffix:@":"]?(obj?methodName:[methodName stringByReplacingOccurrencesOfString:@":" withString:@""]):(obj?[methodName stringByAppendingString:@":"]:methodName);
    methodName = [methodName hasSuffix:@":"]?methodName:[methodName stringByAppendingString:@":"];

    SEL selector = NSSelectorFromString(methodName);
    if ([instanceObject respondsToSelector:selector]) {
        IMP imp = [instanceObject methodForSelector:selector];
        void (*func)(id,SEL,id) = (void *)imp;
        func(instanceObject,selector,object);
    }
}
id invokeFunctionWithReturnValueFromString(id instanceObject,NSString *methodName,id object){
    if (!instanceObject||!isNil(methodName).length||isBlankString(methodName)) {
        return nil;
    }
//    id obj = isNilObject(object);
//    methodName = [methodName hasSuffix:@":"]?(obj?methodName:[methodName stringByReplacingOccurrencesOfString:@":" withString:@""]):(obj?[methodName stringByAppendingString:@":"]:methodName);
    methodName = [methodName hasSuffix:@":"]?methodName:[methodName stringByAppendingString:@":"];

    SEL selector = NSSelectorFromString(methodName);
    if ([instanceObject respondsToSelector:selector]) {
        IMP imp = [instanceObject methodForSelector:selector];
        id (*func)(id,SEL,id) = (void *)imp;
        return func(instanceObject,selector,object);
    }
    return nil;
}

NSString * uniqueString(void){
    return isNil([NSUUID UUID].UUIDString);
}


CAGradientLayer * creatGradientLayer(CGRect rect,CGFloat cornerRadius){
    CAGradientLayer *gl = creatGradientLayerWithColor(UIColorFromRGB(0x00C0FE), UIColorFromRGB(0x0A90F5), rect, cornerRadius);
    return gl;
}

CAGradientLayer * creatGradientLayerWithColor(UIColor *color1,UIColor *color2,CGRect rect,CGFloat cornerRadius){
    /**
     1、colors  渐变的颜色
     2、locations 颜色变化位置的取值范围
     3、startPoint  颜色渐变的起始位置:取值范围在(0,0)~(1,1)之间
     4、endPoint  颜色渐变的终点位置,取值范围也是在(0,0)~(1,1)之间
     补充下:startPoint & endPoint设置为(0,0)(1.0,0)代表水平方向渐变,(0,0)(0,1.0)代表竖直方向渐变
     */
    CAGradientLayer *gl = [CAGradientLayer layer];
    gl.frame = rect;
    gl.startPoint = CGPointMake(0, 0);
    gl.endPoint = CGPointMake(1, 0);
    gl.colors = @[(__bridge id)color1.CGColor,(__bridge id)color2.CGColor];
    gl.locations = @[@(0.0),@(1.0)];
    gl.cornerRadius = cornerRadius;
    return gl;
}

UIImage * imageNamed(NSString * name){
    UIImage * image = nil;
    if (isNil(name).length) {
        image = [UIImage imageNamed:name];
        if (!image) {
            image = [UIImage imageNamed:name inBundle:ZTBaseBundle compatibleWithTraitCollection:nil];
        }
    }
    return image;
}

@implementation ZTPublicMethod

@end

