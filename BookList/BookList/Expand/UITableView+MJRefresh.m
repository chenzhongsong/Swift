//
//  UITableView+MJRefresh.m
//  BookList
//
//  Created by chenzs on 16/4/2.
//  Copyright © 2016年 chenzhongsong. All rights reserved.
//

#import "UITableView+MJRefresh.h"

@implementation UITableView (MJRefresh)

//添加顶部刷新
- (void)headerAddMJRefresh:(MJRefreshComponentRefreshingBlock)block {
    self.header = [MJRefreshNormalHeader headerWithRefreshingBlock:block];
}

//手动顶部刷新
- (void)headerBeginRefresh {
    [self.header beginRefreshing];
}

//取消顶部刷新状态
-(void)headerEndRefresh {
    [self.header endRefreshing];
}

//添加底部刷新
-(void)footerAddRefresh:(MJRefreshComponentRefreshingBlock)block {
    self.footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:block];
}

//手动刷新底部
- (void)footerBeginRefresh {
    [self.footer beginRefreshing];
}

//取消底部刷新状态
- (void)footerEndRefresh {
    [self.footer endRefreshing];
}

//取消底部刷新状态并显示没有更多数据
- (void)footerEndRefreshNoMoreData {
    [self.footer endRefreshingWithNoMoreData];
}

//重置无数据状态
- (void)footerResetNoMoreData {
    [self.footer resetNoMoreData];
}


@end
