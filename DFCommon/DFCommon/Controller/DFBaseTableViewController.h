//
//  HCBaseTableViewController.h
//  Heacha
//
//  Created by Allen Zhong on 15/1/12.
//  Copyright (c) 2015年 Datafans Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DFBaseViewController.h"

#import "DFBaseTableView.h"

@interface DFBaseTableViewController : DFBaseViewController<UITableViewDataSource,UITableViewDelegate,DFTableViewRefreshControlDelegate>

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,assign) UITableViewStyle style;

@property (nonatomic,assign) DFTableViewRefreshControlType refreshControlType;

@property (nonatomic,assign) BOOL bAddHeader;
@property (nonatomic,assign) BOOL bAddFooter;
@property (nonatomic,assign) BOOL bAutoRefresh;
@property (nonatomic,assign) BOOL bAutoLoadMore;

@property (nonatomic,strong) UIColor *tableBackgroudColor;

@property (nonatomic,assign) NSInteger topOffset;
@property (nonatomic,assign) NSInteger bottomOffset;

-(void) endRefresh;
-(void) endLoadMore;

-(void) loadOver;


@end
