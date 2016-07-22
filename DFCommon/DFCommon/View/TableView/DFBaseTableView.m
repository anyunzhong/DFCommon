//
//  DFBaseTableView.m
//  DFCommon
//
//  Created by Allen Zhong on 16/7/22.
//  Copyright © 2016年 Datafans, Inc. All rights reserved.
//

#import "DFBaseTableView.h"

#import "MBProgressHUD.h"

#import "DFNetwork.h"
#import "DFDevice.h"
#import "DFView.h"


@interface DFBaseTableView()

@property (nonatomic,assign) UITableViewStyle style;

@property (nonatomic,assign) DFTableViewRefreshControlType refreshControlType;
@property (nonatomic,strong) DFTableViewRefreshControl *refreshControl;

@property (nonatomic,strong) NSMutableDictionary *refreshControlDic;

@property (nonatomic,assign) BOOL bAddHeader;
@property (nonatomic,assign) BOOL bAddFooter;

@property (nonatomic,assign) BOOL bAutoLoadMore;
@property (nonatomic,strong) UIColor *tableBackgroudColor;

@property (nonatomic,assign) NSInteger topOffset;
@property (nonatomic,assign) NSInteger bottomOffset;

@end



@implementation DFBaseTableView


- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle) style refreshControlType:(DFTableViewRefreshControlType) refreshControlType bAddHeader:(BOOL) bAddHeader bAddFooter:(BOOL) bAddFooter bAutoLoadMore:(BOOL) bAutoLoadMore
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.style = style;
        self.refreshControlType = refreshControlType;
        self.bAddHeader = bAddHeader;
        self.bAddFooter = bAddFooter;
        self.bAutoLoadMore = bAutoLoadMore;
        self.topOffset = 0;
        self.bottomOffset = 0;
        
        
        [self initView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle) style refreshControlType:(DFTableViewRefreshControlType) refreshControlType bAddHeader:(BOOL) bAddHeader bAddFooter:(BOOL) bAddFooter bAutoLoadMore:(BOOL) bAutoLoadMore tableBackgroudColor:(UIColor *) tableBackgroudColor topOffset:(NSInteger)topOffset bottomOffset:(NSInteger) bottomOffset
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.style = style;
        self.refreshControlType = refreshControlType;
        self.bAddHeader = bAddHeader;
        self.bAddFooter = bAddFooter;
        self.bAutoLoadMore = bAutoLoadMore;
        self.tableBackgroudColor = tableBackgroudColor;
        self.topOffset = topOffset;
        self.bottomOffset = bottomOffset;
        
        [self initView];
    }
    return self;
}



-(void) initView
{
    
    _refreshControlDic = [NSMutableDictionary dictionary];
    
    [_refreshControlDic setObject:[DFTableViewNativeRefreshControl class] forKey:[NSNumber numberWithInteger:DFTableViewRefreshControlTypeNative]];
    [_refreshControlDic setObject:[DFTableViewMJRefreshControl class] forKey:[NSNumber numberWithInteger:DFTableViewRefreshControlTypeMJ]];
    [_refreshControlDic setObject:[DFTableViewMJRefreshPlainControl class] forKey:[NSNumber numberWithInteger:DFTableViewRefreshControlTypeMJPlain]];
    [_refreshControlDic setObject:[DFTableViewODRefreshControl class] forKey:[NSNumber numberWithInteger:DFTableViewRefreshControlTypeOD]];
    
    
    _tableView = [[UITableView alloc] initWithFrame:self.bounds style:_style];
    if (_tableBackgroudColor) {
        _tableView.backgroundColor = _tableBackgroudColor;
    }
    
    _tableView.contentInset = UIEdgeInsetsMake(_topOffset, 0.0, _bottomOffset, 0.0);
    _tableView.scrollIndicatorInsets=UIEdgeInsetsMake(_topOffset, 0.0, _bottomOffset, 0.0);
    

    [self addSubview:_tableView];
    
    //顶部刷新 底部加载更多
    [self initRefreshControl];

}


-(void) setDataSource:(id<UITableViewDataSource>)dataSource
{
    _tableView.dataSource = dataSource;
}


-(void) setDelegate:(id<UITableViewDelegate>)delegate
{
    _tableView.delegate = delegate;
}


-(void)setRefreshControlDelegate:(id<DFTableViewRefreshControlDelegate>)refreshControlDelegate
{
    _refreshControl.delegate = refreshControlDelegate;
}


