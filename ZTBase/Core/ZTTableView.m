//
//  ZTTableView.m
//  ZTCloudMirror
//
//  Created by ZWL on 2017/9/15.
//  Copyright © 2017年 中通四局. All rights reserved.
//

#import "ZTTableView.h"
#import "ZTPublicMethod.h"
#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>

@interface ZTTableView ()<DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>

@end

@implementation ZTTableView

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    if (self = [super initWithFrame:frame style:style]) {

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
                MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
                    [self.mj_footer resetNoMoreData];
                    headerBlock();
                }];
                self.mj_header = header;
            }
        }
            break;
        case ZTRefreshStyleAll:
        {
            if (headerBlock) {
                MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
                    [self.mj_footer resetNoMoreData];
                    headerBlock();
                }];
                self.mj_header = header;
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
    if ([delegate conformsToProtocol:@protocol(ZTTableViewDelegte)]) {
        if ([delegate respondsToSelector:@selector(titleForEmptyDataSetOnTableView:)]) {
            title = [delegate titleForEmptyDataSetOnTableView:self];
        }
    }
    if (self.requestResult==ZTRequestResultSuccess) {
        defaultTitle = @"暂无数据";
        title = title&&title.length?title:[[NSAttributedString alloc] initWithString:defaultTitle attributes:@{NSFontAttributeName:GetFont(16)}];
    }else{
        defaultTitle = @"网络或服务器异常，请稍后重试";
        title = [[NSAttributedString alloc] initWithString:defaultTitle attributes:@{NSFontAttributeName:GetFont(16)}];

    }
    return title;
}

/**
 * 返回图片
 */
-(UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView{
    
    UIImage *emptyImage = nil;
    
    id delegate = self.delegate;
    if ([delegate conformsToProtocol:@protocol(ZTTableViewDelegte)]) {
        if ([delegate respondsToSelector:@selector(imageForEmptyDataSetOnTableView:)]) {
            emptyImage = [delegate imageForEmptyDataSetOnTableView:self];
        }
    }
    if (self.requestResult==ZTRequestResultSuccess) {
        emptyImage = emptyImage?:imageNamed(@"placeholder_emptydata");
    }else{
        emptyImage = imageNamed(@"placeholder_neterror");
    }
    return emptyImage;
}

#pragma mark - DZNEmptyDataSetSource
/**
 * 空数据是否显示
 */
-(BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView{
    if (self.requestResult == ZTRequestResultNone) {
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
    if ([delegate conformsToProtocol:@protocol(ZTTableViewDelegte)]) {
        if ([delegate respondsToSelector:@selector(tableView:didTapEmptyDataView:)]) {
            [delegate tableView:self didTapEmptyDataView:view];
        }
    }
}
-(CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView{
    return CGRectGetHeight(self.tableHeaderView.frame)/2-40;
}

@end


UITableView * initTabView(id instanceObject,UITableViewStyle style)
{
    ZTTableView *  tableView = [[ZTTableView alloc]initWithFrame:CGRectZero style:style];
    tableView.backgroundColor = ZTBackColor;
    tableView.separatorColor = ZTSeparatorColor;
    tableView.delegate = instanceObject;
    tableView.dataSource = instanceObject;
    tableView.estimatedRowHeight = 0;
    tableView.estimatedSectionFooterHeight = 0;
    tableView.estimatedSectionHeaderHeight = 0;
    return tableView;
}
