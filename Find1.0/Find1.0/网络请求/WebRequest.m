//
//  WebRequest.m
//  数据处理
//
//  Created by rimi on 15/3/23.
//  Copyright (c) 2015年 yangkai. All rights reserved.
//

#import "WebRequest.h"
#define MY_BASEURL @"http://www.find1000.com/ywkj-find-app-server/"


@implementation WebRequest
+(void)webRequestWithURLMethod:(NSString*)url parmas:(id)parmas success:(void(^)(id result))success fail:(void(^)(NSString* result))fail
{
    
    //该类封装与Web应用程序进行通信通过HTTP，包括要求制作，响应序列化，网络可达性监控和安全性，以及要求经营管理的常见模式。
    AFHTTPRequestOperationManager *requestManager = [AFHTTPRequestOperationManager manager];
     requestManager.responseSerializer.acceptableContentTypes = [requestManager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    
   NSString *urlStr = [NSString stringWithFormat:@"%@%@",MY_BASEURL,url];

   [requestManager POST:urlStr parameters:parmas constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {

   } success:^(AFHTTPRequestOperation *operation, id responseObject) {
       //请求成功返回数据
               success(responseObject);
   } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
       fail([error localizedDescription]);
   }];
}
@end
