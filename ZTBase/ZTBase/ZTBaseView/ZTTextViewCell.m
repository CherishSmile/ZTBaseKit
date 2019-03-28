//
//  ZTTextViewCell.m
//  ZTCloudMirror
//
//  Created by ZWL on 2017/11/23.
//  Copyright © 2017年 中通四局. All rights reserved.
//

#import "ZTTextViewCell.h"
#import "ZTTextView.h"
#import "ZTPublicMethod.h"

@interface ZTTextViewCell()<UITextViewDelegate>
@property(nonatomic,strong)ZTTextView *inputView;
@property(nonatomic,strong)UILabel *titleLable;
@end

@implementation ZTTextViewCell

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
    [self.contentView addSubview:self.inputView];
    [self.titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(getPtW(3*PADDING));
        make.right.mas_equalTo(-getPtW(3*PADDING));
        make.top.mas_equalTo(getPtH(3*PADDING));
    }];
    [self.inputView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.titleLable);
        make.top.mas_equalTo(self.titleLable.mas_bottom).offset(getPtH(2*PADDING));
        make.bottom.mas_equalTo(-getPtH(3*PADDING));
    }];
}

-(void)textViewDidChange:(UITextView *)textView{
    if ([self.delegate respondsToSelector:@selector(inputViewDidChange:textString:)]) {
        [self.delegate inputViewDidChange:self textString:isNil(textView.text)];
    }
}
#pragma mark - setter
-(void)setModel:(ZTInputModel *)model{
    _model = model;
    self.inputView.text = isNil(model.content);
    self.inputView.placeholder = isNil(model.placeholder);
    self.inputView.editable = model.isEnable;
    self.inputView.keyboardType = model.keyboardType;
    if (model.isAttributedTitle) {
        self.titleLable.attributedText = model.attributedTitle;
        self.titleLable.userInteractionEnabled = YES;
    }else{
        self.titleLable.text = isNil(model.title);
        self.titleLable.userInteractionEnabled = NO;
    }
}

#pragma mark - getter
-(ZTTextView *)inputView{
    if (!_inputView) {
        _inputView = [ZTTextView new];
        _inputView.textColor = ZTTextGrayColor;
        _inputView.font = GetFont(F4);
        _inputView.backgroundColor = ZTBackColor;
        _inputView.delegate = self;
    }
    return _inputView;
}

-(UILabel *)titleLable{
    if (!_titleLable) {
        _titleLable  = [UILabel new];
        _titleLable.textColor = ZTTextPaleGrayColor;
        _titleLable.font = GetFont(F5);
    }
    return _titleLable;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
