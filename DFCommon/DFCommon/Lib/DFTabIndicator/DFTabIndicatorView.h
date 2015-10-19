//
//  DFTabIndicatorView.h
//  tabpagerTest
//
//  Created by Allen Zhong on 15/10/19.
//  Copyright (c) 2015年 Datafans, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DFTabIndicatorView : UIView

@property (nonatomic, strong) NSArray *titles;

@property (nonatomic, assign) NSUInteger selectedIndex;

@property (nonatomic, strong) UIColor *titleColor;

@property (nonatomic, strong) UIFont *titleFont;

@property (nonatomic, strong) UIColor *selectedTitleColor;

@property (nonatomic, assign) CGFloat indicatorHeight;

@property (nonatomic, strong) UIColor *indicatorColor;

@property (nonatomic, strong) UIScrollView *scrollView;

@end
