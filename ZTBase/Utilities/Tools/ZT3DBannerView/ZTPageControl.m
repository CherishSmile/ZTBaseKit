//
//  ZTPageControl.m
//  
//
//  Created by ZWL on 2018/11/7.
//  Copyright © 2018 CITCC4. All rights reserved.
//

#import "ZTPageControl.h"


@implementation ZTPageControl
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initialize];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    [self createPointView];
}

-(void)initialize{
    self.backgroundColor=[UIColor clearColor];
    _pageControlContentMode = ZTPageControlContentModeCenter;
    _marginSpacing = 12;
    _numberOfPages=0;
    _currentPage=0;
    _controlSize = CGSizeMake(5, 5);
    _controlSpacing = 3;
    _pageIndicatorTintColor=[UIColor lightGrayColor];
    _currentPageIndicatorTintColor=[UIColor orangeColor];
}

-(void)setPageIndicatorTintColor:(UIColor *)pageIndicatorTintColor{
    if(![self isTheSameColor:pageIndicatorTintColor andotherColor:_pageIndicatorTintColor]){
        _pageIndicatorTintColor = pageIndicatorTintColor;
        [self createPointView];
    }
}

-(void)setCurrentPageIndicatorTintColor:(UIColor *)currentPageIndicatorTintColor{
    if(![self isTheSameColor:currentPageIndicatorTintColor andotherColor:_currentPageIndicatorTintColor]){
        _currentPageIndicatorTintColor=currentPageIndicatorTintColor;
        [self createPointView];
    }
}

-(void)setControlSize:(CGSize)controlSize{
    if(controlSize.width!=_controlSize.width || controlSize.height!=_controlSize.height){
        _controlSize=controlSize;
        [self createPointView];
    }
}

-(void)setControlSpacing:(CGFloat)controlSpacing{
    if(_controlSpacing!=controlSpacing){
        _controlSpacing=controlSpacing;
        [self createPointView];
        
    }
}

-(void)setCurrentPageIndicatorImage:(UIImage *)currentPageIndicatorImage{
    if(_currentPageIndicatorImage!=currentPageIndicatorImage){
        _currentPageIndicatorImage=currentPageIndicatorImage;
        [self createPointView];
    }
}

-(void)setNumberOfPages:(NSInteger)page{
    if(_numberOfPages==page)
        return;
    _numberOfPages=page;
    [self createPointView];
}

- (void)setPageControlContentMode:(ZTPageControlContentMode)PageControlContentMode {
    if (_pageControlContentMode == PageControlContentMode) return;
    _pageControlContentMode = PageControlContentMode;
    [self createPointView];
}

- (void)setMarginSpacing:(CGFloat)marginSpacing {
    if (_marginSpacing == marginSpacing) return;
    _marginSpacing = marginSpacing;
    [self createPointView];
}

-(void)setCurrentPage:(NSInteger)currentPage{
    
    if([self.delegate respondsToSelector:@selector(pageControl:didClickIndex:)])
    {
        [self.delegate pageControl:self didClickIndex:currentPage];
    }
    
    if(_currentPage==currentPage)
        return;
    
    [self exchangeCurrentView:_currentPage new:currentPage];
    _currentPage=currentPage;
    
    
}

-(void)clearView{
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
}

-(void)setPageControlStyle:(ZTPageControlStyle)PageControlStyle{
    if (_pageControlStyle == PageControlStyle) return;
    _pageControlStyle = PageControlStyle;
    [self createPointView];
}



#pragma mark - 根据样式创建点
-(void)createPointView{
    [self clearView];
    if(_numberOfPages<=0)
        return;
    switch (_pageControlStyle) {
        case ZTPageControlStyelDefault:
        {
            [self creatDotWithSize:_controlSize];
        }
            break;
        case ZTPageControlStyelRectangle:
        {
            [self creatDotWithSize:CGSizeMake(15, 2)];
        }
            break;
        case ZTPageControlStyelDotAndRectangle:
        {
            [self creatDotWithSize:CGSizeMake(15, 4) withOtherDotSize:CGSizeMake(4, 4)];
        }
            break;
        default:
            break;
    }
}

