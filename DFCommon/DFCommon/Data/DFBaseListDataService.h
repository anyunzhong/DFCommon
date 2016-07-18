//
//  DFBaseListDataService.h
//  DFCommon
//
//  Created by Allen Zhong on 16/7/18.
//  Copyright © 2016年 Datafans, Inc. All rights reserved.
//

#import "DFBaseDataService.h"

@interface DFBaseListDataService : DFBaseDataService

@property (nonatomic, assign) NSInteger size;

-(void) refresh;
-(void) loadMore;

@end
