//
//  DemoHttpService.m
//  DFCommon
//
//  Created by Allen Zhong on 15/8/31.
//  Copyright (c) 2015年 Datafans, Inc. All rights reserved.
//

#import "DemoHttpService.h"

@implementation DemoHttpService

-(NSString *)getRequestUrl{
    return @"http://112.124.28.196:55555/contact/friend/list/?api_version=1&token=79128ba85fa938692f6edfedd3348803&user_id=100002";
}

-(void)setRequestParams:(NSMutableDictionary *)params
{
    
}

-(void)parseResponse:(DFBaseResponse *)response
{
    
}

@end
