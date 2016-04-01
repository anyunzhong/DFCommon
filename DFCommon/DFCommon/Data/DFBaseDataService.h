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


@class DFBaseDataService;

@protocol DFDataServiceDelegate <NSObject>

-(void) onStatusOk:(DFBaseResponse *)response dataService:(DFBaseDataService *)dataService;
-(void) onStatusError:(DFBaseResponse *)response dataService:(DFBaseDataService *)dataService;

@optional
-(void) onRequestError:(NSError *)error dataService:(DFBaseDataService *)dataService;

@end


@interface DFBaseDataService : NSObject

@property (nonatomic,weak) id<DFDataServiceDelegate> delegate;

@property (nonatomic,assign) DFRequestType requestType;

//执行请求
-(void) execute;


//完整的url
-(NSString *) getRequestUrl;

//不带域名的路径
-(NSString *) getRequestPath;

//域名
-(NSString *) getRequestDomain;

//代理IP
-(NSString *) getRequestIp;


//设置请求参数
-(void) setRequestParams:(NSMutableDictionary *)params;

//上传文件时获取文件类型
-(NSString *) getFileType;

//上传文件时获取文件数据
-(NSData *) getFileData;


//解析数据回调
-(void) parseResponse:(NSDictionary *)data;

@end
