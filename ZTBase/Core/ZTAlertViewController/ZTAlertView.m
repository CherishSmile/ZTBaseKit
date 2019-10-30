//
//  ZTAlertView.m
//  ZTCarOwner
//
//  Created by ZWL on 2018/7/19.
//  Copyright © 2018 ZWL. All rights reserved.
//

#import "ZTAlertView.h"
#import "TTTAttributedLabel.h"
#import "ZTAlertController.h"
#import <Masonry/Masonry.h>
#import "ZTBaseFunction.h"


@interface ZTAlertView ()<TTTAttributedLabelDelegate>

@property(nonatomic, strong) UIView * bgView;
@property(nonatomic, strong) UILabel * titlelbl;
@property(nonatomic, strong) TTTAttributedLabel * messagelbl;

@property(nonatomic, copy) NSString * title;
@property(nonatomic, strong) NSArray<ZTAlertAction *> * actions;
@property(nonatomic, strong) NSArray<UITextField *> * textFields;


@property(nonatomic, assign) BOOL  isExistTitle;
@property(nonatomic, assign) BOOL  isExistMessage;
@property(nonatomic, assign) BOOL  isExistTextFields;



@property(nonatomic, strong) NSMutableDictionary<id,ZTAlertCompleteHandler> * tapTransitInformationHandlers;

@property(nonatomic, strong) NSMutableDictionary<id,ZTAlertCompleteHandler> * tapPhoneHandlers;

@property(nonatomic, strong) NSMutableDictionary<id,ZTAlertCompleteHandler> * tapUrlHandlers;

@end

@implementation ZTAlertView

- (instancetype)initWithTitle:(NSString *)title message:(id)message actions:(NSArray<ZTAlertAction *> *)actions textFields:(NSArray<UITextField *> *)textFields
{
    self = [super init];
    if (self) {
        self.frame = [UIScreen mainScreen].bounds;
        self.tapUrlHandlers = [NSMutableDictionary dictionary];
        self.tapPhoneHandlers = [NSMutableDictionary dictionary];
        self.tapTransitInformationHandlers = [NSMutableDictionary dictionary];
        
        self.title = title;
        self.message = message;
        self.actions = actions;
        self.textFields = textFields;
        [self createSubviews];
    }
    return self;
}

