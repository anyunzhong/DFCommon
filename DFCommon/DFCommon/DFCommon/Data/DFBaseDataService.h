//
//  HCBaseDataService.h
//  Heacha
//
//  Created by Allen Zhong on 15/1/12.
//  Copyright (c) 2015年 Datafans Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AFNetworking.h"
#import "DFBaseResponse.h"

typedef enum:NSUInteger
{
    DFRequestTypeGet,
    DFRequestTypePost,
    DFRequestTypePostMultipart,
    
}DFRequestType;



@protocol DFDataServiceDelegate <NSObject>

@optional
-(void) onStatusOk:(DFBaseResponse *)response classType:(Class)classType;
-(void) onStatusError:(DFBaseResponse *)response;
-(void) onRequestError:(NSError *)error;

@end


@interface DFBaseDataService : NSObject

@property (nonatomic,assign) id<DFDataServiceDelegate> delegate;

@property (nonatomic,strong) AFHTTPRequestOperationManager *manager;

@property (nonatomic,assign) DFRequestType requestType;

@property (nonatomic,strong) NSMutableDictionary *params;

-(void) execute;

-(NSString *) getRequestUrl;
-(NSString *) getRequestPath;
-(NSMutableDictionary *) getRequestParameters;
-(void) setRequestParams:(NSMutableDictionary *)params;


-(void) onSuccess:(id)result;
-(void) onError:(NSError *)error;

-(void) parseResponse:(DFBaseResponse *)response;

@end
