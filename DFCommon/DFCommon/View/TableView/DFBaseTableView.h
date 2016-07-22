//
//  DFBaseTableView.h
//  DFCommon
//
//  Created by Allen Zhong on 16/7/22.
//  Copyright © 2016年 Datafans, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>


#import "DFTableViewNativeRefreshControl.h"
#import "DFTableViewMJRefreshControl.h"
#import "DFTableViewMJRefreshPlainControl.h"
#import "DFTableViewODRefreshControl.h"

#import "DFBaseDataService.h"


typedef NS_ENUM(NSInteger,DFTableViewRefreshControlType)
{
    DFTableViewRefreshControlTypeNative,
    DFTableViewRefreshControlTypeMJ,
    DFTableViewRefreshControlTypeMJPlain,
    DFTableViewRefreshControlTypeOD,
    
};



@interface DFBaseTableView : UIView<DFDataServiceDelegate>

@property (nonatomic, assign) id<UITableViewDataSource> dataSource;
@property (nonatomic, assign) id<UITableViewDelegate> delegate;
@property (nonatomic, assign) id<DFTableViewRefreshControlDelegate> refreshControlDelegate;

@property (nonatomic,strong) UITableView *tableView;



- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle) style refreshControlType:(DFTableViewRefreshControlType) refreshControlType bAddHeader:(BOOL) bAddHeader bAddFooter:(BOOL) bAddFooter bAutoLoadMore:(BOOL) bAutoLoadMore tableBackgroudColor:(UIColor *) tableBackgroudColor topOffset:(NSInteger)topOffset bottomOffset:(NSInteger) bottomOffset;

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle) style refreshControlType:(DFTableViewRefreshControlType) refreshControlType bAddHeader:(BOOL) bAddHeader bAddFooter:(BOOL) bAddFooter bAutoLoadMore:(BOOL) bAutoLoadMore;


-(void) autoRefresh;
-(void) endRefresh;
-(void) endLoadMore;
-(void) loadOver;


@end