- (void)createSubviews{
    
    [self addSubview:self.bgView];
    
    if (self.isExistTitle&&self.isExistMessage) {
        [self.bgView addSubview:self.titlelbl];
        [self.bgView addSubview:self.messagelbl];
        [self.titlelbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(self.messagelbl);
        }];
        [self.messagelbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.bgView);
            make.top.mas_equalTo(self.titlelbl.mas_bottom).offset(ZTPtFromPx(2*PADDING));
            make.left.mas_equalTo(ZTPtFromPx(3*PADDING));
            make.right.mas_equalTo(-ZTPtFromPx(3*PADDING));
        }];
    }else if (self.isExistTitle&&!self.isExistMessage){
        [self.bgView addSubview:self.titlelbl];
        [self.titlelbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(ZTPtFromPx(3*PADDING));
            make.right.mas_equalTo(-ZTPtFromPx(3*PADDING));
        }];
    }else if (!self.isExistTitle&&self.isExistMessage){
        [self.bgView addSubview:self.messagelbl];
        [self.messagelbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.bgView);
            make.left.mas_equalTo(ZTPtFromPx(3*PADDING));
            make.right.mas_equalTo(-ZTPtFromPx(3*PADDING));
        }];
    }else{
        self.titlelbl.text = [self noSetTitleAndMessage];
        [self.bgView addSubview:self.titlelbl];
        [self.titlelbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(ZTPtFromPx(3*PADDING));
            make.right.mas_equalTo(-ZTPtFromPx(3*PADDING));
        }];
    }
    
    if (self.textFields.count) {
        [self.textFields enumerateObjectsUsingBlock:^(UITextField * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [self.bgView addSubview:obj];
            [obj mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.mas_equalTo(self.bgView);
                make.height.mas_equalTo(ZTPtFromPx(5*PADDING));
                make.width.mas_equalTo(ZTPtFromPx(24*PADDING));
                
                
                if (self.isExistMessage){
                    make.top.mas_equalTo(self.messagelbl.mas_bottom).offset(ZTPtFromPx(5*PADDING)*idx+ZTPtFromPx(3*PADDING));
                    
                }else if (self.isExistTitle){
                    make.top.mas_equalTo(self.titlelbl.mas_bottom).offset(ZTPtFromPx(5*PADDING)*idx+ZTPtFromPx(3*PADDING));
                }else{
                    make.top.mas_equalTo(self.titlelbl.mas_bottom).offset(ZTPtFromPx(5*PADDING)*idx+ZTPtFromPx(3*PADDING));
                }
            }];
        }];
    }
    
    UITextField * textField = self.textFields.lastObject;
    if (self.actions.count==0) {
        [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(self);
            make.width.mas_equalTo(SCREEN_WIDTH-2*ZTPtFromPx(8*PADDING));
            if (self.isExistTitle) {
                make.top.mas_equalTo(self.titlelbl.mas_top).offset(-ZTPtFromPx(3*PADDING));
            }else if (self.isExistMessage){
                make.top.mas_equalTo(self.messagelbl.mas_top).offset(-ZTPtFromPx(3*PADDING));
            }else{
                make.top.mas_equalTo(self.titlelbl.mas_top).offset(-ZTPtFromPx(3*PADDING));
            }
            
            if (self.isExistTextFields) {
                make.bottom.mas_equalTo(textField.mas_bottom).offset(ZTPtFromPx(3*PADDING));
            }else if (self.isExistMessage){
                make.bottom.mas_equalTo(self.messagelbl.mas_bottom).offset(ZTPtFromPx(3*PADDING));
            }else if (self.isExistTitle){
                make.bottom.mas_equalTo(self.titlelbl.mas_bottom).offset(ZTPtFromPx(3*PADDING));
            }else{
                make.bottom.mas_equalTo(self.titlelbl.mas_bottom).offset(ZTPtFromPx(3*PADDING));
                
            }
        }];
        
    }else if (self.actions.count==2){
        ZTAlertAction * actionBtn1 = self.actions.firstObject;
        ZTAlertAction * actionBtn2 = self.actions.lastObject;
        [self.bgView addSubview:actionBtn1];
        [self.bgView addSubview:actionBtn2];
        
        [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(self);
            make.width.mas_equalTo(SCREEN_WIDTH-2*ZTPtFromPx(8*PADDING));
            
            if (self.isExistTitle) {
                make.top.mas_equalTo(self.titlelbl.mas_top).offset(-ZTPtFromPx(3*PADDING));
            }else if (self.isExistMessage){
                make.top.mas_equalTo(self.messagelbl.mas_top).offset(-ZTPtFromPx(3*PADDING));
            }else{
                make.top.mas_equalTo(self.titlelbl.mas_top).offset(-ZTPtFromPx(3*PADDING));
            }
            make.bottom.mas_equalTo(actionBtn1.mas_bottom);
        }];
        [actionBtn1 mas_makeConstraints:^(MASConstraintMaker *make) {
            if (self.isExistTextFields) {
                make.top.mas_equalTo(textField.mas_bottom).offset(ZTPtFromPx(3*PADDING));
            }else if (self.isExistMessage){
                make.top.mas_equalTo(self.messagelbl.mas_bottom).offset(ZTPtFromPx(3*PADDING));
            }else if (self.isExistTitle){
                make.top.mas_equalTo(self.titlelbl.mas_bottom).offset(ZTPtFromPx(3*PADDING));
            }else{
                make.top.mas_equalTo(self.titlelbl.mas_bottom).offset(ZTPtFromPx(3*PADDING));
                
            }
            make.left.mas_equalTo(self.bgView);
            make.right.mas_equalTo(self.bgView.mas_centerX);
            make.height.mas_equalTo(ZTPtFromPx(10*PADDING));
        }];
        [actionBtn2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.height.width.mas_equalTo(actionBtn1);
            make.right.mas_equalTo(self.bgView);
        }];
    }else{
        [self.actions enumerateObjectsUsingBlock:^(ZTAlertAction * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [self.bgView addSubview:obj];
            [obj mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.mas_equalTo(self.bgView);
                make.height.mas_equalTo(ZTPtFromPx(10*PADDING));
                
                if (self.isExistTextFields) {
                    make.top.mas_equalTo(textField.mas_bottom).offset(ZTPtFromPx(10*PADDING)*idx+ZTPtFromPx(3*PADDING));
                    
                }else if (self.isExistMessage){
                    make.top.mas_equalTo(self.messagelbl.mas_bottom).offset(ZTPtFromPx(10*PADDING)*idx+ZTPtFromPx(3*PADDING));
                    
                }else if (self.isExistTitle){
                    make.top.mas_equalTo(self.titlelbl.mas_bottom).offset(ZTPtFromPx(10*PADDING)*idx+ZTPtFromPx(3*PADDING));
                }else{
                    make.top.mas_equalTo(self.titlelbl.mas_bottom).offset(ZTPtFromPx(10*PADDING)*idx+ZTPtFromPx(3*PADDING));
                    
                }
            }];
        }];
        ZTAlertAction *lastBtn = self.actions.lastObject;
        [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(self);
            make.width.mas_equalTo(SCREEN_WIDTH-2*ZTPtFromPx(8*PADDING));
            
            if (self.isExistTitle) {
                make.top.mas_equalTo(self.titlelbl.mas_top).offset(-ZTPtFromPx(3*PADDING));
            }else if (self.isExistMessage){
                make.top.mas_equalTo(self.messagelbl.mas_top).offset(-ZTPtFromPx(3*PADDING));
            }else{
                make.top.mas_equalTo(self.titlelbl.mas_top).offset(-ZTPtFromPx(3*PADDING));
            }
            make.bottom.mas_equalTo(lastBtn.mas_bottom);
        }];
        
    }
    
    
    [self layoutIfNeeded];
    
    if (self.actions.count==2) {
        [self.actions enumerateObjectsUsingBlock:^(ZTAlertAction * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            ZTDrawLineWithWidth(obj, ZTSeparatorColor, 1, CGPointZero, CGPointMake(CGRectGetMaxX(obj.frame), 0));
            if (idx==0) {
                ZTDrawLineWithWidth(obj, ZTSeparatorColor, 1, CGPointMake(CGRectGetMaxX(obj.frame), 0), CGPointMake(CGRectGetMaxX(obj.frame), CGRectGetMaxY(obj.frame)));
            }
        }];
    }else{
        [self.actions enumerateObjectsUsingBlock:^(ZTAlertAction * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            ZTDrawLineWithWidth(obj, ZTSeparatorColor, 1, CGPointZero, CGPointMake(CGRectGetMaxX(obj.frame), 0));
        }];
    }
}


