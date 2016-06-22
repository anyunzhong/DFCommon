//
//  MLLinkClickLabel.h
//  DFCommon
//
//  Created by Allen Zhong on 15/10/10.
//  Copyright (c) 2015年 Datafans, Inc. All rights reserved.
//

#import "MLLinkLabel.h"

@protocol MLLinkClickLabelDelegate <NSObject>

@optional

-(void) onClickOutsideLink:(long long) uniqueId;
-(void) onLongPress;

- (void) onClickOutsideLink:(long long) uniqueId mllinkLabel:(MLLinkLabel *)linkLabel;
- (void) onLongPressLinkLabel:(MLLinkLabel *)linkLabel;

@end

@interface MLLinkClickLabel : MLLinkLabel

@property (nonatomic, assign) id<MLLinkClickLabelDelegate> clickDelegate;

@property (nonatomic, assign) long long uniqueId;


@end
