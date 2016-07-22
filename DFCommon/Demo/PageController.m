//
//  PageController.m
//  DFCommon
//
//  Created by Allen Zhong on 16/7/22.
//  Copyright © 2016年 Datafans, Inc. All rights reserved.
//

#import "PageController.h"

#import "ViewController2.h"
#import "ViewController.h"

@interface PageController ()

@end

@implementation PageController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    ViewController *con1 = [ViewController new];
    ViewController2 *con2 = [ViewController2 new];
    
    
    UIPageViewController *pageController = [[UIPageViewController alloc] init];
    [pageController setViewControllers:@[con1] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:^(BOOL finished) {
        
    }];
    [self addChildViewController:pageController];
    [self.view addSubview:pageController.view];
    //[pageController didMoveToParentViewController:self];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
