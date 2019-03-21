//
//  ZTInputModel.h
//  ZTCloudMirror
//
//  Created by ZWL on 2017/11/23.
//  Copyright © 2017年 中通四局. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,ZTInputFilterRule) {
    ZTInputFilterRuleNone = 0,  //无过滤规则
    ZTInputFilterRuleOnlyLetter , //仅仅字母
    ZTInputFilterRuleOnlyNumber , //仅仅数字
    ZTInputFilterRuleLetterAndNumber, //字母和数字
    ZTInputFilterRuleCapitalLetterAndNumber, //大写字母和数字
    ZTInputFilterRuleSmallLetterAndNumber,//小写字母和数组
    ZTInputFilterRuleEngineNumber //发动机号过滤规则
};

typedef NS_ENUM(NSInteger,ZTInputType) {
    ZTInputTypeTextField,
    ZTInputTypeTextView
};

@interface ZTInputModel : NSObject

@property(nonatomic, assign) ZTInputType  inputType;

/**
 标题
 */
@property(nonatomic,strong)NSString *title;

/**
 内容
 */
@property(nonatomic,strong)NSString *content;

/**
 占位符
 */
@property(nonatomic,strong)NSString *placeholder;

/**
 是否可以编辑
 */
@property(nonatomic,assign)BOOL isEnable;

/**
 键盘类型
 */
@property(nonatomic,assign)UIKeyboardType keyboardType;

/**
 文本位置
 */
@property(nonatomic,assign)NSTextAlignment textAlignment;

/**
 属性字符串
 */
@property(nonatomic,  copy) NSAttributedString * attributedTitle;

/**
 标题是否是属性字符串
 */
@property(nonatomic,assign) BOOL  isAttributedTitle;

/**
 是否显示底部分割线
 */
@property(nonatomic,assign) BOOL  isShowLine;

/**
 文本过滤规则
 */
@property(nonatomic, assign) ZTInputFilterRule  filterRule;

/**
 文本最大长度
 */
@property(nonatomic, assign) NSInteger  maxLength;

/**
 是否显示箭头
 */
@property(nonatomic, assign) BOOL  isShowArrow;

/**
 额外的信息
 */
@property(nonatomic, strong) id extra;

/**
 构造函数

 @param title 标题
 @param content 内容
 @param placeholder 占位符
 @param type 键盘类型
 @param textAlignment 文本位置
 @param isEnable 是否可以编辑
 @return ZTInputModel
 */

-(instancetype)initWithTitle:(NSString*)title content:(NSString*)content placeholder:(NSString*)placeholder keyboardType:(UIKeyboardType)type alignment:(NSTextAlignment)textAlignment enable:(BOOL)isEnable;

@end
