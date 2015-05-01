//
//  HCBaseViewController.h
//  Heacha
//
//  Created by Allen Zhong on 15/1/11.
//  Copyright (c) 2015年 Datafans Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

#import "DFBaseDataService.h"

@interface DFBaseViewController : UIViewController<DFDataServiceDelegate>


@property (strong,nonatomic) MBProgressHUD *hudTextView;


-(void) hudShowText:(NSString *)text;
-(void) hudShowText:(NSString *)text second:(NSInteger)second;


@end
