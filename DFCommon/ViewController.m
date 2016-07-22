//
//  ViewController.m
//  DFCommon
//
//  Created by Allen Zhong on 15/5/2.
//  Copyright (c) 2015年 Datafans, Inc. All rights reserved.
//

#import "ViewController.h"

#import "DemoHttpService.h"

#import "DFLogoRefreshControl.h"

@interface ViewController ()

@property (nonatomic, strong) DemoHttpService *service;
@end

@implementation ViewController


- (instancetype)init
{
    self = [super init];
    if (self) {
        self.style = UITableViewStyleGrouped;
        
        self.bAddHeader = YES;
        self.bAddFooter = YES;
        self.bAutoRefresh = YES;
        
        //DFLogoRefreshControl *control = [[DFLogoRefreshControl alloc] init];
        //self.refreshControl = control;
//      self.refreshControlType = DFTableViewRefreshControlTypeMJPlain;
        
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    

    [self showLoadingView];
    
    _service = [[DemoHttpService alloc] init];
    _service.delegate = self;
    
    
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    cell.textLabel.text = @" hello world";
    
    return  cell;
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    int i = indexPath.row %4;
    
    if ( i == 0) {
        [self hudShowOk:@"支付成功"];
    }else if ( i == 1) {
        [self hudShowFail:@"支付失败"];
    }else if ( i == 2) {
        [self hudShowText:@"hello world"];
    }else if ( i == 3) {
        MBProgressHUD * hud = [self hudShowLoading:@"处理中..."];
        
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 2 * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [hud hide:YES];
        });
        
    }
    
    
    
}


-(void)startRefresh{
    
    [_service refresh];
}

-(void)startLoadMore
{
    [_service loadMore];
}

-(void)onClickLoadFailView
{
    [_service refresh];
}


-(BOOL)enableAutoLoadStateView
{
    //如果返回 YES 将自动出现加载错误页面
    return YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
