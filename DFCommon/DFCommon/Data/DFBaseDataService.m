//
//  HCBaseDataService.m
//  Heacha
//
//  Created by Allen Zhong on 15/1/12.
//  Copyright (c) 2015年 Datafans Inc. All rights reserved.
//

#import "DFBaseDataService.h"
#import "DFReachabilityUtil.h"

#import "DFNetwork.h"

#define PROGRESS_BLOCK ^(NSProgress * _Nonnull downloadProgress) {}
#define SUCCESS_BLOCK ^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) { [self onSuccess:responseObject]; }
#define FAILURE_BLOCK ^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) { [self onError:error];}

@interface DFBaseDataService()


@property (nonatomic,strong) NSMutableDictionary *params;

@property (nonatomic,strong) AFHTTPSessionManager *manager;

@end



@implementation DFBaseDataService

#pragma mark - Lifecycle

- (instancetype)init
{
    self = [super init];
    if (self) {
        _manager = [[AFHTTPSessionManager alloc] init];
        _manager.requestSerializer.timeoutInterval = NetworkTimeoutInterval;
        _requestType = DFRequestTypeGet;
        _params = [NSMutableDictionary dictionary];
        
        if ([self getRequestIp] && [self getRequestDomain]) {
            [_manager.requestSerializer setValue:[self getRequestDomain] forHTTPHeaderField:@"Host"];
        }
    }
    return self;
}


#pragma mark - Method

-(void) execute
{
    //网络不可用
    if (![DFReachabilityUtil isNetworkAvailable]) {
        
        NSError *error = [NSError errorWithDomain:CustomErrorDomain code:CustomErrorConnectFailed userInfo:nil];
        [self onError:error];
        return;
    }
    
    [self setRequestParams:_params];
    
    NSLog(@"path: %@  params: %@", [self getRequestUrl], _params);
    
    [self executeRequest];
    
}


-(void)executeRequest
{
    switch (_requestType) {
        case DFRequestTypeGet:
        {
            
            [_manager GET:[self getRequestUrl] parameters:_params progress:PROGRESS_BLOCK success:SUCCESS_BLOCK failure:FAILURE_BLOCK];
            break;
        }
            
        case DFRequestTypePost:
        {
            
            [_manager POST:[self getRequestUrl] parameters:_params progress:PROGRESS_BLOCK success:SUCCESS_BLOCK failure:FAILURE_BLOCK];
            break;
        }
        case DFRequestTypePostMultipart:
        {
            NSData *data = [self getFileData];
            if (data == nil) {
                return;
            }
            
            [_manager POST:[self getRequestUrl] parameters:_params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
                
                [formData appendPartWithFileData:data name:@"file" fileName:[NSString stringWithFormat:@"foo.%@",[self getFileType]] mimeType:[NSString stringWithFormat:@"image/%@",[self getFileType]]];
            } progress:PROGRESS_BLOCK success:SUCCESS_BLOCK failure:FAILURE_BLOCK];
            
            break;
        }
        default:
            break;
    }
    
}

-(NSString *) getRequestUrl
{
    NSString *address;
    if ([self getRequestIp]) {
        address = [self getRequestIp];
    }else{
        address = [self getRequestDomain];
    }
    NSString *url = [NSString stringWithFormat:@"http://%@%@",address,[self getRequestPath]];
    return  url;
}

-(NSString *) getRequestDomain
{
    return nil;
}

-(NSString *) getRequestPath
{
    return nil;
}

-(NSString *)getRequestIp
{
    return nil;
}

-(NSString *)getFileType
{
    return nil;
}

-(NSData *)getFileData
{
    return nil;
}


-(void) setRequestParams:(NSMutableDictionary *)params
{
    
}

-(void) onSuccess:(id)result
{
    
    if (result) {
        DFBaseResponse *response =  [[DFBaseResponse alloc] initWithData:result];
        
        if (response.status == 1) {
            
            [self parseResponse:response.data];
            
            if (_delegate && [_delegate conformsToProtocol:@protocol(DFDataServiceDelegate)] && [_delegate respondsToSelector:@selector(onStatusOk:dataService:)]) {
                
                [_delegate onStatusOk:response dataService:self];
            }
            
        }else{
            if (_delegate && [_delegate conformsToProtocol:@protocol(DFDataServiceDelegate)] && [_delegate respondsToSelector:@selector(onStatusError:dataService:)]) {
                
                if (response.errorMsg == nil) {
                    response.errorMsg = @"出错啦!";
                }
                
                [_delegate onStatusError:response dataService:self];
            }
        }
    }
    
}

-(void) onError:(NSError *)error
{
    if (_delegate && [_delegate conformsToProtocol:@protocol(DFDataServiceDelegate)] && [_delegate respondsToSelector:@selector(onRequestError:dataService:)]) {
        [_delegate onRequestError:error dataService:self];
    }
    
    
}

-(void) parseResponse:(DFBaseResponse *)response
{
}

@end
