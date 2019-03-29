//
//  ZTUpdateAlertView.m
//  ZTCarOwner
//
//  Created by ZWL on 2018/7/26.
//  Copyright © 2018 ZWL. All rights reserved.
//

#import "ZTUpdateAlertView.h"
#import "TTTAttributedLabel.h"
#import "ZTAlertController.h"
#import "ZTPublicMethod.h"
#import <Masonry/Masonry.h>


static CGFloat hwRatio = 0.55 ;

static inline CGFloat alertWidth(void){
    return SCREEN_WIDTH-2*getPtW(10*PADDING);
};

@interface ZTUpdateAlertView ()
@property(nonatomic, strong) UIView * bgView;
@property(nonatomic, strong) UIImageView * topImage;
@property(nonatomic, strong) UIView * bottomView;

@property(nonatomic, strong) UILabel * titlelbl;
@property(nonatomic, strong) TTTAttributedLabel * contentlbl;

@property(nonatomic, copy) NSString * title;
@property(nonatomic, strong) id content;
@property(nonatomic, strong) NSArray<ZTAlertAction *> * actions;
@property(nonatomic, strong) NSArray<ZTAlertAction *> * defaultActions;
@property(nonatomic, strong) NSArray<ZTAlertAction *> * cancleActions;



@property(nonatomic, assign) BOOL  isExistTitle;
@property(nonatomic, assign) BOOL  isExistMessage;

@end

@implementation ZTUpdateAlertView

-(instancetype)initWithTitle:(NSString *)title message:(id)message actions:(NSArray<ZTAlertAction *> *)actions{
    if (self = [super init]) {
        self.frame = [UIScreen mainScreen].bounds;
        self.title = title;
        self.content = message;
        self.actions = actions;
        [self createSubviews];
    }
    return self;
}
- (void)createSubviews{
    [self addSubview:self.bgView];
    [self.bgView addSubview:self.topImage];
    [self.bgView addSubview:self.bottomView];
    
    [self.topImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.bgView);
        make.height.mas_equalTo(alertWidth()*hwRatio);
        make.bottom.mas_equalTo(self.bottomView.mas_top);
    }];
    
    if (self.isExistTitle&&self.isExistMessage) {
        [self.bottomView addSubview:self.titlelbl];
        [self.bottomView addSubview:self.contentlbl];
        [self.titlelbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(getPtW(4*PADDING));
            make.right.mas_equalTo(-getPtW(4*PADDING));
            make.bottom.mas_equalTo(self.contentlbl.mas_top).offset(-getPtH(2*PADDING));
        }];
        [self.contentlbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(getPtW(4*PADDING));
            make.right.mas_equalTo(-getPtW(4*PADDING));
        }];
    }else if (self.isExistTitle&&!self.isExistMessage){
        [self.bottomView addSubview:self.titlelbl];
        [self.titlelbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(getPtW(4*PADDING));
            make.right.mas_equalTo(-getPtW(4*PADDING));
        }];
    }else if (!self.isExistTitle&&self.isExistMessage){
        [self.bottomView addSubview:self.contentlbl];
        [self.contentlbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(getPtW(4*PADDING));
            make.right.mas_equalTo(-getPtW(4*PADDING));
        }];
    }else{
        self.titlelbl.text = [self noSetTitleAndMessage];
        [self.bottomView addSubview:self.titlelbl];
        [self.titlelbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(getPtW(4*PADDING));
            make.right.mas_equalTo(-getPtW(4*PADDING));
        }];
    }
    
    
    if (self.defaultActions.count==0) {
        [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(alertWidth());
            make.centerX.mas_equalTo(self.topImage);
            make.top.mas_equalTo(self.titlelbl.mas_top);
            if (self.isExistMessage) {
                make.bottom.mas_equalTo(self.contentlbl.mas_bottom).offset(getPtH(4*PADDING));
                
            }else{
                make.bottom.mas_equalTo(self.titlelbl.mas_bottom).offset(getPtH(4*PADDING));
                
            }
        }];
        
    }else{
        [self.defaultActions enumerateObjectsUsingBlock:^(ZTAlertAction * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [self.bottomView addSubview:obj];
            [obj mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(getPtW(4*PADDING));
                make.right.mas_equalTo(-getPtW(4*PADDING));
                make.height.mas_equalTo(getPtH(6*PADDING));
                if (self.isExistMessage) {
                    make.top.mas_equalTo(self.contentlbl.mas_bottom).offset(getPtH(9*PADDING)*idx+getPtH(4*PADDING));
                    
                }else{
                    make.top.mas_equalTo(self.titlelbl.mas_bottom).offset(getPtH(9*PADDING)*idx+getPtH(4*PADDING));
                    
                }
            }];
        }];
        ZTAlertAction *lastBtn = self.defaultActions.lastObject;
        [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(alertWidth());
            make.centerX.mas_equalTo(self.topImage);
            make.top.mas_equalTo(self.titlelbl.mas_top);
            make.bottom.mas_equalTo(lastBtn.mas_bottom).offset(getPtH(4*PADDING));
        }];
    }
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self);
        make.width.mas_equalTo(alertWidth());
        make.top.mas_equalTo(self.topImage);
        make.bottom.mas_equalTo(self.bottomView);
    }];
    
    if (self.cancleActions.count) {
        ZTAlertAction * cancleAction = self.cancleActions.lastObject;
        [self addSubview:cancleAction];
        [cancleAction mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.bgView);
            make.top.mas_equalTo(self.bgView.mas_bottom).offset(getPtW(4*PADDING));
            make.width.height.mas_equalTo(getPtW(6*PADDING));
        }];
    }
    
    [self layoutIfNeeded];
    
    drawRoundedCorner(self.bottomView, UIRectCornerBottomLeft|UIRectCornerBottomRight, CGSizeMake(6, 6));
    [self.actions enumerateObjectsUsingBlock:^(ZTAlertAction * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        drawRoundedCorner(obj, UIRectCornerAllCorners, obj.bounds.size);
    }];
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
    if ([self.content isKindOfClass:NSString.class]) {
        NSString * message = (NSString *)self.content;
        isExistMessage = isNil(message).length;
    }
    if ([self.content isKindOfClass:NSAttributedString.class]) {
        NSAttributedString * message = (NSAttributedString *)self.content;
        isExistMessage = message.length;
    }
    return isExistMessage;
}
#pragma mark - setter
-(void)setTitle:(NSString *)title{
    _title = title;
    self.titlelbl.text = isNil(title);
}
-(void)setContent:(id)content{
    _content = content;
    if ([content isKindOfClass:NSString.class]) {
        self.contentlbl.text = content;
    }
    if ([content isKindOfClass:NSAttributedString.class]) {
        self.contentlbl.attributedText = content;
    }
}

