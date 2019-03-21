//
//  ZTCollectionView.m
//  DMNicePerson
//
//  Created by ZWL on 2017/10/18.
//  Copyright © 2017年 ZWL. All rights reserved.
//

#import "ZTCollectionView.h"
#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>


@interface ZTCollectionView ()<DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>


@end

@implementation ZTCollectionView

-(instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout{
    if (self = [super initWithFrame:frame collectionViewLayout:layout]) {
    }
    return self;
}

#pragma mark - public method

-(void)setRefreshType:(ZTRefreshStyle)type headerBlock:(MJRefreshComponentRefreshingBlock)headerBlock footerBlock:(MJRefreshComponentRefreshingBlock)footerBlock{
    switch (type) {
        case ZTRefreshStyleFooter:
        {
            if (footerBlock) {
                self.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
                    footerBlock();
                }];
            }
        }
            break;
        case ZTRefreshStyleHeader:
        {
            if (headerBlock) {
                self.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
                    [self.mj_footer resetNoMoreData];
                    headerBlock();
                }];
            }
        }
            break;
        case ZTRefreshStyleAll:
        {
            if (headerBlock) {
                self.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
                    [self.mj_footer resetNoMoreData];
                    headerBlock();
                }];
            }
            if (footerBlock) {
                self.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
                    footerBlock();
                }];
            }
        }
        default:
            break;
    }
}

-(void)stopRefrsh:(ZTRefreshStyle)type{
    switch (type) {
        case ZTRefreshStyleHeader:
        {
            if (self.mj_header) {
                [self.mj_header endRefreshing];
            }
        }
            break;
        case ZTRefreshStyleFooter:
        {
            if (self.mj_footer) {
                [self.mj_footer endRefreshing];
            }
        }
            break;
        case ZTRefreshStyleAll:
        {
            if (self.mj_header) {
                [self.mj_header endRefreshing];
            }
            if (self.mj_footer) {
                [self.mj_footer endRefreshing];
            }
        }
            break;
        default:
            break;
    }
}

-(void)setEmptyData{
    self.emptyDataSetSource = self;
    self.emptyDataSetDelegate = self;
}
-(void)setRequestResult:(ZTRequestResult)requestResult{
    _requestResult = requestResult;
}

-(void)resetTabContentInset{
    if (self.mj_header&&self.mj_header.state == MJRefreshStateIdle ) {
        self.contentInset = UIEdgeInsetsZero;
    }
}

#pragma mark - DZNEmptyDataSetSource,DZNEmptyDataSetDelegate
/**
 * 返回标题文字
 */
-(NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView{
    
    NSAttributedString *title = nil;
    NSString *defaultTitle = nil;
    id delegate = self.delegate;
    if ([delegate conformsToProtocol:@protocol(ZTCollectionViewDelegte)]) {
        if ([delegate respondsToSelector:@selector(titleForEmptyDataSetOnCollectionView:)]) {
            title = [delegate titleForEmptyDataSetOnCollectionView:self];
        }
    }
    if (self.requestResult==ZTRequestResultSuccess) {
        defaultTitle = @"暂无数据";
    }else{
        defaultTitle = @"网络或服务器异常，请稍后重试";
    }
    title = title&&title.length?title:[[NSAttributedString alloc] initWithString:defaultTitle attributes:@{NSFontAttributeName:GetFont(16)}];
    return title;
    
}

/**
 * 返回图片
 */
-(UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView{
    
    UIImage *emptyImage = nil;
    
    id delegate = self.delegate;
    if ([delegate conformsToProtocol:@protocol(ZTCollectionViewDelegte)]) {
        if ([delegate respondsToSelector:@selector(imageForEmptyDataSetOnCollectionView:)]) {
            emptyImage = [delegate imageForEmptyDataSetOnCollectionView:self];
        }
    }
    if (self.requestResult==ZTRequestResultSuccess) {
        emptyImage = emptyImage?:GetImg(@"placeholder_dropbox");
    }else{
        emptyImage = emptyImage?:GetImg(@"placeholder_remote");
    }
    return emptyImage;
}

#pragma mark - DZNEmptyDataSetSource
/**
 * 空数据是否显示
 */
-(BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView{
    if (self.requestResult == ZTRefreshStyleNone) {
        return NO;
    }
    return YES;
}
/**
 * 是否允许滚动
 */
- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView{
    return YES;
}
/**
 * 点击view事件处理
 */
-(void)emptyDataSet:(UIScrollView *)scrollView didTapView:(UIView *)view{
    id delegate = self.delegate;
    if ([delegate conformsToProtocol:@protocol(ZTCollectionViewDelegte)]) {
        if ([delegate respondsToSelector:@selector(collectionView:didTapEmptyDataView:)]) {
            [delegate collectionView:self didTapEmptyDataView:view];
        }
    }
}

-(CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView{
    return -40;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
