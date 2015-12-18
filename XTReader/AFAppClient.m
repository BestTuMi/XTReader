//
//  AFAppClient.m
//  1248
//
//  Created by 涂勇彬 on 15/11/21.
//  Copyright © 2015年 tunb. All rights reserved.
//

#import "AFAppClient.h"

static NSString * const AFAppDotNetAPIBaseURLString = @"";


@implementation AFAppClient

+ (instancetype)sharedClient {
    static AFAppClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [AFAppClient manager];//[[AFAppClient alloc] initWithBaseURL:[NSURL URLWithString:AFAppDotNetAPIBaseURLString]];
//        _sharedClient.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    });
    
    return _sharedClient;
}

- (void)configRequest:(NSMutableURLRequest *)request {

//    NSString *value = [NSNumber numberWithInteger:20].stringValue;
//    [request setValue:value forHTTPHeaderField:@"client-type"];
}

@end
