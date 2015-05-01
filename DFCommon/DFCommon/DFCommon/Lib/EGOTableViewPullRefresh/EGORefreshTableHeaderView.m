//
//  EGORefreshTableHeaderView.m
//  Demo
//
//  Created by Devin Doty on 10/14/09October14.
//  Copyright 2009 enormego. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

#import "EGORefreshTableHeaderView.h"

#define TEXT_COLOR	 [UIColor colorWithRed:87.0/255.0 green:108.0/255.0 blue:137.0/255.0 alpha:1.0]
#define FLIP_ANIMATION_DURATION 0.18f


@implementation EGORefreshTableHeaderView

- (id)initWithLoadMoreFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.bLoadMore = YES;
        self.bHasBottom = NO;
        self.bIsTransparent = NO;
        
		self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        self.backgroundColor = [UIColor whiteColor];
		
		UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, frame.size.height - 30.0f, self.frame.size.width, 20.0f)];
		label.autoresizingMask = UIViewAutoresizingFlexibleWidth;
		label.font = [UIFont systemFontOfSize:12.0f];
		label.textColor = [UIColor grayColor];
		label.backgroundColor = [UIColor clearColor];
		label.textAlignment = NSTextAlignmentCenter;
		[self addSubview:label];
		_lastUpdatedLabel = label;
		
		label = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, frame.size.height - 48.0f, self.frame.size.width, 20.0f)];
		label.autoresizingMask = UIViewAutoresizingFlexibleWidth;
		label.font = [UIFont boldSystemFontOfSize:13.0f];
		label.textColor = [UIColor grayColor];
		label.backgroundColor = [UIColor clearColor];
		label.textAlignment = NSTextAlignmentCenter;
		[self addSubview:label];
		_statusLabel = label;
		
		CALayer *layer = [CALayer layer];
		layer.frame = CGRectMake(25.0f, frame.size.height - 65.0f, 30.0f, 55.0f);
		layer.contentsGravity = kCAGravityResizeAspect;
		layer.contents = (id)[UIImage imageNamed:@"refreshBlueArrow.png"].CGImage;
		
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 40000
		if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)])
        {
			layer.contentsScale = [[UIScreen mainScreen] scale];
		}
#endif
		
		[[self layer] addSublayer:layer];
		_arrowImage = layer;
		
		UIActivityIndicatorView *view = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
		view.frame = CGRectMake(25.0f, frame.size.height - 38.0f, 20.0f, 20.0f);
		[self addSubview:view];
		_activityView = view;
		
		[self setState:EGOOPullRefreshNormal];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) 
    {
        self.bLoadMore = NO;
        self.bHasBottom = NO;
        self.bIsTransparent = NO;
        
		self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        self.backgroundColor = [UIColor whiteColor];
		
		UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, frame.size.height - 30.0f, self.frame.size.width, 20.0f)];
		label.autoresizingMask = UIViewAutoresizingFlexibleWidth;
		label.font = [UIFont systemFontOfSize:12.0f];
		label.textColor = [UIColor grayColor];
		label.backgroundColor = [UIColor clearColor];
		label.textAlignment = NSTextAlignmentCenter;
		[self addSubview:label];
		_lastUpdatedLabel = label;
		
		label = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, frame.size.height - 48.0f, self.frame.size.width, 20.0f)];
		label.autoresizingMask = UIViewAutoresizingFlexibleWidth;
		label.font = [UIFont boldSystemFontOfSize:13.0f];
		label.textColor = [UIColor grayColor];
		label.backgroundColor = [UIColor clearColor];
		label.textAlignment = NSTextAlignmentCenter;
		[self addSubview:label];
		_statusLabel = label;
		
    
        float w = [UIScreen mainScreen].bounds.size.width;
        float x = (w-90)/2.0-15;
		CALayer *layer = [CALayer layer];
		layer.frame = CGRectMake(x, frame.size.height - 30.0, 13.0, 8.0);
		layer.contentsGravity = kCAGravityResizeAspect;
		layer.contents = (id)[UIImage imageNamed:@"newRefreshArrow.png"].CGImage;
		
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 40000
		if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]) 
        {
			layer.contentsScale = [[UIScreen mainScreen] scale];
		}
