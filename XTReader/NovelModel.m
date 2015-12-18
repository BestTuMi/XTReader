//
//  NovelModel.m
//  XTReader
//
//  Created by gao7 on 15/12/3.
//  Copyright © 2015年 gao7. All rights reserved.
//

#import "NovelModel.h"
#import "NovelObject.h"
#import "DataTypeHelper.h"

#import "XTTool.h"

@implementation NovelModel

- (void)loadWithUrl:(NSString *)url {
    NSLog(@"url:%@",url);
    __weak __typeof(&*self) weakSelf = self;
    
    [[AFAppClient sharedClient] GET:url parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, AFResponseObject * _Nonnull responseObject) {
        __strong __typeof(&*weakSelf)strongSelf = weakSelf;
       
//        if (nil == strongSelf) {
//                return ;
//        }
        
        NSString *error_code = responseObject.resultCode;
        NSString *reason = responseObject.resultMessage;
        NSDictionary *dic;
        if (responseObject.success) {
//            array = [DataTypeHelper parseTestWeiXing:responseObject.data];
            dic = responseObject.data;
        }else {
            
        }
        if (self.completeBlock) {
            strongSelf.completeBlock(dic,YES);
        }
         NSLog(@"error_code=%@,reason=%@",error_code,reason);
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
       __strong __typeof(&*weakSelf)strongSelf = weakSelf;
        NSLog(@"%@,%@,%@",operation,error,operation.responseObject);
        
        NSLog(@"error_code");
        strongSelf.completeBlock(nil,NO);

    }];
}
//
//- (NSArray *)getNovelArrayWithAppKey:(NSString *)appKey cat:(NSInteger)cat ranks:(NSInteger)ranks {
//    
//    __block NSMutableArray *array;
//    NSString *url=[NSString stringWithFormat:@"http://japi.juhe.cn/book/recommend.from?key=%@&cat=%d&ranks=%d",appKey,cat,ranks];
//    [[AFAppClient sharedClient] GET:url parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, AFResponseObject * _Nonnull responseObject) {
//        NSString *error_code = responseObject.resultCode;
//        NSString *reason = responseObject.resultMessage;
//        if (responseObject.success) {
//            array = [DataTypeHelper parseNovelObjectType:responseObject.data];
//         
//        }else {
//            
//        }
//        NSLog(@"error_code=%@,reason=%@",error_code,reason);
//        
//    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
//        
//    }];
//    return array;
//}

//
//- (NSArray *)getNovelArrayWithAppKey:(NSString *)appKey cat:(NSInteger)cat bookname:(NSString *)bookname {
//    
//    __block NSMutableArray *array = [NSMutableArray array];
//    NSString *url=[NSString stringWithFormat:@"http://japi.juhe.cn/book/bookname.from?bookname=%@&cat=%d&key=%@",bookname,cat,appKey];
//    [[AFAppClient sharedClient] GET:url parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, AFResponseObject * _Nonnull responseObject) {
//        
//    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
//        
//    }];
//    
//    return array;
//}

// 返回小说内容
//- (void)getNovelArrayWithNovelCode:(NSString *)code andPage:(NSInteger)page {
//    NSMutableString *novelStr = [[NSMutableString alloc] init];
//    
//}


//- (NSArray *)getNovelArrayWithAppKey:(NSString *)appKey code:(NSInteger)code cat:(NSInteger)cat page:(NSInteger)page {
//
//    __block NSMutableArray *array = [NSMutableArray array];
//    NSString *url=[NSString stringWithFormat:@"http://japi.juhe.cn/book/content.from?code=%d&cat=%d&page=%d&key=%@",code,cat,page,appKey];
//    [[AFAppClient sharedClient] GET:url parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, AFResponseObject * _Nonnull responseObject) {
//        
//    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
//        
//    }];
//    return array;
//}


@end