-(void)setActions:(NSArray<ZTAlertAction *> *)actions{
    _actions = actions;
    NSMutableArray * defaultActions = [NSMutableArray array];
    NSMutableArray * cancleActions = [NSMutableArray array];
    [actions enumerateObjectsUsingBlock:^(ZTAlertAction * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.style==ZTAlertActionStyleDefault) {
            [defaultActions addObject:obj];
        }
        if (obj.style==ZTAlertActionStyleCancel) {
            [cancleActions addObject:obj];
        }
    }];
    self.defaultActions = defaultActions.copy;
    self.cancleActions = cancleActions.copy;
}

#pragma mark - getter
-(UIImageView *)topImage{
    if (!_topImage) {
        _topImage = [UIImageView new];
        _topImage.contentMode = UIViewContentModeScaleAspectFill;
        _topImage.image = imageNamed(@"update_huojian");
    }
    return _topImage;
}
-(UIView *)bgView{
    if (!_bgView) {
        _bgView = [UIView new];
    }
    return _bgView;
}

-(UIView *)bottomView{
    if (!_bottomView) {
        _bottomView = [UIView new];
        _bottomView.backgroundColor = [UIColor whiteColor];
    }
    return _bottomView;
}
-(UILabel *)titlelbl{
    if (!_titlelbl) {
        _titlelbl = [UILabel new];
        _titlelbl.numberOfLines = 0;
        _titlelbl.font = GetFont(F5);
    }
    return _titlelbl;
}
- (TTTAttributedLabel *)contentlbl{
    if (!_contentlbl) {
        _contentlbl = [TTTAttributedLabel new];
        _contentlbl.lineSpacing = 5;
        _contentlbl.font = GetFont(F4);
        _contentlbl.numberOfLines = 0;
        _contentlbl.textColor = ZTTextGrayColor;
    }
    return _contentlbl;
}


/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
