//
//  DFTabIndicatorView.m
//  tabpagerTest
//
//  Created by Allen Zhong on 15/10/19.
//  Copyright (c) 2015年 Datafans, Inc. All rights reserved.
//

#import "DFTabIndicatorView.h"


@interface DFTabIndicatorView()<UIScrollViewDelegate>

@property (nonatomic, strong) NSMutableArray *buttons;

@property (nonatomic, strong) UIView *indicator;

@property (nonatomic, assign) CGFloat itemWidth;
@end


@implementation DFTabIndicatorView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _buttons = [NSMutableArray array];
        
    }
    return self;
}


-(void)setTitles:(NSArray *)titles
{
    _titles = titles;
    
    //防止重复添加
    for (UIButton * button in _buttons) {
        [button removeFromSuperview];
    }
    
    
    CGFloat x, y, width, height;
    
    width = self.frame.size.width/titles.count;
    _itemWidth = width;
    height = self.frame.size.height;
    y = 0;
    
    for (int i=0; i<titles.count; i++) {
        x = i*width;
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(x, y, width, height)];
        button.tag = i;
        [button addTarget:self action:@selector(onClickButton:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        [_buttons addObject:button];
        
        [button setTitle:[titles objectAtIndex:i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    }
    
    x=0;
    height = 2;
    y = CGRectGetHeight(self.frame) - height;
    
    _indicator = [[UIView alloc] initWithFrame:CGRectMake(x, y, width, height)];
    _indicator.backgroundColor =[UIColor lightGrayColor];
    [self addSubview:_indicator];
    
}


-(void)setSelectedIndex:(NSUInteger)selectedIndex
{
    [self setTitleOnSelectIndex:selectedIndex];
    
    [self changeIndicatorFrame:selectedIndex*_indicator.frame.size.width];
    
    [self changeScrollContentFrame:_scrollView.frame.size.width * selectedIndex];
    
}

-(void) setTitleOnSelectIndex:(NSUInteger)selectedIndex
{
    _selectedIndex = selectedIndex;
    
    if (_titles == nil) {
        return;
    }
    
    if (_titles.count -1  < selectedIndex ) {
        return;
    }
    
    for (int i=0; i<_titles.count; i++) {
        UIButton *button = [_buttons objectAtIndex:i];
        if (i == selectedIndex) {
            if (_selectedTitleColor != nil) {
                [button setTitleColor:_selectedTitleColor forState:UIControlStateNormal];
            }
        }else{
            if (_titleColor != nil) {
                [button setTitleColor:_titleColor forState:UIControlStateNormal];
            }
        }
    }
    
}


-(void)setTitleColor:(UIColor *)titleColor
{
    _titleColor = titleColor;
    
    if (_titles == nil) {
        return;
    }
    
    for (int i=0; i<_titles.count; i++) {
        UIButton *button = [_buttons objectAtIndex:i];
        if (i != _selectedIndex) {
            [button setTitleColor:titleColor forState:UIControlStateNormal];
        }
    }
    
}

-(void)setSelectedTitleColor:(UIColor *)selectedTitleColor
{
    _selectedTitleColor = selectedTitleColor;
    
    if (_titles == nil) {
        return;
    }
    
    for (int i=0; i<_titles.count; i++) {
        UIButton *button = [_buttons objectAtIndex:i];
        if (i == _selectedIndex) {
            [button setTitleColor:_selectedTitleColor forState:UIControlStateNormal];
        }
    }
}


-(void)setTitleFont:(UIFont *)titleFont
{
    _titleFont = titleFont;
    
    if (_titles == nil) {
        return;
    }
    
    for (int i=0; i<_titles.count; i++) {
        UIButton *button = [_buttons objectAtIndex:i];
        button.titleLabel.font = titleFont;
    }
}

-(void)setIndicatorHeight:(CGFloat)indicatorHeight
{
    CGFloat x, y, width, height;
    
    width = _itemWidth;
    height = indicatorHeight;
    y = self.frame.size.height - height;
    x = CGRectGetMinX(_indicator.frame);
    _indicator.frame = CGRectMake(x, y, width, height);
}

-(void)setIndicatorColor:(UIColor *)indicatorColor
{
    _indicator.backgroundColor = indicatorColor;
}


-(void) onClickButton:(UIButton *) button
{
    NSUInteger index = button.tag;
    
    [self setTitleOnSelectIndex:index];
    
    [self changeScrollContentFrame:_scrollView.frame.size.width * index];
    
}

-(void)setScrollView:(UIScrollView *)scrollView
{
    _scrollView = scrollView;
    _scrollView.delegate = self;
}


-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSUInteger index = scrollView.contentOffset.x / scrollView.frame.size.width;
    [self setTitleOnSelectIndex:index];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat x = (scrollView.contentOffset.x / scrollView.frame.size.width) * CGRectGetWidth(_indicator.frame);
    [self changeIndicatorFrame:x];
    
}

-(void) changeIndicatorFrame:(CGFloat) x
{
    CGFloat y, width, height;
    width = CGRectGetWidth(_indicator.frame);
    height = CGRectGetHeight(_indicator.frame);
    y = CGRectGetMinY(_indicator.frame);
    _indicator.frame = CGRectMake(x, y, width, height);
}

-(void) changeScrollContentFrame:(CGFloat) x
{
    CGRect frame = _scrollView.frame;
    [_scrollView scrollRectToVisible:CGRectMake(x, frame.origin.y, frame.size.width, frame.size.height) animated:YES];
}

@end