#endif
		[self.layer addSublayer:layer];
		_arrowImage = layer;
		
		UIActivityIndicatorView *view = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
		view.frame = CGRectMake(x, frame.size.height - 38.0f, 20.0f, 20.0f);
		[self addSubview:view];
		_activityView = view;
		
		[self setState:EGOOPullRefreshNormal];
    }
    return self;
}


#pragma mark -
#pragma mark Setters

- (void)refreshLastUpdatedDate 
{	
	if ([_delegate respondsToSelector:@selector(egoRefreshTableHeaderDataSourceLastUpdated:)]) 
    {
		NSDate *date = [_delegate egoRefreshTableHeaderDataSourceLastUpdated:self];
		NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
		[formatter setAMSymbol:NSLocalizedString(@"AM",@"上午")];
		[formatter setPMSymbol:NSLocalizedString(@"PM",@"下午")];
		[formatter setDateFormat:@"MM/dd/yyyy hh:mm"];
        if(_bLoadMore)
        {
            _lastUpdatedLabel.text = [NSString stringWithFormat:@"%@: %@", NSLocalizedString(@"Last Loaded", @"最后加载"),[formatter stringFromDate:date]];
        }
        else
        {
            _lastUpdatedLabel.text = [NSString stringWithFormat:@"%@: %@", NSLocalizedString(@"Last Updated", @"最后更新"),[formatter stringFromDate:date]];
        }
		[[NSUserDefaults standardUserDefaults] setObject:_lastUpdatedLabel.text forKey:@"EGORefreshTableView_LastRefresh"];
		[[NSUserDefaults standardUserDefaults] synchronize];
	}
    else 
    {
		_lastUpdatedLabel.text = nil;
	}
    
    // Center the status label if the lastupdate is not available
    CGFloat midY = self.frame.size.height - PULL_AREA_HEIGTH/2;
    if(!_lastUpdatedLabel.text) 
    {
        _statusLabel.frame = CGRectMake(0.0f, midY - 8, self.frame.size.width, 20.0f);
    }
    else 
    {
        _statusLabel.frame = CGRectMake(0.0f, midY - 18, self.frame.size.width, 20.0f);
    }
    
    CGFloat width = _arrowImage.frame.size.width;
    CGFloat height = _arrowImage.frame.size.height;
    CGFloat x = _arrowImage.frame.origin.x;
    CGFloat y = _statusLabel.frame.origin.y + (_statusLabel.frame.size.height - height) / 2.0;
    _arrowImage.frame = CGRectMake(x, y, width, height);
    
    width = _activityView.frame.size.width;
    height = _activityView.frame.size.height;
    x = _activityView.frame.origin.x;
    y = _statusLabel.frame.origin.y + (_statusLabel.frame.size.height - height) / 2.0;
    _activityView.frame = CGRectMake(x, y, width, height);
}

