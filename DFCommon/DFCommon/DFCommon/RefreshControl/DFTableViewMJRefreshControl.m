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
    [self.tableView addHeaderWithTarget:self action:@selector(startRefresh)];
}


-(void) addFooter
{
    [self.tableView addFooterWithTarget:self action:@selector(startLoadMore)];
}

-(void) autoRefresh
{
    [self.tableView headerBeginRefreshing];
}


-(void) endRefresh
{
    [self.tableView headerEndRefreshing];
}
-(void) endLoadMore
{
    [self.tableView footerEndRefreshing];
}


-(void) loadOver
{
    
}

@end