-(void) initRefreshControl
{
    if (_refreshControl == nil && ( _bAddFooter || _bAddHeader)) {
        _refreshControl = [self getRefreshControl: self.refreshControlType];
    }
    
    if (self.refreshControlType == DFTableViewRefreshControlTypeOD) {
        ((DFTableViewODRefreshControl *)_refreshControl).topOffset = self.topOffset+64;
    }
    _refreshControl.tableView = _tableView;
    
    
    if (_bAddHeader) {
        
        [_refreshControl addHeader];
        
    }
    
    if (_bAddFooter) {
        [_refreshControl addFooter];
    }
    
}


-(DFTableViewRefreshControl *) getRefreshControl:(DFTableViewRefreshControlType) type
{
    Class clazz = [_refreshControlDic objectForKey:[NSNumber numberWithInteger:type]];
    
    DFTableViewRefreshControl  *control = (DFTableViewRefreshControl *)[[clazz alloc] init];
    
    return control;
}




#pragma mark - Method

-(void) autoRefresh
{
    [_refreshControl autoRefresh];
    
}



-(void) endRefresh
{
    [_refreshControl endRefresh];
}



-(void) endLoadMore
{
    [_refreshControl endLoadMore];
}


-(void) loadOver
{
    [_refreshControl loadOver];
    
}




#pragma - mark DFDataServiceDelegate


-(void)onRequestError:(NSError *)error dataService:(DFBaseDataService *)dataService
{
    if (error.code == CustomErrorConnectFailed || error.code == -1005) {
        [self hudShowText:@"网络无法连接"];
    }
    
    if (error.code == -1001) {
        [self hudShowText:@"网络超时"];
    }
    
    [self onEnd:NO];
    
//    if ([self enableAutoLoadStateView]) {
//        [self hideLoadingView];
//        [self showLoadFailView];
//    }
    
    
    NSLog(@"%@",error);
}

-(void)onStatusError:(DFBaseResponse *)response dataService:(DFBaseDataService *)dataService
{
    if (response.errorCode == 0 || response.errorMsg == nil) {
        [self hudShowText:@"未知错误, 请联系客服"];
    }else{
        NSLog(@"CODER-ERROR: %@",[NSString stringWithFormat:@"%ld:%@",(long)response.errorCode,response.errorMsg]);
        [self hudShowText:[NSString stringWithFormat:@"%@",response.errorMsg]];
    }
    
    [self onEnd:NO];
    
//    if ([self enableAutoLoadStateView]) {
//        [self hideLoadingView];
//        [self showLoadFailView];
//    }
    
    
}

- (void)onStatusOk:(DFBaseResponse *)response dataService:(DFBaseDataService *)dataService
{
//    if ([self enableAutoLoadStateView]) {
//        [self hideLoadingView];
//        [self hideLoadFailView];
//    }
    
    [self onEnd:YES];
}




-(void) onEnd:(BOOL)reload
{
    if (_bAddHeader) {
        [self endRefresh];
    }
    
    if (_bAddFooter) {
        [self endLoadMore];
    }
    
    if (reload) {
        [self.tableView reloadData];
    }
}



#pragma mark - Method

-(void) hudShowText:(NSString *)text
{
    [self hudShowText:text second:HudDefaultHideTime];
}


-(void) hudShowText:(NSString *)text second:(NSInteger)second
{
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.animationType = MBProgressHUDAnimationFade;
    hud.removeFromSuperViewOnHide = YES;
    hud.labelText = text;
    [hud hide:YES afterDelay:second];
}


-(MBProgressHUD *) hudShowLoading
{
    return [self hudShowLoading:@"加载中..."];
}


-(MBProgressHUD *) hudShowLoading:(NSString *)text
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.animationType = MBProgressHUDAnimationFade;
    hud.removeFromSuperViewOnHide = YES;
    hud.labelText = text;
    hud.square = YES;
    return hud;
}



-(void) hudShowOk:(NSString *) text
{
    NSString *imageName = @"check_success";
    [self hudShowIcon:imageName text:text];
}


-(void) hudShowFail:(NSString *) text
{
    NSString *imageName = @"fail";
    [self hudShowIcon:imageName text:text];
}




-(void) hudShowIcon:(NSString *) imageName text:(NSString *) text
{
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:[UIApplication sharedApplication].keyWindow];
    [[UIApplication sharedApplication].keyWindow addSubview:hud];
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
    hud.mode = MBProgressHUDModeCustomView;
    hud.labelText = text;
    hud.square = YES;
    [hud show:YES];
    [hud hide:YES afterDelay:3];
    
}



@end
