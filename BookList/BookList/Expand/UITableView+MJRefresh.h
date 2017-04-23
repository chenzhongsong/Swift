//
//  UITableView+MJRefresh.h
//  BookList
//
//  Created by chenzs on 16/4/2.
//  Copyright © 2016年 chenzhongsong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJRefresh/MJRefresh.h"


@interface UITableView (MJRefresh)

//添加顶部刷新
- (void)headerAddMJRefresh:(MJRefreshComponentRefreshingBlock)block;

//手动顶部刷新
- (void)headerBeginRefresh;

//取消顶部刷新状态
-(void)headerEndRefresh;

//添加底部刷新
-(void)footerAddRefresh:(MJRefreshComponentRefreshingBlock)block;

//手动刷新底部
- (void)footerBeginRefresh;

//取消底部刷新状态
- (void)footerEndRefresh;

//取消底部刷新状态并显示没有更多数据
- (void)footerEndRefreshNoMoreData;

//重置无数据状态
- (void)footerResetNoMoreData;



@end
