//
//  ZTPublicMethod.h
//  ZTCloudMirror
//
//  Created by ZWL on 2017/9/30.
//  Copyright © 2017年 中通四局. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ZTSetting.h"
#import "ZTEnum.h"
#import "ZTBaseConfiguration.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import <SDWebImage/UIButton+WebCache.h>


NS_ASSUME_NONNULL_BEGIN

/** 全局无参Block*/
typedef void(^ZTGlobalNOParameterBlock)(void);
/** 全局带参Block*/
typedef void(^ZTGlobalBlock)(id obj);
/** 全局带参字典Block*/
typedef void(^ZTGlobalDictionaryBlock)(NSDictionary *callDic);
/** 全局带参字符串Block*/
typedef void(^ZTGlobalStringBlock)(NSString * string);


/**
 创建UITextField

 @param placeholder 占位符
 @param font 字体大小
 @return UITextField
 */
UITextField * initTextField(NSString * placeholder,UIFont * font);

/**
 创建UITextView

 @param font 字体大小
 @return UITextView
 */
UITextView * initTextView(UIFont * font);

/**
 创建UILable

 @param text 文字内容
 @param font 字体大小
 @return UILable
 */
UILabel * initLable(NSString *text,UIFont * font);

/**
 创建UIButton

 @param title 标题
 @param type 类型
 @param font 字体大小
 @return UIButton
 */
UIButton * initButton(NSString *title,UIButtonType type,UIFont * font);

/**
 创建图片

 @param frame 图片大小
 @param color 图片颜色
 @return UIImage
 */
UIImage * createImage(CGRect frame,UIColor * color);

/**
 绘制阴影(朝下)

 @param view 需要绘制的view
 @param color 阴影颜色
 */
void drawShadow(UIView *view,UIColor *color);

/**
 绘制阴影
 
 @param view 需要绘制的view
 @param color 阴影颜色
 */
void drawShadowWithDirection(UIView *view,UIColor *color,BOOL isUp);


/**
 绘制圆角（默认宽度）

 @param view 需要绘制的view
 @param color 边线颜色
 @param radiuce 弧度
 */
void drawBorder(UIView * view,UIColor * color,float radiuce);

/**
 绘制圆角
 
 @param view 需要绘制的view
 @param corners 绘制的角
 @param cornerRadii 弧度
 */
void drawRoundedCorner(UIView *view,UIRectCorner corners,CGSize cornerRadii);
/**
 绘制直线
 
 @param view 需要绘制的view
 @param lineColor 线的颜色
 @param startPoint 起点坐标
 @param endPoint 终点坐标
 */
void drawLine(UIView *view,UIColor *lineColor,CGPoint startPoint,CGPoint endPoint);

/**
 绘制直线
 
 @param view 需要绘制的view
 @param lineWidth 线的宽度
 @param lineColor 线的颜色
 @param startPoint 起点坐标
 @param endPoint 终点坐标
 */
void drawLineWithWidth(UIView *view,UIColor *lineColor,CGFloat lineWidth,CGPoint startPoint,CGPoint endPoint);

/**
 绘制圆角（自定义宽度）

 @param view 需要绘制的view
 @param color 绘制线的颜色
 @param width 绘制线的宽度
 @param radiuce 弧度
 */
void drawBorderWidth(UIView * view,UIColor * color,float width,float radiuce);

/**
 设置rightItem

 @param mySelf 所在控制器
 @param imageOrTitle 标题或者图片
 @param action 点击事件
 */
UIBarButtonItem * setRightItem( UIViewController * mySelf,id imageOrTitle,SEL action);

/**
 设置barItem

 @param mySelf 所在控制器
 @param imageOrTitle 标题或者图片
 @param action 点击事件
 @param isRight 是否是右边的导航item
 @return UIBarButtonItem
 */
UIBarButtonItem * setBarItem( UIViewController * mySelf,id imageOrTitle,SEL action,BOOL isRight);


/**
 设置barItem

 @param mySelf 所在控制器
 @param imageUrl 图片url
 @param action 点击事件
 @param positon 位置
 @param itemTag tag值
 */
UIBarButtonItem *  setBarItemWithUrl(UIViewController * mySelf,NSURL *imageUrl,id target,SEL action,ZTNavBarItemPosition positon, NSInteger itemTag);

/**
 电话号码判断

 @param candidate 电话号码
 @return 是否是电话号码
 */
BOOL validatePhone(NSString *candidate);

/**
 身份证号判断

 @param idCard 身份证号
 @return 是否是身份证号
 */
BOOL validateIdCard(NSString * idCard);

/**
 车牌号验证

 @param carID 车牌号
 @return 是否是车牌号
 */
BOOL validateCarID(NSString *carID);

