//
//  DFTableViewMJRefreshPlainControl.m
//  DFCommon
//
//  Created by Allen Zhong on 16/2/22.
//  Copyright © 2016年 Datafans, Inc. All rights reserved.
//

#import "DFTableViewMJRefreshPlainControl.h"

@implementation DFTableViewMJRefreshPlainControl

-(void) addHeader
{
    
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(startRefresh)];
    // 隐藏时间
    header.lastUpdatedTimeLabel.hidden = YES;
    // 隐藏状态
    header.stateLabel.hidden = YES;
    self.tableView.mj_header = header;
}


-(void) addFooter
{
    
    MJRefreshBackNormalFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(startLoadMore)];
    //隐藏文字
    footer.stateLabel.hidden = YES;
    self.tableView.mj_footer = footer;
}
@end
