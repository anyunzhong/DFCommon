//
//  WJFooterView.h
//  WeJu
//
//  Created by silver on 15/1/27.
//  Copyright (c) 2015年 Changzhou Duoju Network Technology Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum{
    FootViewHasMore = 0,
    FootViewLoading,
    FootViewNoMore,
} FootViewState;

typedef void (^FootBlock)(BOOL isClicked);

@interface WJFooterView : UIView

@property(nonatomic,copy)FootBlock clickMoreBlock;

@property(nonatomic,assign)FootViewState type;//外部赋值，只需传这个2个值即可： FootViewHasMore ,FootViewNoMore

@property(nonatomic,strong)NSString *footViewNoMoreText; //默认：全部加载完毕，可以主动赋值

@end