/**
 邮箱判断

 @param email 邮箱
 @return 是否是邮箱
 */
BOOL validateEmail(NSString * email);

/**
 密码判断

 @param pswStr 密码
 @return 是否是规定的密码
 */
BOOL validatePW(NSString *pswStr);

/**
 判断字符串是否全为[(数字)OR(数字|字母)OR(字母)OR(汉字)]

 @param string 需要检验的字符串
 @return 是否全为[(数字)OR(数字|字母)OR(字母)OR(汉字)]
 */
BOOL validateAllNumber(NSString *string);

/**
 判断字符串是否全为[(数字)OR(数字|字母)OR(字母)OR(汉字)]
 
 @param string 需要检验的字符串
 @return 是否全为[(数字)OR(数字|字母)OR(字母)OR(汉字)]
 */
BOOL validateAllLetter(NSString *string);

/**
 判断字符串是否全为[(数字)OR(数字|字母)OR(字母)OR(汉字)]
 
 @param string 需要检验的字符串
 @return 是否全为[(数字)OR(数字|字母)OR(字母)OR(汉字)]
 */
BOOL validateNumberOrLetter(NSString *string);

/**
 判断字符串是否全为数字|字母

 @param string 需要检验的字符串
 @return 是否全为数字|字母
 */
BOOL validateNumberOrLetter(NSString *string);

/**
 银行卡格式校验

 @param bankCard 银行卡号
 @return 是否是银行卡号
 */
BOOL validateBankCard(NSString * bankCard);

/**
 qq号判断

 @param QQ QQ号码
 @return 是否是QQ号码
 */
BOOL validateQQ(NSString *QQ);

/**
 微信判断

 @param wechat 微信号
 @return 是否是微信号
 */
BOOL validatewechat(NSString * wechat);


UIAlertController * showAlertController(NSString * _Nullable title,NSString * _Nullable message,NSString * _Nullable sureTitle,ZTGlobalNOParameterBlock _Nullable sureClick,NSString * _Nullable cancleTitle,ZTGlobalNOParameterBlock _Nullable cancleClick);

/**
 显示定位权限弹出窗

 @param CompletionBlock 点击回调
 @return 是否有定位权限
 */
BOOL showLocationPermissionAlert(void(^ _Nullable CompletionBlock)(BOOL isCancle));

/**
actionSheet

 @param title 标题
 @param message 内容
 @param selectTitles actions的标题
 @param cancleTitle 取消标题
 @param sureClick 确定回调
 @param cancleClick 取消回调
 */
UIAlertController * showActionSheet(NSString * _Nullable title,NSString * _Nullable message,NSArray * _Nullable selectTitles,ZTGlobalStringBlock _Nullable sureClick,NSString * _Nullable cancleTitle,ZTGlobalNOParameterBlock _Nullable cancleClick);

/**
 字典转化为json字符串

 @param jsonDict json字典
 @return json字符串
 */
NSString * changeToJsonDicString(NSDictionary * jsonDict);

/**
 数组转化为json字符串

 @param jsonArr json数组
 @return json字符串
 */
NSString * changeToJsonAryString(NSArray * jsonArr);

/**
 转化为json字符串

 @param jsonObject json对象
 @return json字符串
 */
NSString * changeToJsonString(id jsonObject);

/**
 二分法压缩图片质量（压缩图片质量的优点在于，尽可能保留图片清晰度，图片不会明显模糊；缺点在于，不能保证图片压缩后小于指定大小。）
 
 @param image 原始图片
 @param maxLength 图片最大值
 @return 图片的二进制数据
 */
NSData * compressImageQuality(UIImage *image ,int maxLength);

/**
 空值转化

 @param string 字符串
 @return 转化后的字符串
 */
NSString * isNil(NSString * _Nullable string);

/**
 空值转化

 @param object id类型
 @return 转化后的数据
 */
id isNilObject(id object);

/**
 空值转化
 
 @param object id类型
 @return 转化后的数据
 */
NSString * stringFromZeroOrNil(id object);

/**
 显示toast

 @param showText 显示文本
 @param locationView 父视图
 @param hudMode hud类型
 @param delay 显示时间<0,不会自动消失
 @param isUserAction 是否打开用户交互
 */
void showProgressDialog(NSString * _Nullable showText,UIView * locationView,MBProgressHUDMode hudMode,NSTimeInterval delay,BOOL isUserAction);

/**
 显示toast

 @param showText 显示文本
 @param locationView 父视图
 @param delay 显示时间
 @param CompleteHandler 消失后回调
 */
void showToast(NSString * _Nullable showText,UIView * locationView,NSTimeInterval delay,void(^ _Nullable CompleteHandler)(void));

