//
//  DFLogoRefreshControl.m
//  DFCommon
//
//  Created by Allen Zhong on 16/2/22.
//  Copyright © 2016年 Datafans, Inc. All rights reserved.
//

#import "DFLogoRefreshControl.h"

@implementation DFLogoRefreshControl

-(void) addHeader
{
    
    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(startRefresh)];
    header.lastUpdatedTimeLabel.hidden = YES;
    header.stateLabel.hidden = YES;
    UIImage *image = [UIImage imageNamed:@"success"];
    UIImage *errorimage = [UIImage imageNamed:@"fail"];
    UIImage *refreshimage = [UIImage imageNamed:@"refresh"];
    [header setImages:@[image] forState:MJRefreshStateIdle];
    [header setImages:@[errorimage] forState:MJRefreshStatePulling];
    [header setImages:@[refreshimage] forState:MJRefreshStateRefreshing];
    
    
    self.tableView.mj_header = header;
}


-(void) addFooter
{
    
    MJRefreshBackGifFooter *footer = [MJRefreshBackGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(startLoadMore)];
    footer.stateLabel.hidden = YES;
    
    UIImage *image = [UIImage imageNamed:@"success"];
    UIImage *errorimage = [UIImage imageNamed:@"fail"];
    UIImage *refreshimage = [UIImage imageNamed:@"refresh"];
    [footer setImages:@[image] forState:MJRefreshStateIdle];
    [footer setImages:@[errorimage] forState:MJRefreshStatePulling];
    [footer setImages:@[refreshimage] forState:MJRefreshStateRefreshing];
    
    
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
    [self.tableView.mj_footer endRefreshing];
    
}


-(void) loadOver
{
    [self.tableView.mj_footer endRefreshingWithNoMoreData];
    
}


@end
