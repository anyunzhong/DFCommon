//
//  HCBaseViewController.m
//  Heacha
//
//  Created by Allen Zhong on 15/1/11.
//  Copyright (c) 2015年 Datafans Inc. All rights reserved.
//

#import "DFBaseViewController.h"
#import "Common.h"

@implementation DFBaseViewController

#pragma mark - Lifecycle
- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}


-(void)dealloc
{
    
}


-(void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = BaseViewColor;
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}


-(void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
}


-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [MBProgressHUD hideAllHUDsForView:[UIApplication sharedApplication].keyWindow animated:YES];
}



#pragma mark - Method

-(void) hudShowText:(NSString *)text
{
    [self hudShowText:text second:HudDefaultHideTime];
}


-(void) hudShowText:(NSString *)text second:(NSInteger)second
{
    
    _hudTextView = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    _hudTextView.mode = MBProgressHUDModeText;
    _hudTextView.animationType = MBProgressHUDAnimationFade;
    _hudTextView.removeFromSuperViewOnHide = YES;
    _hudTextView.labelText = text;
    [_hudTextView hide:YES afterDelay:second];
}





#pragma - mark DFDataServiceDelegate


-(void)onRequestError:(NSError *)error
{
    if (error.code == CustomErrorConnectFailed || error.code == -1005) {
        [self hudShowText:@"网络无法连接"];
    }
    
    if (error.code == -1001) {
        [self hudShowText:@"网络超时"];
    }

    
    NSLog(@"%@",error);
}

-(void)onStatusError:(DFBaseResponse *)response
{
    if (response.errorCode == 0 || response.errorMsg == nil) {
        [self hudShowText:@"数据格式错误"];
    }else{
        [self hudShowText:[NSString stringWithFormat:@"%ld:%@",(long)response.errorCode,response.errorMsg]];
    }
}

- (void)onStatusOk:(DFBaseResponse *)response classType:(Class)classType
{
    //do nothing
    
}


@end