/**
 显示toast(自定义view)
 
 @param showText 显示文本
 @param locationView 父视图
 @param delay 显示时间
 @param CompleteHandler 消失后回调
 */
void showCustomToast(NSString * _Nullable showText,UIView *locationView,NSTimeInterval delay,void(^ _Nullable CompleteHandler)(void));

/**
 隐藏toast

 @param locationView 父视图
 */
void dissmissProgressDialog(UIView *locationView);

/**
 获取当前Window

 @return 当前window
 */
UIWindow *getWindonw(void);

/**
 获取键盘Window

 @return 键盘window
 */
UIWindow * getKeyBoardWindow(void);

/**
 获取状态栏的方向
 
 @return 方向
 */
UIInterfaceOrientation getStatusBarOrientation(void);
/**
 是否使用相机

 @return YES or NO
 */
BOOL isAVCaptureActive(void);

/**
 是否允许定位
 
 @return YES or NO
 */
BOOL isAllowLoction (void);
/**
 是否允许通知
 
 @return YES or NO
 */

BOOL isAllowNotfication(void);

/**
 获取时间字符串
 
 @param timeDate 时间
 @param timeformat 时间戳格式化
 @return 格式化后的字符串
 */
NSString * getTimeStringFromDate(NSDate *timeDate,NSString * timeformat);

/**
 获取时间字符串

 @param time 时间戳
 @param timeformat 时间戳格式化
 @return 格式化后的字符串
 */
NSString * getTimeDate(long long time,NSString * timeformat);

/**
 获取当前时间字符串

 @param timeformat 时间戳格式化
 @return 格式化后的字符串
 */
NSString * getCurrentTime(NSString * timeformat);

/**
 获取当前时间戳

 @return 当前时间戳
 */
NSTimeInterval  getCurrentTimeInterval(void);

/**
 获取时间戳

 @param formatTime 格式化后的时间
 @param format 格式化方式
 @return 时间戳
 */
NSTimeInterval  getTimeInterval(NSString *formatTime,NSString *format);

/**
 webView打电话

 @param view 父视图
 @param phoneNumber 电话号码
 */
void callNumberByWeb(UIView * view,NSString * phoneNumber);

/**
 原生打电话

 @param phoneNumber 电话号码
 */
void callNumber(NSString * phoneNumber);

/**
 检测当前设备是否是iphone

 @return YES or NO
 */
BOOL checkDevice (void);

/**
 舍去法（保留5位小数）
 
 @param number 需要舍去的数
 @return 舍去后的数
 */
CGFloat floatRoundDown(CGFloat number);

/**
 舍去法
 
 @param number 需要舍去的数
 @return 舍去后的数
 */
CGFloat floatRoundDownWithScale(CGFloat number,NSInteger scale);
/**
 像素适配（宽）

 @param width 像素宽
 @return 实际物理宽度
 */
CGFloat getPtW(CGFloat width);

/**
 像素适配（高）

 @param height 像素高
 @return 实际物理高度
 */
CGFloat getPtH(CGFloat height);

/**
 检测空白

 @param string 字符串
 @return 是否是空白字符串
 */
BOOL isBlankString(NSString * _Nullable string);

/**
 字节转换

 @param bSize 传入的字节大小
 @return 转化后的大小
 */
NSString * byteSizeConversion(CGFloat bSize);

/**
 获取当前活跃的VC
 
 @return 当前vc
 */
UIViewController * getActiVC(void);

/**
 获取导航控制器下的指定controllers

 @param vcClass 需要获取的controller
 @return 获取到的controller
 */
NSArray<UIViewController*> * getViewControllersFromNavSubControllers(UINavigationController *nav,Class vcClass);
/**
 字符串转vc

 @param string vc类对应的字符串
 @return 字符串对应的vc
 */
UIViewController *controllerFromString(NSString *string);

/**
 对一个字符串进行base64编码,并且返回

 @param string 需要编码的字符串
 @return 编码后字符串
 */
NSString *base64EncodeString(NSString *string);

/**
 对一个字符串进行base64解码,并且返回

 @param string 需要解码的字符串
 @return 解码后的字符串
 */
NSString *base64DecodeString(NSString *string);

/**
 把图片转化为base64,并且返回
 
 @param image 需要转化的图片或者图片二进制数据
 @return 转化后的字符串
 */
NSString *base64FromImage(id image);

/**
 把视频转化为base64,并且返回
 
 @param videoData 需要转化的视频二进制数据
 @return 转化后的字符串
 */
NSString *base64FromVideo(NSData *videoData);

/**
 json字符串转化为字典

 @param jsonString 需要转化的json字符串
 @return 转化后的字典
 */
NSDictionary *dictionaryWithJsonString(NSString *jsonString);

