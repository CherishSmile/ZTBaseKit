//
//  ZTSelectPicker.m
//  ZTCarOwner
//
//  Created by ZWL on 2017/8/11.
//  Copyright © 2017年 CITCC4. All rights reserved.
//

#import "ZTSelectPicker.h"
#import "ZYAlertView.h"
#import "ZTPublicMethod.h"


const static CGFloat k_sureBtn_tag  = 401;
const static CGFloat k_cancle_tag = 402;


@interface ZTSelectPicker ()<UIPickerViewDelegate,UIPickerViewDataSource>
@property(nonatomic,strong)UIPickerView *pickerView;
@property(nonatomic,strong)UIToolbar *toolBar;
@property(nonatomic,assign)NSInteger selectIndex;
@end

@implementation ZTSelectPicker

-(instancetype)initWithTitles:(NSArray*)titles{
    if (self = [super init]) {
        self.frame=CGRectMake(0, SCREEN_HEIGHT-216-49, SCREEN_WIDTH, 216+49);

        _titleArr = titles;
        [self creatSubviews];
    }
    return self;
}

-(void)creatSubviews{
    [self addSubview:self.pickerView];
    [self addSubview:self.toolBar];
    [self.pickerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.mas_equalTo(self);
        make.height.mas_equalTo(@(216));
    }];
    [self.toolBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self);
        make.height.mas_equalTo(@49);
        make.bottom.mas_equalTo(self.pickerView.mas_top);
    }];
    [self setbarItmes];
}

-(void)setbarItmes
{
    UIButton *leftBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setTitle:@"取消" forState:UIControlStateNormal];
    leftBtn.bounds = CGRectMake(0, 0, 80, 25);
    leftBtn.titleEdgeInsets=UIEdgeInsetsMake(0, -15, 0, 15);
    [leftBtn setTitleColor:ZTTextPaleGrayColor forState:UIControlStateNormal];
    leftBtn.titleLabel.font=GetFont(F5);
    leftBtn.tag=k_cancle_tag;
    [leftBtn addTarget:self action:@selector(barItmesClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    
    UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:(UIBarButtonSystemItemFlexibleSpace) target:self action:nil];
    
    UIButton *rightBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setTitle:@"确定" forState:UIControlStateNormal];
    rightBtn.bounds = CGRectMake(0, 0, 80, 25);
    rightBtn.titleEdgeInsets=UIEdgeInsetsMake(0, 15, 0, -15);
    rightBtn.titleLabel.font=GetFont(F5);
    [rightBtn setTitleColor:ZTTextPaleGrayColor forState:UIControlStateNormal];
    rightBtn.tag=k_sureBtn_tag;
    [rightBtn addTarget:self action:@selector(barItmesClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    
    [_toolBar setItems:@[leftItem,spaceItem,rightItem] animated:YES];
}


-(void)barItmesClick:(UIButton *)item
{
    if ([[self superview]isKindOfClass:[ZYAlertView class]]) {
        ZYAlertView * alerView =(ZYAlertView *)[self superview];
        [alerView dismissAnimated:YES];
    }
    if (item.tag==k_cancle_tag) {
        
    }else{
        NSString *title = @"";
        NSInteger index = 0;
        if ([self.titleArr[self.selectIndex] isKindOfClass: [NSString class]]) {
            title = self.titleArr[self.selectIndex];
            index = self.selectIndex;
        }
        if (self.delegate && [self.delegate respondsToSelector:@selector(pickerView:didSelectTitle:atIndex:)]) {
            [self.delegate pickerView:self didSelectTitle:title atIndex:index];
        }
        if (self.selectBlock) {
            self.selectBlock(title, index);
        }
    }
    
    
}


-(void)setTitleArr:(NSArray *)titleArr{
    _titleArr = titleArr;
    [self.pickerView reloadAllComponents];
}

#pragma mark - UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.titleArr.count;
}
#pragma mark - UIPickerViewDelegate

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if ([self.titleArr[row] isKindOfClass:[NSString class]]) {
        return self.titleArr[row];
    }
    return nil;
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.selectIndex = row;
}

-(UIView*)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        // Setup label properties - frame, font, colors etc
        //adjustsFontSizeToFitWidth property to YES
//        pickerLabel.adjustsFontSizeToFitWidth = YES;
        [pickerLabel setTextAlignment:NSTextAlignmentCenter];
        pickerLabel.numberOfLines = 0;
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        [pickerLabel setFont:[UIFont boldSystemFontOfSize:16]];
    }
    // Fill the label text here
    pickerLabel.text=[self pickerView:pickerView titleForRow:row forComponent:component];
    return pickerLabel;
}

-(void)show{
    
    ZYAlertView * alertView = [[ZYAlertView alloc]init];
    alertView.containerView = self;
    alertView.transitionStyle=ZYAlertViewTransitionStyleSlideFromBottom;
    [alertView show];
}

#pragma mark - 懒加载
-(UIPickerView *)pickerView{
    if (!_pickerView) {
        _pickerView =[[UIPickerView alloc]initWithFrame:CGRectZero];
        _pickerView.delegate=self;
        _pickerView.backgroundColor=[UIColor whiteColor];
        _pickerView.backgroundColor = [UIColor colorWithRed:239/255.f
                                                          green:239/255.f
                                                           blue:244.0/255.f
                                                          alpha:1.0];
    }
    return _pickerView;
}

-(UIToolbar *)toolBar{
    if (!_toolBar) {
        _toolBar=[[UIToolbar alloc]initWithFrame:CGRectZero];
        _toolBar.backgroundColor=[UIColor whiteColor];
    }
    return _toolBar;
}

-(void)dealloc{
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
