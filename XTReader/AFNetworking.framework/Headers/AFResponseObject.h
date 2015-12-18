//
//  AFResponseObject.h
//  AFNetworkingDemo
//
//  Created by 涂勇彬 on 15/11/23.
//  Copyright © 2015年 tuyongbin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AFResponseObject : NSObject

@property (nonatomic, copy) NSString *resultMessage;

@property (nonatomic, copy) NSString *resultCode;

@property (nonatomic, strong) NSDictionary *data;

@property (nonatomic, assign) BOOL success;

@end
