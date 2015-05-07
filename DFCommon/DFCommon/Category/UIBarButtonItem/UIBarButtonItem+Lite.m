//
//  UILabel+Corner.m
//  coder
//
//  Created by Allen Zhong on 15/5/7.
//  Copyright (c) 2015年 Datafans, Inc. All rights reserved.
//

#import "UILabel+Corner.h"

@implementation UIBarButtonItem (Lite)

+(UIBarButtonItem *) text:(NSString *)text selector:(SEL)selecor target:(id)target
{
    
    CGFloat width = text.length *18;
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, width, 30)];
    [button setTitle:text forState:UIControlStateNormal];
    [button addTarget:target action:selecor forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:button];
    
}
+(UIBarButtonItem *) icon:(NSString *)icon selector:(SEL)selecor target:(id)target
{
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 32, 32)];
    [button setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    [button addTarget:target action:selecor forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

@end
