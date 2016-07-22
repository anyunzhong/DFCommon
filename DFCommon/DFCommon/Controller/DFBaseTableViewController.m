//
//  HCBaseTableViewController.m
//  Heacha
//
//  Created by Allen Zhong on 15/1/12.
//  Copyright (c) 2015年 Datafans Inc. All rights reserved.
//

#import "DFBaseTableViewController.h"

@interface DFBaseTableViewController()

@property (nonatomic, strong) DFBaseTableView *baseTableView;

@end



@implementation DFBaseTableViewController

#pragma mark - Lifecycle

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.style = UITableViewStylePlain;
        self.refreshControlType = DFTableViewRefreshControlTypeMJ;
        self.bAddHeader = NO;
        self.bAddFooter = NO;
        
        self.tableBackgroudColor = nil;
        
        self.topOffset=0;
        self.bottomOffset=0;
    }
    return self;
}


-(void)dealloc
{
    
}


-(void)viewDidLoad
{
    [super viewDidLoad];
    
    
    [self initTableView];
    
}


-(void) initTableView
{
    
    _baseTableView = [[DFBaseTableView alloc] initWithFrame:self.view.bounds style:self.style refreshControlType:self.refreshControlType bAddHeader:self.bAddHeader bAddFooter:self.bAddFooter bAutoLoadMore:self.bAutoLoadMore tableBackgroudColor:self.tableBackgroudColor topOffset:self.topOffset bottomOffset:self.bottomOffset];
    _tableView = _baseTableView.tableView;
    
    _baseTableView.dataSource = self;
    _baseTableView.delegate = self;
    _baseTableView.refreshControlDelegate = self;
    
    [self.view addSubview:_baseTableView];
    
}



-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if (_bAutoRefresh) {
        [self autoRefresh];
    }
}


-(void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
}


-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}


#pragma mark - UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    return cell;
    
}

#pragma mark - Method

-(void) autoRefresh
{
    [_baseTableView autoRefresh];
    
}

-(void) startRefresh
{
    
}


-(void) startLoadMore
{
    
}


-(void)startRefresh:(UITableView *)tableView
{
    [self startRefresh];
}

-(void)startLoadMore:(UITableView *)tableView
{
    [self startLoadMore];
}

-(void) endRefresh
{
    [_baseTableView endRefresh];
}

-(void) endLoadMore
{
    [_baseTableView endLoadMore];
}

-(void) loadOver
{
    [_baseTableView loadOver];
}




#pragma - mark DFDataServiceDelegate


-(void)onRequestError:(NSError *)error dataService:(DFBaseDataService *)dataService
{
    [super onRequestError:error dataService:dataService];
    [self onEnd:NO];
}

-(void)onStatusError:(DFBaseResponse *)response dataService:(DFBaseDataService *)dataService
{
    [super onStatusError:response dataService:dataService];
    [self onEnd:NO];
}

- (void)onStatusOk:(DFBaseResponse *)response dataService:(DFBaseDataService *)dataService
{
    [super onStatusOk:response dataService:dataService];
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



@end
