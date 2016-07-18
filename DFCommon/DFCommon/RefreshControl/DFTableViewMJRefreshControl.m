//
//  DFTableViewMJRefreshControl.m
//  Heacha
//
//  Created by Allen Zhong on 15/2/13.
//  Copyright (c) 2015年 Datafans Inc. All rights reserved.
//

#import "DFTableViewMJRefreshControl.h"

@implementation DFTableViewMJRefreshControl

-(void) addHeader
{

    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(startRefresh)];
    
    self.tableView.mj_header = header;
}


-(void) addFooter
{

    MJRefreshBackNormalFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(startLoadMore)];
    self.tableView.mj_footer = footer;
}

-(void) autoRefresh
{

    [self.tableView.mj_header beginRefreshing];
}


-(void) endRefresh
{

    [self.tableView.mj_header endRefreshing];
}
-(void) endLoadMore
{
    if (!self.bLoadOver) {
        [self.tableView.mj_footer endRefreshing];
    }
}


-(void) loadOver
{
    [self.tableView.mj_footer endRefreshingWithNoMoreData];
    self.bLoadOver = YES;
    
}

@end