#pragma mark - 默认样式创建点
-(void)creatDotWithSize:(CGSize)dotSize{
    //居中控件
    CGFloat startX=0;
    CGFloat startY=0;
    CGFloat controlSizeW = dotSize.width;
    CGFloat controlSizeH = dotSize.height;
    CGFloat mainWidth=_numberOfPages*(controlSizeW +_controlSpacing);
    
    if(self.frame.size.width<mainWidth){
        startX=0;
    }else{
        if (_pageControlContentMode == ZTPageControlContentModeLeft && self.frame.size.width - _marginSpacing * 2 > mainWidth) {
            startX = _marginSpacing;
        }else if (_pageControlContentMode == ZTPageControlContentModeRight && self.frame.size.width - _marginSpacing * 2 > mainWidth) {
            startX = (self.frame.size.width-mainWidth) - _marginSpacing;
        }else {
            startX = (self.frame.size.width-mainWidth)/2;
        }
    }
    if(self.frame.size.height<controlSizeH){
        startY = 0;
    }else{
        startY = (self.frame.size.height-controlSizeH)/2;
    }
    //动态创建点
    for (int page=0; page<_numberOfPages; page++) {
        if(page==_currentPage){
            UIView *currPointView=[[UIView alloc]initWithFrame:CGRectMake(startX, startY, controlSizeW, controlSizeH)];
            currPointView.layer.cornerRadius=controlSizeH/2;
            currPointView.tag=page+1000;
            currPointView.backgroundColor=_currentPageIndicatorTintColor;
            currPointView.userInteractionEnabled=YES;
            UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickAction:)];
            [currPointView addGestureRecognizer:tapGesture];
            [self addSubview:currPointView];
            startX=CGRectGetMaxX(currPointView.frame)+_controlSpacing;
            if(_currentPageIndicatorImage){
                currPointView.backgroundColor=[UIColor clearColor];
                UIImageView *currBkImg=[UIImageView new];
                currBkImg.tag=1234;
                currBkImg.frame=CGRectMake(0, 0, currPointView.frame.size.width, currPointView.frame.size.height);
                currBkImg.image=_currentPageIndicatorImage;
                [currPointView addSubview:currBkImg];
            }
            
        }else{
            
            UIView *otherPointView=[[UIView alloc]initWithFrame:CGRectMake(startX, startY, controlSizeW, controlSizeH)];
            otherPointView.backgroundColor=_pageIndicatorTintColor;
            otherPointView.tag=page+1000;
            otherPointView.layer.cornerRadius=controlSizeH/2;
            otherPointView.userInteractionEnabled=YES;
            
            UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickAction:)];
            [otherPointView addGestureRecognizer:tapGesture];
            [self addSubview:otherPointView];
            startX=CGRectGetMaxX(otherPointView.frame)+_controlSpacing;
        }
    }
}
#pragma mark - 创建  圆点 + 长条形 样式
-(void)creatDotWithSize:(CGSize)currentDotSize withOtherDotSize:(CGSize)otherDotSize{
    
    //居中控件
    CGFloat startX=0;
    CGFloat startY=0;
    CGFloat currentDotSizeW = currentDotSize.width;
    CGFloat currentDotSizeH = currentDotSize.height;
    CGFloat otherDotSizeW = otherDotSize.width;
    CGFloat otherDotSizeH = otherDotSize.height;
    
    CGFloat mainWidth=_numberOfPages*(currentDotSizeW +_controlSpacing);
    
    if(self.frame.size.width<mainWidth){
        startX=0;
    }else{
        if (_pageControlContentMode == ZTPageControlContentModeLeft && self.frame.size.width - _marginSpacing * 2 > mainWidth) {
            startX = _marginSpacing;
        }else if (_pageControlContentMode == ZTPageControlContentModeRight && self.frame.size.width - _marginSpacing * 2 > mainWidth) {
            startX = (self.frame.size.width-mainWidth) - _marginSpacing;
        }else {
            startX = (self.frame.size.width-mainWidth)/2;
        }
    }
    if(self.frame.size.height<otherDotSizeH){
        startY = 0;
    }else{
        startY = (self.frame.size.height-otherDotSizeH)/2;
        
    }
    //动态创建点
    for (int page=0; page<_numberOfPages; page++) {
        if(page==_currentPage){
            UIView *currPointView=[[UIView alloc]initWithFrame:CGRectMake(startX, startY, currentDotSizeW, currentDotSizeH)];
            currPointView.layer.cornerRadius=currentDotSizeH/2;
            currPointView.tag=page+1000;
            currPointView.backgroundColor=_currentPageIndicatorTintColor;
            currPointView.userInteractionEnabled=YES;
            UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickAction:)];
            [currPointView addGestureRecognizer:tapGesture];
            [self addSubview:currPointView];
            startX=CGRectGetMaxX(currPointView.frame)+_controlSpacing;
            if(_currentPageIndicatorImage){
                currPointView.backgroundColor=[UIColor clearColor];
                UIImageView *currBkImg=[UIImageView new];
                currBkImg.tag=1234;
                currBkImg.frame=CGRectMake(0, 0, currPointView.frame.size.width, currPointView.frame.size.height);
                currBkImg.image=_currentPageIndicatorImage;
                [currPointView addSubview:currBkImg];
            }
        }else{
            UIView *otherPointView=[[UIView alloc]initWithFrame:CGRectMake(startX, startY, otherDotSizeW, otherDotSizeH)];
            otherPointView.backgroundColor=_pageIndicatorTintColor;
            otherPointView.tag=page+1000;
            otherPointView.layer.cornerRadius=otherDotSizeH/2;
            otherPointView.userInteractionEnabled=YES;
            
            UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickAction:)];
            [otherPointView addGestureRecognizer:tapGesture];
            [self addSubview:otherPointView];
            startX=CGRectGetMaxX(otherPointView.frame)+_controlSpacing;
        }
    }
}

