//
//  ZTTextFieldCell.m
//  ZTCloudMirror
//
//  Created by ZWL on 2017/11/23.
//  Copyright © 2017年 中通四局. All rights reserved.
//

#import "ZTTextFieldCell.h"
#import "ZTPublicMethod.h"

@interface ZTTextFieldCell()<UITextFieldDelegate>
@property (nonatomic, strong)UITextField *inputField;
@property (nonatomic, strong)UILabel *titleLable;
@property (nonatomic, strong)UIView * bottomLineView;
@property (nonatomic, strong)UITapGestureRecognizer * titleTap;
@end

@implementation ZTTextFieldCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createSubviews];
    }
    return self;
}

-(void)createSubviews{
    [self.contentView addSubview:self.titleLable];
    [self.contentView addSubview:self.inputField];
    
    [self.titleLable addGestureRecognizer:self.titleTap];
    
    _bottomLineView = [UIView new];
    _bottomLineView.backgroundColor = ZTSeparatorColor;
    [self addSubview:_bottomLineView];
    
    [self.titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(getPtW(3*PADDING));
        make.centerY.mas_equalTo(self.contentView);
        make.height.mas_equalTo(getPtH(4*PADDING));
        make.width.mas_equalTo(getPtW(22*PADDING));
    }];
    [self.inputField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLable.mas_right).offset(getPtW(2*PADDING));
        make.centerY.height.mas_equalTo(self.titleLable);
        make.right.mas_equalTo(-getPtW(3*PADDING));
    }];
    [self.bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.mas_equalTo(0);
        make.left.mas_equalTo(getPtW(3*PADDING));
        make.height.mas_equalTo(1);
    }];
}

-(void)textChange:(UITextField *)textField{
    switch (self.model.filterRule) {
        case ZTInputFilterRuleSmallLetterAndNumber:
        {
            textField.text = [isNil(textField.text) lowercaseString];
        }
            break;
        case ZTInputFilterRuleCapitalLetterAndNumber:
        {
            textField.text = [isNil(textField.text) uppercaseString];
        }
            break;
        case ZTInputFilterRuleEngineNumber:
        {
            textField.text = [isNil(textField.text) uppercaseString];
        }
            break;
            
        default:
            break;
    }
    if (self.model.maxLength>0&&isNil(textField.text).length>self.model.maxLength) {
        textField.text = [isNil(textField.text) substringToIndex:self.model.maxLength];
    }
    if ([self.delegate respondsToSelector:@selector(inputViewDidChange:textString:)]) {
        [self.delegate inputViewDidChange:self textString:isNil(textField.text)];
    }
}
-(void)tapClick:(UITapGestureRecognizer*)tap{
    if ([self.delegate respondsToSelector:@selector(textFieldCellDidTapTitle:)]) {
        [self.delegate textFieldCellDidTapTitle:self];
    }
}
#pragma mark - UITextFieldDelegate

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if (!self.model.isEnable) {
        if ([self.delegate respondsToSelector:@selector(textFieldCellDidTapTextField:)]) {
            [self.delegate textFieldCellDidTapTextField:self];
        }
        return NO;
    }
    return YES;
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    BOOL isWrite = YES;
    switch (self.model.filterRule) {
        case ZTInputFilterRuleOnlyLetter:
        {
            isWrite = validateAllLetter(string);
        }
            break;
        case ZTInputFilterRuleOnlyNumber:
        {
            isWrite = validateAllNumber(string);
        }
            break;
        case ZTInputFilterRuleLetterAndNumber:
        {
            isWrite = validateNumberOrLetter(string);
        }
            break;
        case ZTInputFilterRuleCapitalLetterAndNumber:
        {
            isWrite = validateNumberOrLetter(string);
        }
            break;
        case ZTInputFilterRuleSmallLetterAndNumber:
        {
            isWrite = validateNumberOrLetter(string);
        }
            break;
        case ZTInputFilterRuleEngineNumber:
        {
            isWrite = validateNumberOrLetter(string)||[string isEqualToString:@"-"];
        }
            break;
            
        default:
            break;
    }
    return isWrite||[string isEqualToString:@""];
}

#pragma mark - setter
-(void)setModel:(ZTInputModel *)model{
    _model = model;
    self.inputField.placeholder = isNil(model.placeholder);
    self.inputField.keyboardType = model.keyboardType;
    self.inputField.textAlignment = model.textAlignment;
    self.inputField.text = model.content;
    self.accessoryType = model.isShowArrow?UITableViewCellAccessoryDisclosureIndicator:UITableViewCellAccessoryNone;
    if (model.isAttributedTitle) {
        self.titleLable.attributedText = model.attributedTitle;
        self.titleLable.userInteractionEnabled = YES;
    }else{
        self.titleLable.text = isNil(model.title);
        self.titleLable.userInteractionEnabled = NO;
    }
    self.bottomLineView.hidden = !model.isShowLine;
}

#pragma mark - getter
-(UITextField *)inputField{
    if (!_inputField) {
        _inputField = [UITextField new];
        _inputField.textColor = ZTTextGrayColor;
        _inputField.font = GetFont(F5);
        _inputField.delegate = self;
        [_inputField addTarget:self action:@selector(textChange:) forControlEvents:(UIControlEventEditingChanged)];
        _inputField.backgroundColor = [UIColor whiteColor];
    }
    return _inputField;
}

-(UILabel *)titleLable{
    if (!_titleLable) {
        _titleLable  = [UILabel new];
        _titleLable.textColor = ZTTextPaleGrayColor;
        _titleLable.font = GetFont(F5);
    }
    return _titleLable;
}

-(UITapGestureRecognizer *)titleTap{
    if (!_titleTap) {
        _titleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)];
    }
    return _titleTap;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
