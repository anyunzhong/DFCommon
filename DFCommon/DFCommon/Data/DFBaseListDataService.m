//
//  DFBaseListDataService.m
//  DFCommon
//
//  Created by Allen Zhong on 16/7/18.
//  Copyright © 2016年 Datafans, Inc. All rights reserved.
//

#import "DFBaseListDataService.h"
#import "DFBaseTableViewController.h"

@interface DFBaseListDataService()

@property (nonatomic, strong) NSNumber *start;

@end


@implementation DFBaseListDataService

- (instancetype)init
{
    self = [super init];
    if (self) {
        _size = 20;
        
    }
    return self;
}

-(void)setRequestParams:(NSMutableDictionary *)params
{
    [super setRequestParams:params];
    [params setObject:[NSNumber numberWithUnsignedInteger:_size] forKey:@"size"];
    [params setObject:_start forKey:@"start"];
    
}
-(void)refresh
{
    _start = 0;
    [self execute];
}

-(void) loadMore
{
    [self execute];
}


-(void)parseResponse:(NSDictionary *)data
{
    [super parseResponse:data];
    
    BOOL more = [[data objectForKey:@"more"] unsignedIntegerValue] == 1 ? 1:0;
    if (!more) {
        if (self.delegate && [self.delegate isKindOfClass:[DFBaseTableViewController class]]) {
            DFBaseTableViewController *controller = (DFBaseTableViewController *)self.delegate;
            [controller loadOver];
        }
    }
}
@end
