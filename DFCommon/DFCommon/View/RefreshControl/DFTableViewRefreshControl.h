//
//  DFTableViewRefreshPerformer.h
//  Heacha
//
//  Created by Allen Zhong on 15/2/13.
//  Copyright (c) 2015年 Datafans Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol DFTableViewRefreshControlDelegate <NSObject>

-(void) startRefresh:(UITableView *) tableView;
-(void) startLoadMore:(UITableView *) tableView;

@end


@interface DFTableViewRefreshControl : NSObject

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,assign) id<DFTableViewRefreshControlDelegate> delegate;

@property (nonatomic, assign) BOOL bLoadOver;

-(void) addHeader;
-(void) addFooter;


-(void) startRefresh;
-(void) startLoadMore;

-(void) autoRefresh;

-(void) endRefresh;
-(void) endLoadMore;

-(void) loadOver;


- (instancetype)initWithTarget:(id)delegate tableView:(UITableView *) tableView;

@end
