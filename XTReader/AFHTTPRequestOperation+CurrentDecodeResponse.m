//
//  AFHTTPRequestOperation+CurrentDecodeResponse.m
//  1248
//
//  Created by 涂勇彬 on 15/11/23.
//  Copyright © 2015年 tunb. All rights reserved.
//

#import "AFHTTPRequestOperation+CurrentDecodeResponse.h"

@implementation AFHTTPRequestOperation (CurrentDecodeResponse)

- (AFResponseObject *)decodeResponseData:(id)response {

    if (response && [response isKindOfClass:[NSDictionary class]]) {
        
        NSDictionary *dic = (NSDictionary *)response;
        AFResponseObject *object = [[AFResponseObject alloc] init];
        
        NSInteger error_code = [[dic valueForKey:@"error_code"] integerValue];
        if (error_code == 0) {
            object.success = YES;
        }else {
            object.success = NO;
        }
        
        object.data = [dic valueForKey:@"result"];
        object.resultCode = [NSString stringWithFormat:@"%ld", (long)error_code];
        object.resultMessage = [dic valueForKey:@"reason"];
        
        return object;
        
    }else {
    
        return nil;
    }
}

@end