/**
 添加链接
 
 @param url url
 @param range 链接位置
 */
- (void)addLinkToURL:(NSURL *)url withRange:(NSRange)range tapCompleteHandler:(ZTAlertViewCompleteHandler)completeHandler{
    if (completeHandler) {
        [self.tapUrlHandlers setObject:completeHandler forKey:url];
    }
    [self.messagelbl addLinkToURL:url withRange:range];
}

/**
 添加电话号码
 
 @param phoneNumber 电话号码
 @param range 电话号码位置
 */
- (void)addLinkToPhoneNumber:(NSString *)phoneNumber withRange:(NSRange)range tapCompleteHandler:(ZTAlertViewCompleteHandler)completeHandler{
    if (completeHandler) {
        [self.tapPhoneHandlers setObject:completeHandler forKey:phoneNumber];
    }
    [self.messagelbl addLinkToPhoneNumber:phoneNumber withRange:range];
}


/**
 添加自定义信息
 
 @param components 自定义信息
 @param range 位置
 */
- (void)addLinkToTransitInformation:(NSDictionary *)components withRange:(NSRange)range tapCompleteHandler:(ZTAlertViewCompleteHandler)completeHandler{
    if (completeHandler) {
        [self.tapPhoneHandlers setObject:completeHandler forKey:components];
    }
    [self.messagelbl addLinkToTransitInformation:components withRange:range];
}



