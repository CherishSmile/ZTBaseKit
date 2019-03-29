//
//  ZTDatePicker.m
//  ZTCarOwner
//
//  Created by ZWL on 2017/8/24.
//  Copyright © 2017年 CITCC4. All rights reserved.
//

#import "ZTDatePicker.h"
#import "ZTAlertController.h"
#import "ZTAnimationManager.h"
#import "ZTBaseDefines.h"
#import "ZTBaseFunction.h"


@interface ZTDatePicker ()

@property(nonatomic, strong) UIDatePicker * datePicker;
@property(nonatomic, strong) UIToolbar * toolBar;

@property(nonatomic, strong) NSArray<ZTAlertAction *> * actions;

@end

@implementation ZTDatePicker


- (instancetype)initWithActions:(NSArray<ZTAlertAction *> *)actions{
    if (self = [super init]) {
        self.actions = actions;
        [self creatDatePicker];
    }
    return self;
}
-(void)creatDatePicker{
    self.frame = UIScreen.mainScreen.bounds;
    
    self.datePicker =[[UIDatePicker alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(self.frame)-216, CGRectGetWidth(self.frame), 216)];

    self.datePicker.backgroundColor = [UIColor colorWithRed:239/255.f
                                                         green:239/255.f
                                                          blue:244.0/255.f
                                                         alpha:1.0];
//    self.datePicker.maximumDate = [NSDate date];
    [self addSubview:self.datePicker];

    self.toolBar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(self.frame)-216-49, CGRectGetWidth(self.frame), 49)];
    self.toolBar.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.toolBar];
    [self setbarItmes];
}

-(void)setDatePickerMode:(UIDatePickerMode)datePickerMode{
    _datePickerMode = datePickerMode;
    self.datePicker.datePickerMode = datePickerMode;
}

-(void)setMinimumDate:(NSDate *)minimumDate{
    _minimumDate = minimumDate;
    self.datePicker.minimumDate = minimumDate;
}
-(void)setMaximumDate:(NSDate *)maximumDate{
    _maximumDate = maximumDate;
    self.datePicker.maximumDate = maximumDate;
}

-(void)setbarItmes
{
    NSMutableArray * items = [NSMutableArray array];
    [self.actions enumerateObjectsUsingBlock:^(ZTAlertAction * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx<2) {
            [items addObject:[self addActionItem:obj]];
        }
    }];
    [_toolBar setItems:items animated:YES];
}

-(UIBarButtonItem *)addActionItem:(ZTAlertAction *)action{
    action.bounds = CGRectMake(0, 0, 60, 25);
    action.titleLabel.font = GetFont(F5);
    [action setTitleColor:ZTTextPaleGrayColor forState:UIControlStateNormal];
    UIBarButtonItem *actionItem = [[UIBarButtonItem alloc] initWithCustomView:action];
    return actionItem;
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


-(NSDate *)selectedDate{
    return self.datePicker.date;
}

@end