-(void)clickAction:(UITapGestureRecognizer*)recognizer{
    NSInteger index=recognizer.view.tag-1000;
    [self setCurrentPage:index];
}

-(BOOL)isTheSameColor:(UIColor*)color1 andotherColor:(UIColor*)color2{
    return  CGColorEqualToColor(color1.CGColor, color2.CGColor);
}

//切换当前的点
-(void)exchangeCurrentView:(NSInteger)old new:(NSInteger)new
{
    UIView *oldSelect=[self viewWithTag:1000+old];
    CGRect mpSelect=oldSelect.frame;
    
    UIView *newSeltect=[self viewWithTag:1000+new];
    CGRect newTemp=newSeltect.frame;
    
    if(_currentPageIndicatorImage){
        UIView *imgview=[oldSelect viewWithTag:1234];
        [imgview removeFromSuperview];
        
        newSeltect.backgroundColor=[UIColor clearColor];
        UIImageView *currBkImg=[UIImageView new];
        currBkImg.tag=1234;
        currBkImg.frame=CGRectMake(0, 0, mpSelect.size.width, mpSelect.size.height);
        currBkImg.image=_currentPageIndicatorImage;
        [newSeltect addSubview:currBkImg];
    }
    
    oldSelect.backgroundColor=_pageIndicatorTintColor;
    newSeltect.backgroundColor=_currentPageIndicatorTintColor;
    
    [UIView animateWithDuration:0.3 animations:^{
        
        
        CGFloat lx=mpSelect.origin.x;
        CGFloat pageW = self.controlSize.width;
        CGFloat pageH = self.controlSize.height;
        
        if(new<old)
            lx+=pageW;
        oldSelect.frame=CGRectMake(lx, mpSelect.origin.y, pageW, pageH);
        
        CGFloat mx=newTemp.origin.x;
        if(new>old)
            mx-=pageW;
        newSeltect.frame=CGRectMake(mx, newTemp.origin.y, pageW*2, pageH);
        
        // 左边的时候到右边 越过点击
        if(new-old>1)
        {
            for(NSInteger t=old+1;t<new;t++)
            {
                UIView *ms=[self viewWithTag:1000+t];
                ms.frame=CGRectMake(ms.frame.origin.x-pageW, ms.frame.origin.y, pageW, pageH);
            }
        }
        // 右边选中到左边的时候 越过点击
        if(new-old<-1)
        {
            for(NSInteger t=new+1;t<old;t++)
            {
                UIView *ms=[self viewWithTag:1000+t];
                ms.frame=CGRectMake(ms.frame.origin.x+pageW, ms.frame.origin.y, pageW, pageH);
            }
        }
    }];
    
}
@end
