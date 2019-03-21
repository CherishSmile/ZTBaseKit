//
//  ZTSelectPicker.h
//  ZTCarOwner
//
//  Created by ZWL on 2017/8/11.
//  Copyright © 2017年 CITCC4. All rights reserved.
//

#import <UIKit/UIKit.h>


@class ZTSelectPicker;

@protocol ZTSelectPickerDelegate <NSObject>
-(void)pickerView:(ZTSelectPicker *)pickerView didSelectTitle:(NSString*)title atIndex:(NSInteger)index;
@end

typedef void(^ZTSelectTitleBlock)(NSString *title,NSInteger index);
@interface ZTSelectPicker : UIView
@property(nonatomic,strong)NSArray *titleArr;
@property(nonatomic,weak)id<ZTSelectPickerDelegate>delegate;
@property(nonatomic,copy)ZTSelectTitleBlock selectBlock;
-(instancetype)initWithTitles:(NSArray*)titles;
-(void)show;
@end
