//
//  HCBaseViewController.m
//  Heacha
//
//  Created by Allen Zhong on 15/1/11.
//  Copyright (c) 2015年 Datafans Inc. All rights reserved.
//

#import "DFBaseViewController.h"

#import "DFView.h"

#import "DFNetwork.h"

#import "UIBarButtonItem+Lite.h"

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
    
    
    if ([self leftBarButtonItem] != nil) {
        self.navigationItem.leftBarButtonItem = [self leftBarButtonItem];
    }
    
    
    if ([self rightBarButtonItem] != nil) {
        self.navigationItem.rightBarButtonItem = [self rightBarButtonItem];
    }
    
    
    
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
        [self hudShowText:@"未知错误, 请联系客服"];
    }else{
        NSLog(@"CODER-ERROR: %@",[NSString stringWithFormat:@"%ld:%@",(long)response.errorCode,response.errorMsg]);
        [self hudShowText:[NSString stringWithFormat:@"%@",response.errorMsg]];
    }
}

- (void)onStatusOk:(DFBaseResponse *)response classType:(Class)classType
{
    //do nothing
    
}



-(UIBarButtonItem *) rightBarButtonItem
{
    return nil;
}
-(UIBarButtonItem *) leftBarButtonItem
{
    
    NSArray *controllers = self.navigationController.viewControllers;
    NSString *title = nil;
    for (UIViewController *controller in controllers) {
        if (controller == self) {
            break;
        }
        title = controller.title;
    }
    if (title == nil) {
        if (controllers.count > 1) {
            title = @"返回";
        }else{
            return  nil;
        }
    }
    return [UIBarButtonItem back:title selector:@selector(onBack:) target:self];
}

-(void) onBack:(id) sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
