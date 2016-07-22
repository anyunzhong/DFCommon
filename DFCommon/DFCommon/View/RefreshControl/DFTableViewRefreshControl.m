//
//  DFTableViewRefreshPerformer.m
//  Heacha
//
//  Created by Allen Zhong on 15/2/13.
//  Copyright (c) 2015年 Datafans Inc. All rights reserved.
//

#import "DFTableViewRefreshControl.h"

@implementation DFTableViewRefreshControl


- (instancetype)initWithTarget:(id)delegate tableView:(UITableView *) tableView
{
    self = [super init];
    if (self) {
        
        self.delegate = delegate;
        self.tableView = tableView;
        self.bLoadOver = NO;
    }
    return self;
}

-(void) addHeader
{
    
}


-(void) addFooter
{
    
}

-(void) startRefresh
{
    [_delegate startRefresh:self.tableView];
    self.bLoadOver = NO;
}


-(void) startLoadMore
{
    [_delegate startLoadMore:self.tableView];
}



-(void) autoRefresh
{
}


-(void) endRefresh
{

}
-(void) endLoadMore
{
}


-(void) loadOver
{
    
}


@end
