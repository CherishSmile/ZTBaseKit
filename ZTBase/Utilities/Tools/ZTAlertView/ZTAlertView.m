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
#import "ZTPublicMethod.h"


@interface ZTAlertView ()

@property(nonatomic, strong) UIView * bgView;
@property(nonatomic, strong) UILabel * titlelbl;
@property(nonatomic, strong) TTTAttributedLabel * messagelbl;

@property(nonatomic, copy) NSString * title;
@property(nonatomic, strong) NSArray<ZTAlertAction *> * actions;
@property(nonatomic, strong) NSArray<UITextField *> * textFields;


@property(nonatomic, assign) BOOL  isExistTitle;
@property(nonatomic, assign) BOOL  isExistMessage;
@property(nonatomic, assign) BOOL  isExistTextFields;

@end

@implementation ZTAlertView

- (instancetype)initWithTitle:(NSString *)title message:(id)message actions:(NSArray<ZTAlertAction *> *)actions textFields:(NSArray<UITextField *> *)textFields
{
    self = [super init];
    if (self) {
        self.frame = [UIScreen mainScreen].bounds;
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
            make.top.mas_equalTo(self.titlelbl.mas_bottom).offset(getPtH(2*PADDING));
            make.left.mas_equalTo(getPtW(3*PADDING));
            make.right.mas_equalTo(-getPtW(3*PADDING));
        }];
    }else if (self.isExistTitle&&!self.isExistMessage){
        [self.bgView addSubview:self.titlelbl];
        [self.titlelbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(getPtW(3*PADDING));
            make.right.mas_equalTo(-getPtW(3*PADDING));
        }];
    }else if (!self.isExistTitle&&self.isExistMessage){
        [self.bgView addSubview:self.messagelbl];
        [self.messagelbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.bgView);
            make.left.mas_equalTo(getPtW(3*PADDING));
            make.right.mas_equalTo(-getPtW(3*PADDING));
        }];
    }else{
        self.titlelbl.text = [self noSetTitleAndMessage];
        [self.bgView addSubview:self.titlelbl];
        [self.titlelbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(getPtW(3*PADDING));
            make.right.mas_equalTo(-getPtW(3*PADDING));
        }];
    }
    
    if (self.textFields.count) {
        [self.textFields enumerateObjectsUsingBlock:^(UITextField * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [self.bgView addSubview:obj];
            [obj mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.mas_equalTo(self.bgView);
                make.height.mas_equalTo(getPtH(5*PADDING));
                make.width.mas_equalTo(getPtW(24*PADDING));
                
                
                if (self.isExistMessage){
                    make.top.mas_equalTo(self.messagelbl.mas_bottom).offset(getPtH(5*PADDING)*idx+getPtH(3*PADDING));
                    
                }else if (self.isExistTitle){
                    make.top.mas_equalTo(self.titlelbl.mas_bottom).offset(getPtH(5*PADDING)*idx+getPtH(3*PADDING));
                }else{
                    make.top.mas_equalTo(self.titlelbl.mas_bottom).offset(getPtH(5*PADDING)*idx+getPtH(3*PADDING));
                }
            }];
        }];
    }
    
    UITextField * textField = self.textFields.lastObject;
    if (self.actions.count==0) {
        [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(self);
            make.width.mas_equalTo(SCREEN_WIDTH-2*getPtW(8*PADDING));
            if (self.isExistTitle) {
                make.top.mas_equalTo(self.titlelbl.mas_top).offset(-getPtH(3*PADDING));
            }else if (self.isExistMessage){
                make.top.mas_equalTo(self.messagelbl.mas_top).offset(-getPtH(3*PADDING));
            }else{
                make.top.mas_equalTo(self.titlelbl.mas_top).offset(-getPtH(3*PADDING));
            }
            
            if (self.isExistTextFields) {
                make.bottom.mas_equalTo(textField.mas_bottom).offset(getPtH(3*PADDING));
            }else if (self.isExistMessage){
                make.bottom.mas_equalTo(self.messagelbl.mas_bottom).offset(getPtH(3*PADDING));
            }else if (self.isExistTitle){
                make.bottom.mas_equalTo(self.titlelbl.mas_bottom).offset(getPtH(3*PADDING));
            }else{
                make.bottom.mas_equalTo(self.titlelbl.mas_bottom).offset(getPtH(3*PADDING));

            }
            
            
//            if (self.isExistTitle&&self.isExistMessage) {
//                make.top.mas_equalTo(self.titlelbl.mas_top).offset(-getPtH(3*PADDING));
//                make.bottom.mas_equalTo(self.messagelbl.mas_bottom).offset(getPtH(3*PADDING));
//            }else if (self.isExistTitle&&!self.isExistMessage){
//                make.top.mas_equalTo(self.titlelbl.mas_top).offset(-getPtH(3*PADDING));
//                make.bottom.mas_equalTo(self.titlelbl.mas_bottom).offset(getPtH(3*PADDING));
//            }else if (!self.isExistTitle&&self.isExistMessage){
//                make.top.mas_equalTo(self.messagelbl.mas_top).offset(-getPtH(3*PADDING));
//                make.bottom.mas_equalTo(self.messagelbl.mas_bottom).offset(getPtH(3*PADDING));
//            }else{
//                make.top.mas_equalTo(self.titlelbl.mas_top).offset(-getPtH(3*PADDING));
//                make.bottom.mas_equalTo(self.titlelbl.mas_bottom).offset(getPtH(3*PADDING));
//            }
        }];
        
    }else if (self.actions.count==2){
        ZTAlertAction * actionBtn1 = self.actions.firstObject;
        ZTAlertAction * actionBtn2 = self.actions.lastObject;
        [self.bgView addSubview:actionBtn1];
        [self.bgView addSubview:actionBtn2];

        [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(self);
            make.width.mas_equalTo(SCREEN_WIDTH-2*getPtW(8*PADDING));
            
            if (self.isExistTitle) {
                make.top.mas_equalTo(self.titlelbl.mas_top).offset(-getPtH(3*PADDING));
            }else if (self.isExistMessage){
                make.top.mas_equalTo(self.messagelbl.mas_top).offset(-getPtH(3*PADDING));
            }else{
                make.top.mas_equalTo(self.titlelbl.mas_top).offset(-getPtH(3*PADDING));
            }
            make.bottom.mas_equalTo(actionBtn1.mas_bottom);
            
//            if (self.isExistTitle&&self.isExistMessage) {
//                make.top.mas_equalTo(self.titlelbl.mas_top).offset(-getPtH(3*PADDING));
//                make.bottom.mas_equalTo(actionBtn1.mas_bottom);
//            }else if (self.isExistTitle&&!self.isExistMessage){
//                make.top.mas_equalTo(self.titlelbl.mas_top).offset(-getPtH(3*PADDING));
//                make.bottom.mas_equalTo(actionBtn1.mas_bottom);
//            }else if (!self.isExistTitle&&self.isExistMessage){
//                make.top.mas_equalTo(self.messagelbl.mas_top).offset(-getPtH(3*PADDING));
//                make.bottom.mas_equalTo(actionBtn1.mas_bottom);
//            }else{
//                make.top.mas_equalTo(self.titlelbl.mas_top).offset(-getPtH(3*PADDING));
//                make.bottom.mas_equalTo(actionBtn1.mas_bottom);
//            }
        }];
        [actionBtn1 mas_makeConstraints:^(MASConstraintMaker *make) {
            if (self.isExistTextFields) {
                make.top.mas_equalTo(textField.mas_bottom).offset(getPtH(3*PADDING));
            }else if (self.isExistMessage){
                make.top.mas_equalTo(self.messagelbl.mas_bottom).offset(getPtH(3*PADDING));
            }else if (self.isExistTitle){
                make.top.mas_equalTo(self.titlelbl.mas_bottom).offset(getPtH(3*PADDING));
            }else{
                make.top.mas_equalTo(self.titlelbl.mas_bottom).offset(getPtH(3*PADDING));

            }
                
//            if (self.isExistTitle&&self.isExistMessage) {
//                make.top.mas_equalTo(self.messagelbl.mas_bottom).offset(getPtH(3*PADDING));
//            }else if (self.isExistTitle&&!self.isExistMessage){
//                make.top.mas_equalTo(self.titlelbl.mas_bottom).offset(getPtH(3*PADDING));
//            }else if (!self.isExistTitle&&self.isExistMessage){
//                make.top.mas_equalTo(self.messagelbl.mas_bottom).offset(getPtH(3*PADDING));
//            }else{
//                make.top.mas_equalTo(self.titlelbl.mas_bottom).offset(getPtH(3*PADDING));
//            }
            make.left.mas_equalTo(self.bgView);
            make.right.mas_equalTo(self.bgView.mas_centerX);
            make.height.mas_equalTo(getPtH(10*PADDING));
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
                make.height.mas_equalTo(getPtH(10*PADDING));
                
                if (self.isExistTextFields) {
                    make.top.mas_equalTo(textField.mas_bottom).offset(getPtH(10*PADDING)*idx+getPtH(3*PADDING));

                }else if (self.isExistMessage){
                    make.top.mas_equalTo(self.messagelbl.mas_bottom).offset(getPtH(10*PADDING)*idx+getPtH(3*PADDING));

                }else if (self.isExistTitle){
                    make.top.mas_equalTo(self.titlelbl.mas_bottom).offset(getPtH(10*PADDING)*idx+getPtH(3*PADDING));
                }else{
                    make.top.mas_equalTo(self.titlelbl.mas_bottom).offset(getPtH(10*PADDING)*idx+getPtH(3*PADDING));

                }
                
//                if (self.isExistTitle&&self.isExistMessage) {
//                    make.top.mas_equalTo(self.messagelbl.mas_bottom).offset(getPtH(10*PADDING)*idx+getPtH(3*PADDING));
//                }else if (self.isExistTitle&&!self.isExistMessage){
//                    make.top.mas_equalTo(self.titlelbl.mas_bottom).offset(getPtH(10*PADDING)*idx+getPtH(3*PADDING));
//                }else if (!self.isExistTitle&&self.isExistMessage){
//                    make.top.mas_equalTo(self.messagelbl.mas_bottom).offset(getPtH(10*PADDING)*idx+getPtH(3*PADDING));
//                }else{
//                    make.top.mas_equalTo(self.titlelbl.mas_bottom).offset(getPtH(10*PADDING)*idx+getPtH(3*PADDING));
//                }
            }];
        }];
        ZTAlertAction *lastBtn = self.actions.lastObject;
        [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(self);
            make.width.mas_equalTo(SCREEN_WIDTH-2*getPtW(8*PADDING));
            
            if (self.isExistTitle) {
                make.top.mas_equalTo(self.titlelbl.mas_top).offset(-getPtH(3*PADDING));
            }else if (self.isExistMessage){
                make.top.mas_equalTo(self.messagelbl.mas_top).offset(-getPtH(3*PADDING));
            }else{
                make.top.mas_equalTo(self.titlelbl.mas_top).offset(-getPtH(3*PADDING));
            }
            make.bottom.mas_equalTo(lastBtn.mas_bottom);
            
//            if (self.isExistTitle&&self.isExistMessage) {
//                make.top.mas_equalTo(self.titlelbl.mas_top).offset(-getPtH(3*PADDING));
//                make.bottom.mas_equalTo(lastBtn.mas_bottom);
//            }else if (self.isExistTitle&&!self.isExistMessage){
//                make.top.mas_equalTo(self.titlelbl.mas_top).offset(-getPtH(3*PADDING));
//                make.bottom.mas_equalTo(lastBtn.mas_bottom);
//            }else if (!self.isExistTitle&&self.isExistMessage){
//                make.top.mas_equalTo(self.messagelbl.mas_top).offset(-getPtH(3*PADDING));
//                make.bottom.mas_equalTo(lastBtn.mas_bottom);
//            }else{
//                make.top.mas_equalTo(self.titlelbl.mas_top).offset(-getPtH(3*PADDING));
//                make.bottom.mas_equalTo(lastBtn.mas_bottom);
//            }
        }];
       
    }
    
   
    [self layoutIfNeeded];
    
    if (self.actions.count==2) {
        [self.actions enumerateObjectsUsingBlock:^(ZTAlertAction * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            drawLineWithWidth(obj, ZTSeparatorColor, 1, CGPointZero, CGPointMake(CGRectGetMaxX(obj.frame), 0));
            if (idx==0) {
                drawLineWithWidth(obj, ZTSeparatorColor, 1, CGPointMake(CGRectGetMaxX(obj.frame), 0), CGPointMake(CGRectGetMaxX(obj.frame), CGRectGetMaxY(obj.frame)));
            }
        }];
    }else{
        [self.actions enumerateObjectsUsingBlock:^(ZTAlertAction * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            drawLineWithWidth(obj, ZTSeparatorColor, 1, CGPointZero, CGPointMake(CGRectGetMaxX(obj.frame), 0));
        }];
    }
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
    return self.title&&isNil(self.title).length;
}
-(BOOL)isExistMessage{
    BOOL isExistMessage = NO;
    if ([self.message isKindOfClass:NSString.class]) {
        NSString * message = (NSString *)self.message;
        isExistMessage = isNil(message).length;
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

#pragma mark - setter

-(void)setTextFields:(NSArray<UITextField *> *)textFields{
    _textFields = textFields;
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
        self.messagelbl.attributedText = message;
    }
}

-(void)setMessageAlignment:(NSTextAlignment)messageAlignment{
    _messageAlignment = messageAlignment;
    self.messagelbl.textAlignment = messageAlignment;
}

#pragma mark - getter
-(UIView *)bgView{
    if (!_bgView) {
        _bgView = [UIView new];
        _bgView.backgroundColor = [UIColor whiteColor];
        drawBorder(_bgView, [UIColor whiteColor], 12);
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
        _messagelbl.textColor = ZTTextPaleGrayColor;
    }
    return _messagelbl;
}

@end
