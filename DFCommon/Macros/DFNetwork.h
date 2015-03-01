//
//  DFNetwork.h
//  Heacha
//
//  Created by Allen Zhong on 15/2/13.
//  Copyright (c) 2015年 Datafans Inc. All rights reserved.
//

#ifndef Heacha_DFNetwork_h
#define Heacha_DFNetwork_h

#define __DFCommonDebug__

#ifdef __DFCommonDebug__
#define API_DOMAIN @"http://112.124.28.196:8080"
#else
#define API_DOMAIN @"http://api.heacha.com"
#endif


#define NetworkTimeoutInterval 30

#define CustomErrorDomain @"net.datafans"
typedef enum {
    CustomErrorConnectFailed = -2001,
}CustomErrorFailed;

#endif
