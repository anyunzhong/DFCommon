//
//  WJFooterView.m
//  WeJu
//
//  Created by silver on 15/1/27.
//  Copyright (c) 2015年 Changzhou Duoju Network Technology Co., Ltd. All rights reserved.
//

#import "WJFooterView.h"

#define IPHONE_WIDTH [UIScreen mainScreen].bounds.size.width

@interface WJFooterView()

@property(nonatomic,strong)UIButton *btn;
@property(nonatomic,strong)UILabel *normalLable;

@property(nonatomic,strong)UILabel *loadingLabel;
@property(nonatomic,strong)UIActivityIndicatorView *activityView;

@end

@implementation WJFooterView

-(void)dealloc
{
    
    [_activityView stopAnimating];
    _activityView = nil;
}



-(id)init
{
    self = [super init];
    if(self){
        
        
        self.frame = CGRectMake(0, 0, IPHONE_WIDTH, 60);
        self.backgroundColor = [UIColor whiteColor];
        
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, IPHONE_WIDTH-20, 40)];
        _btn = button;
        button.clipsToBounds = YES;
        button.layer.cornerRadius = 4;
        button.layer.masksToBounds = YES;
        
//        button.backgroundColor = [UIColor whiteColor];
//        UIImage *image = [UIImage imageFromColor:UIColorRGB(255, 255, 255) size:CGSizeMake(IPHONE_WIDTH-20, 40)];
//        [button setBackgroundImage:image forState:UIControlStateNormal];
//        UIImage *highImage = [UIImage imageFromColor:UIColorRGB(250, 250, 250) size:CGSizeMake(IPHONE_WIDTH-20, 40)];
//        [button setBackgroundImage:highImage forState:UIControlStateHighlighted];
        [button addTarget:self action:@selector(clickLoadMore) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        
        
        self.normalLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, IPHONE_WIDTH-20, 40)];
        _normalLable.textAlignment = NSTextAlignmentCenter;
        _normalLable.textColor = [UIColor colorWithWhite:142/255.0 alpha:1.0];
        _normalLable.font = [UIFont systemFontOfSize:13];
         _normalLable.backgroundColor = [UIColor clearColor];
        [button addSubview:_normalLable];
        
        
        
        //UILable
        self.activityView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        _activityView.frame = CGRectMake((IPHONE_WIDTH-100)/2.0, 0, 40, 40);
        [button addSubview:_activityView];
        
        self.loadingLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_activityView.frame), 0, 100, 40)];
        _loadingLabel.textColor = [UIColor colorWithWhite:142/255.0 alpha:1.0];
        _loadingLabel.font = [UIFont systemFontOfSize:13];
        _loadingLabel.backgroundColor = [UIColor clearColor];
        [button addSubview:_loadingLabel];
       
        [self setType:FootViewHasMore];
    }
    return self;
}

-(void)setType:(FootViewState)type
{
    _type = type;

    switch (type) {
        case FootViewHasMore:
        {
            _btn.enabled = YES;
            [_activityView stopAnimating];
             _loadingLabel.text = nil;
            _normalLable.text = NSLocalizedString(@"FootViewHasMore" , "点击加载更多");
        }
            break;
        case FootViewLoading:
        {
            _btn.enabled = NO;
            [_activityView startAnimating];
             _loadingLabel.text = NSLocalizedString(@"FootViewLoading" , "加载中……");
            _normalLable.text = nil;
        }
            break;
        case FootViewNoMore:
        {
            _btn.enabled = NO;
            [_activityView stopAnimating];
            _loadingLabel.text = nil;
            
            if(self.footViewNoMoreText && self.footViewNoMoreText.length>0)
            {
                _normalLable.text =_footViewNoMoreText;
            }else{
                _normalLable.text = NSLocalizedString(@"FootViewNoMore" , "全部加载完毕");
            }

        }
            break;
            
        default:
            break;
    }
}


-(void)setFootViewNoMoreText:(NSString *)footViewNoMoreText
{
    _footViewNoMoreText = footViewNoMoreText;
    _normalLable.text = _footViewNoMoreText;
}


-(void)clickLoadMore
{
    self.type = FootViewLoading;
    if(self.clickMoreBlock){
        
        self.clickMoreBlock(YES);
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