- (void)setState:(EGOPullRefreshState)state
{	
	switch (state)
    {
		case EGOOPullRefreshPulling:
        {
            if(_bLoadMore)
            {
                _statusLabel.text = NSLocalizedString(@"Release to load more...", @"松开即可加载更多.");
            }
            else
            {
                _statusLabel.text = NSLocalizedString(@"Release to refresh...", @"Release to refresh...");
            }
			
			[CATransaction begin];
			[CATransaction setAnimationDuration:FLIP_ANIMATION_DURATION];
			_arrowImage.transform = CATransform3DMakeRotation((M_PI / 180.0) * 180.0f, 0.0f, 0.0f, 1.0f);
			[CATransaction commit];
            
            if (self.contentOffset.y < -(64.0+self.offset)) {
                _lastUpdatedLabel.hidden = NO;
                _statusLabel.hidden = NO;
                _arrowImage.hidden = NO;
            }
            else {
                _lastUpdatedLabel.hidden = YES;
                _statusLabel.hidden = YES;
                _arrowImage.hidden = YES;
            }
            
			break;
        }
		case EGOOPullRefreshNormal:
		{	
			if (_state == EGOOPullRefreshPulling) 
            {
				[CATransaction begin];
				[CATransaction setAnimationDuration:FLIP_ANIMATION_DURATION];
				_arrowImage.transform = CATransform3DIdentity;
				[CATransaction commit];
			}
			
            if(_bLoadMore)
            {
                _statusLabel.text = NSLocalizedString(@"Pull down to load more...", @"下拉可以加载更多...");
            }
            else
            {
                _statusLabel.text = NSLocalizedString(@"Pull down to refresh...", @"Pull down to refresh...");
            }
            
			[_activityView stopAnimating];
			[CATransaction begin];
			[CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions]; 
			_arrowImage.hidden = NO;
			_arrowImage.transform = CATransform3DIdentity;
			[CATransaction commit];
			
			[self refreshLastUpdatedDate];
            
            if (self.contentOffset.y < -(64.0+self.offset)) {
                _lastUpdatedLabel.hidden = NO;
                _statusLabel.hidden = NO;
                _arrowImage.hidden = NO;
            }
            else {
                _lastUpdatedLabel.hidden = YES;
                _statusLabel.hidden = YES;
                _arrowImage.hidden = YES;
            }
			
			break;
        }
		case EGOOPullRefreshLoading:
        {
			_statusLabel.text = NSLocalizedString(@"Loading...", @"Loading...");
			[_activityView startAnimating];
			[CATransaction begin];
			[CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions]; 
			_arrowImage.hidden = YES;
			[CATransaction commit];
			
			break;
		}
        default:
			break;
	}
	
	_state = state;
}


#pragma mark -
#pragma mark ScrollView Methods

- (void)egoRefreshScrollViewDidScroll:(UIScrollView *)scrollView 
{
    self.contentOffset = scrollView.contentOffset;
    
    if(self.bIsTransparent)
    {
        if (_state == EGOOPullRefreshLoading)
        {
            CGFloat offset = MAX(scrollView.contentOffset.y * -1, 0);
            offset = MIN(offset, 60.0 + (64.0+self.offset));
            CGFloat top = offset;
            CGFloat bottom = self.bHasBottom ? 50.0 : 0.0;
            scrollView.contentInset = UIEdgeInsetsMake(top, 0.0f, bottom, 0.0f);
        }
        else if (scrollView.isDragging)
        {
            BOOL _loading = NO;
            if ([_delegate respondsToSelector:@selector(egoRefreshTableHeaderDataSourceIsLoading:)])
            {
                _loading = [_delegate egoRefreshTableHeaderDataSourceIsLoading:self];
            }
            
            if (_state == EGOOPullRefreshPulling && scrollView.contentOffset.y > -65.0f - (64.0+self.offset) && scrollView.contentOffset.y < 0.0f + (64.0+self.offset) && !_loading)
            {
                [self setState:EGOOPullRefreshNormal];
            }
            else if (_state == EGOOPullRefreshNormal && scrollView.contentOffset.y < -65.0f - (64.0+self.offset) && !_loading)
            {
                [self setState:EGOOPullRefreshPulling];
            }
            
            if (scrollView.contentInset.top != 0 + (64.0+self.offset))
            {
                CGFloat top = (64.0+self.offset);
                CGFloat bottom = self.bHasBottom ? 50.0 : 0.0;
                scrollView.contentInset = UIEdgeInsetsMake(top, 0.0f, bottom, 0.0f);
            }
        }
    }
    else
    {
        if (_state == EGOOPullRefreshLoading)
        {
            CGFloat offset = MAX(scrollView.contentOffset.y * -1, 0);
            offset = MIN(offset, 60);
            scrollView.contentInset = UIEdgeInsetsMake(offset, 0.0f, 0.0f, 0.0f);
        }
        else if (scrollView.isDragging)
        {
            BOOL _loading = NO;
            if ([_delegate respondsToSelector:@selector(egoRefreshTableHeaderDataSourceIsLoading:)])
            {
                _loading = [_delegate egoRefreshTableHeaderDataSourceIsLoading:self];
            }
            
            if (_state == EGOOPullRefreshPulling && scrollView.contentOffset.y > -65.0f && scrollView.contentOffset.y < 0.0f && !_loading)
            {
                [self setState:EGOOPullRefreshNormal];
            }
            else if (_state == EGOOPullRefreshNormal && scrollView.contentOffset.y < -65.0f && !_loading)
            {
                [self setState:EGOOPullRefreshPulling];
            }
            
            if (scrollView.contentInset.top != 0) 
            {
                scrollView.contentInset = UIEdgeInsetsZero;
            }
        }
    }
    
    switch (_state) {
        case EGOOPullRefreshPulling: {
            if (self.contentOffset.y < -(64.0+self.offset)) {
                _lastUpdatedLabel.hidden = NO;
                _statusLabel.hidden = NO;
                _arrowImage.hidden = NO;
            }
            else {
                _lastUpdatedLabel.hidden = YES;
                _statusLabel.hidden = YES;
                _arrowImage.hidden = YES;
            }
            break;
        }
        case EGOOPullRefreshNormal: {
            if (self.contentOffset.y < -(64.0+self.offset)) {
                _lastUpdatedLabel.hidden = NO;
                _statusLabel.hidden = NO;
                _arrowImage.hidden = NO;
            }
            else {
                _lastUpdatedLabel.hidden = YES;
                _statusLabel.hidden = YES;
                _arrowImage.hidden = YES;
            }
            break;
        }
        case EGOOPullRefreshLoading: {
            
            break;
        }
        default:
            break;
    }
}

