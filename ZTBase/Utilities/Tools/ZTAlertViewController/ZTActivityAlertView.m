//
//  ZTActivityAlertView.m
//  ZTCarOwner
//
//  Created by ZWL on 2018/7/5.
//  Copyright © 2018 ZWL. All rights reserved.
//

#import "ZTActivityAlertView.h"
#import "ZTPublicMethod.h"

@interface ZTActivityAlertView ()
@property(nonatomic, strong) UIImageView * activityImage;
@property(nonatomic, strong) UIButton * closeBtn;
@end

@implementation ZTActivityAlertView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        [self createSubviews];
    }
    return self;
}

- (void)createSubviews{
    [self addSubview:self.activityImage];
    [self addSubview:self.closeBtn];
    [self.activityImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self);
        make.width.mas_equalTo(getPtW(60*PADDING));
        make.height.mas_equalTo(getPtH(68*PADDING));
    }];
    [self.closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.activityImage.mas_bottom).offset(getPtH(75));
        make.centerX.mas_equalTo(self.activityImage);
        make.width.height.mas_equalTo(getPtW(6*PADDING));
    }];
}

-(void)closeClick{
    if (self.closeBlock) {
        self.closeBlock();
    }
}

-(void)tapClick{
    if (self.sureBlock) {
        self.sureBlock();
    }
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    for(UITouch * touch in touches)
    {
        if (![touch.view isMemberOfClass:[UIView class]]) {
            if (self.closeBlock) {
                self.closeBlock();
            }
        };
    }
}

-(void)setImageObject:(id)imageObject{
    _imageObject = imageObject;
    if ([imageObject isKindOfClass:UIImage.class]) {
        self.activityImage.image = imageObject;
        CGFloat width = getPtW(60*PADDING);
        CGFloat height = width * (self.activityImage.image.size.height/self.activityImage.image.size.width);
        [self.activityImage mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self);
            make.centerY.mas_equalTo(-getPtH(30));
            make.width.mas_equalTo(width);
            make.height.mas_equalTo(height);
        }];
    }
    if ([imageObject isKindOfClass:NSURL.class]) {
        @WeakObj(self);
        [self.activityImage setWebImageWithURL:imageObject placeholderImage:imageNamed(@"prelook") contentMode:UIViewContentModeScaleAspectFit completion:^(BOOL isRequestSuccess) {
            @StrongObj(self);
            if (isRequestSuccess) {
                CGFloat width = getPtW(60*PADDING);
                CGFloat height = width * (self.activityImage.image.size.height/self.activityImage.image.size.width);
                [self.activityImage mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.centerX.mas_equalTo(self);
                    make.centerY.mas_equalTo(-getPtH(30));
                    make.width.mas_equalTo(width);
                    make.height.mas_equalTo(height);
                }];
            }
        }];
    }
}


-(UIImageView *)activityImage{
    if (!_activityImage) {
        _activityImage = [UIImageView new];
        _activityImage.contentMode = UIViewContentModeScaleAspectFit;
        _activityImage.userInteractionEnabled = YES;
        _activityImage.clipsToBounds = NO;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick)];
        [_activityImage addGestureRecognizer:tap];
    }
    return _activityImage;
}
-(UIButton *)closeBtn{
    if (!_closeBtn) {
        _closeBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_closeBtn setImage:GetImg(@"alert_close") forState:(UIControlStateNormal)];
        [_closeBtn addTarget:self action:@selector(closeClick) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _closeBtn;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