/**
 图片URL转化

 @param originImageUrl 原始url
 @return 转化后的url
 */
NSURL *urlFromString(NSString *originImageUrl);

/**
 图片URL转化

 @param originImageUrl 原始url
 @param width 自定义图片宽度
 @return 转化后的url
 */
NSURL *urlFromStringByWidth(NSString *originImageUrl,NSInteger width);

/**
 在图片上添加文字

 @param text 文字
 @param image 图片
 @return 添加文字后的图片
 */
UIImage *drawTextOnImage(NSString *text,UIImage *image);

/**
 *  打开系统设置
 */
void openSettingsURL(void);

/**
 通过safari打开链接
 
 @param url 链接
 */
void openSafari(NSURL * url);

/**
 设置button文字在下，图片在上

 @param btn 传入的button
 */
void setButtonTextAndImage(UIButton *btn);

/**
 日期转换

 @param time 时间戳
 @return 格式化后的时间
 */
NSString *dateStringFormTimeInterval(NSTimeInterval time);


/**
 版本号比较

 @param originVersion 原始版本
 @param currentVersion 当前版本
 @return 版本类型
 */
ZTVersionType compareVersion(NSString *originVersion,NSString *currentVersion);

/**
 加密字符串

 @param orignString 需要打星号的字符串
 @param range 需要打星号的范围
 @return 打星号后的字符串
 */
NSString * encryptString(NSString *orignString,NSRange range);



/**
 string转化为NSAttributedString（拼接两个字符串）


 @param firstString 第一个字符串
 @param firstColor 第一个字符串颜色
 @param secondString 第二个字符串
 @param secondColor 第二个字符串颜色
 @return 转化后的字符串
 */
NSAttributedString *attributeStringFromJointString(NSString *firstString,UIColor *firstColor ,NSString *secondString,UIColor *secondColor);

/**
 string转化为NSAttributedString（替换文本颜色）

 @param originString 完整的字符串
 @param replaceString 需要替换的字符串
 @param replaceColor 需要替换的字符串颜色
 @return 转化后的字符串
 */
NSAttributedString *attributeStringFromString(NSString *originString ,NSString *replaceString, UIColor *replaceColor);

/**
 html转化为属性字符串
 
 @param htmlString html
 @return 属性字符串
 */
NSAttributedString * attributedStringFromHtml(NSString *htmlString);

/**
 string转化为NSAttributedString(调整行间距)

 @param textString 需要改变行间距的字符串
 @param lineSpace 行间距值
 @return 属性字符串
 */
NSAttributedString * attributedStringFromStringWithLineSpace(NSString *textString,CGFloat lineSpace);

/**
 计算缓存的大小

 @return 缓存的大小
 */
NSString * calculateCacheSize(void);

/**
 清理缓存
 */
BOOL clearCache(void);

/**
 字符转换颜色

 @param string 16进制类型的字符串
 @return 16进制类型无符号长整型颜色
 */
unsigned long hexColorFromString(NSString *string);

/**
 判断是否是http或者https链接

 @param url 传入的url
 @return YES or NO
 */
BOOL isHttpOrHttpsUrl(NSString *url);

/**
 转化为人民币字符串

 @param price 价格
 @return 带人民币符号的字符串
 */
NSString *RMBStringFromPirce(id price);

/**
 转化为带符号的数量
 
 @param number 数量
 @return 带符号的数量
 */
NSString *goodsNumberStringFromNumber(id number);

/**
 转化为带86的电话号码
 
 @param number 原始电话号码
 @return 带86的电话号码
 */
NSString *CNPhoneNumberStringFromNumber(id number);
/**
 把字符串转化为方法，并且调用（不带返回值）

 @param instanceObject 需要调用方法的实例
 @param methodName 方法名称
 @param object 参数
 */
void invokeFunctionFromString(id instanceObject,NSString *methodName,id object);

/**
 把字符串转化为方法，并且调用（带返回值）

 @param instanceObject 需要调用方法的实例
 @param methodName 方法名称
 @param object 参数
 @return 返回值
 */
id invokeFunctionWithReturnValueFromString(id instanceObject,NSString *methodName,id object);

/**
 生成唯一字符串

 @return 字符串
 */
NSString * uniqueString(void);

/**
 创建渐变色
 
 @param rect 大小
 @param cornerRadius 圆角
 @return layer
 */
CAGradientLayer * creatGradientLayer(CGRect rect,CGFloat cornerRadius);

CAGradientLayer * creatGradientLayerWithColor(UIColor *color1,UIColor *color2,CGRect rect,CGFloat cornerRadius);

UIImage * imageNamed(NSString * name);

@interface ZTPublicMethod : NSObject

@end

NS_ASSUME_NONNULL_END