#pragma mark - hanler

-(NSString *)noSetTitleAndMessage{
    if (!self.isExistTitle&&!self.isExistMessage) {
        return @"请设置标题或者内容";
    }else{
        return self.title;
    }
}

-(BOOL)isExistTitle{
    return self.title&&ZTStringFromNullableString(self.title).length;
}
-(BOOL)isExistMessage{
    BOOL isExistMessage = NO;
    if ([self.message isKindOfClass:NSString.class]) {
        NSString * message = (NSString *)self.message;
        isExistMessage = ZTStringFromNullableString(message).length;
    }
    if ([self.message isKindOfClass:NSAttributedString.class]) {
        NSAttributedString * message = (NSAttributedString *)self.message;
        isExistMessage = message.length;
    }
    return isExistMessage;
}
-(BOOL)isExistTextFields{
    return self.textFields.count;
}


#pragma mark - TTTAttributedLabelDelegate
-(void)attributedLabel:(TTTAttributedLabel *)label didSelectLinkWithURL:(NSURL *)url{
    ZTAlertCompleteHandler handler = self.tapUrlHandlers[url];
    handler();
}
-(void)attributedLabel:(TTTAttributedLabel *)label didSelectLinkWithPhoneNumber:(NSString *)phoneNumber{
    ZTAlertCompleteHandler handler = self.tapPhoneHandlers[phoneNumber];
    handler();
}
-(void)attributedLabel:(TTTAttributedLabel *)label didSelectLinkWithTransitInformation:(NSDictionary *)components{
    
    ZTAlertCompleteHandler handler = self.tapTransitInformationHandlers[components];
    handler();
}

#pragma mark - setter

-(void)setTextFields:(NSArray<UITextField *> *)textFields{
    _textFields = textFields;
}

-(void)setTitleColor:(UIColor *)titleColor{
    _titleColor = titleColor;
    self.titlelbl.textColor = titleColor;
}

-(void)setTitle:(NSString *)title{
    _title = title;
    self.titlelbl.text = title;
}
-(void)setMessage:(id)message{
    _message = message;
    if ([message isKindOfClass:NSString.class]) {
        self.messagelbl.text = message;
    }
    if ([message isKindOfClass:NSAttributedString.class]) {
        [self.messagelbl setText:message afterInheritingLabelAttributesAndConfiguringWithBlock:nil];
    }
}

-(void)setMessageAlignment:(NSTextAlignment)messageAlignment{
    _messageAlignment = messageAlignment;
    self.messagelbl.textAlignment = messageAlignment;
}

-(void)setLinkAttributes:(NSDictionary *)linkAttributes{
    _linkAttributes = linkAttributes;
    self.messagelbl.linkAttributes = linkAttributes;
}

#pragma mark - getter
-(UIView *)bgView{
    if (!_bgView) {
        _bgView = [UIView new];
        _bgView.backgroundColor = [UIColor whiteColor];
        ZTDrawBorder(_bgView, [UIColor clearColor], 12);
    }
    return _bgView;
}
-(UILabel *)titlelbl{
    if (!_titlelbl) {
        _titlelbl = [UILabel new];
        _titlelbl.textAlignment = NSTextAlignmentCenter;
        _titlelbl.numberOfLines = 0;
        _titlelbl.font = GetBoldFont(F6);
    }
    return _titlelbl;
}
- (TTTAttributedLabel *)messagelbl{
    if (!_messagelbl) {
        _messagelbl = [TTTAttributedLabel new];
        _messagelbl.lineHeightMultiple = 1.2;
        _messagelbl.textAlignment = NSTextAlignmentCenter;
        _messagelbl.font = GetFont(F5);
        _messagelbl.numberOfLines = 0;
        _messagelbl.delegate = self;
        _messagelbl.linkAttributes = @{NSForegroundColorAttributeName:ZTConfig.themeColor?:ZTThemeColor};
        _messagelbl.textColor = ZTTextPaleGrayColor;
    }
    return _messagelbl;
}

@end