- (void)egoRefreshScrollViewDidEndDragging:(UIScrollView *)scrollView
{
    self.contentOffset = scrollView.contentOffset;
    
    if(self.bIsTransparent)
    {
        BOOL _loading = NO;
        if (scrollView.contentOffset.y <= - 65.0f - (64.0+self.offset) && !_loading)
        {
            [self setState:EGOOPullRefreshLoading];
            [UIView animateWithDuration:0.2 animations:^{
                CGFloat top = 60.0f + (64.0+self.offset);
                CGFloat bottom = self.bHasBottom ? 50.0 : 0.0;
                scrollView.contentInset = UIEdgeInsetsMake(top, 0.0f, bottom, 0.0f);
            } completion:^(BOOL finished) {
                if ([_delegate respondsToSelector:@selector(egoRefreshTableHeaderDidTriggerRefresh:)])
                {
                    [_delegate egoRefreshTableHeaderDidTriggerRefresh:self];
                }
            }];
        }
    }
    else
    {
        BOOL _loading = NO;
        if (scrollView.contentOffset.y <= - 65.0f && !_loading)
        {
            if ([_delegate respondsToSelector:@selector(egoRefreshTableHeaderDidTriggerRefresh:)])
            {
                [_delegate egoRefreshTableHeaderDidTriggerRefresh:self];
            }
            
            [self setState:EGOOPullRefreshLoading];
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationDuration:0.2];
            scrollView.contentInset = UIEdgeInsetsMake(60.0f, 0.0f, 0.0f, 0.0f);
            [UIView commitAnimations];		
        }
    }
}

- (void)egoRefreshScrollViewDataSourceDidFinishedLoading:(UIScrollView *)scrollView 
{
    self.contentOffset = scrollView.contentOffset;
    
    if(self.bIsTransparent)
    {
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:.3];
        CGFloat top = (64.0+self.offset);
        CGFloat bottom = self.bHasBottom ? 50.0 : 0.0;
        if(self.fixedTop != 0.0)
        {
            top = self.fixedTop;
        }
        [scrollView setContentInset:UIEdgeInsetsMake(top, 0.0f, bottom, 0.0f)];
        [UIView commitAnimations];
    }
    else
    {
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:.3];
        [scrollView setContentInset:UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 0.0f)];
        [UIView commitAnimations];
    }
	
	[self setState:EGOOPullRefreshNormal];
}


#pragma mark -
#pragma mark Dealloc

- (void)dealloc 
{
	self.delegate = nil;
	_activityView = nil;
	_statusLabel = nil;
	_arrowImage = nil;
	_lastUpdatedLabel = nil;
}


@end
