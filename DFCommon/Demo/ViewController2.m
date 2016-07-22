//
//  ViewController2.m
//  DFCommon
//
//  Created by Allen Zhong on 16/7/22.
//  Copyright © 2016年 Datafans, Inc. All rights reserved.
//

#import "ViewController2.h"

#import "DFBaseTableView.h"

#import "DemoHttpService.h"

#import "DFTabIndicatorView.h"

@interface ViewController2 ()<UITableViewDelegate, UITableViewDataSource, DFTableViewRefreshControlDelegate>

@property (nonatomic, strong) DemoHttpService *service;

@property (nonatomic, strong) DemoHttpService *service2;




@property (nonatomic, strong) DFBaseTableView *tableView;

@property (nonatomic, strong) DFBaseTableView *tableView2;

@end

@implementation ViewController2

- (instancetype)init
{
    self = [super init];
    if (self) {
        _service = [DemoHttpService new];
        _service2 = [DemoHttpService new];
        
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    DFTabIndicatorView *indicator = [[DFTabIndicatorView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 40)];
    indicator.titles = @[@"头条",@"体育"];
    indicator.titleColor = [UIColor darkGrayColor];
    indicator.selectedTitleColor = [UIColor redColor];
    indicator.titleFont = [UIFont systemFontOfSize:15];
    indicator.indicatorColor = [UIColor darkGrayColor];
    indicator.indicatorHeight = 3;
    indicator.backgroundColor = [UIColor colorWithWhite:235/255.0 alpha:1.0];
    [self.view addSubview:indicator];
    
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 104, self.view.frame.size.width, self.view.frame.size.height-104)];
    scrollView.pagingEnabled = YES;
    scrollView.contentSize = CGSizeMake(self.view.frame.size.width*2, 0);
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:scrollView];
    
    
    
    indicator.scrollView = scrollView;
    
    
    _tableView = [[DFBaseTableView alloc] initWithFrame:CGRectMake(0, 0, scrollView.frame.size.width, scrollView.frame.size.height) style:UITableViewStylePlain refreshControlType:DFTableViewRefreshControlTypeMJ bAddHeader:YES bAddFooter:YES bAutoLoadMore:YES];
    [scrollView addSubview:_tableView];
    
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.refreshControlDelegate = self;
    
    _service.delegate = _tableView;
    
    
    
    _tableView2 = [[DFBaseTableView alloc] initWithFrame:CGRectMake(scrollView.frame.size.width, 0, scrollView.frame.size.width, scrollView.frame.size.height) style:UITableViewStylePlain refreshControlType:DFTableViewRefreshControlTypeMJ bAddHeader:YES bAddFooter:YES bAutoLoadMore:YES];
    [scrollView addSubview:_tableView2];
    
    
    _tableView2.delegate = self;
    _tableView2.dataSource = self;
    _tableView2.refreshControlDelegate = self;
    
    _service2.delegate = _tableView2;
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [_tableView autoRefresh];
    [_tableView2 autoRefresh];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



#pragma mark - UITableViewDataSource & UITableViewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    if (_tableView.tableView == tableView) {
        cell.textLabel.text = @"hello world";
    }else{
        cell.textLabel.text = @"第二个 第二个";
    }
    
    
    return cell;
    
}


#pragma -mark DFTableViewRefreshControlDelegate

-(void)startRefresh:(UITableView *)tableView
{
    if (_tableView.tableView == tableView) {
        [_service refresh];
    }else{
        [_service2 refresh];
    }
    
}

-(void)startLoadMore:(UITableView *)tableView
{
    if (_tableView.tableView == tableView) {
        [_service loadMore];
    }else{
        [_service2 loadMore];
    }
}


@end
