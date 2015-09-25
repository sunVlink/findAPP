//
//  WebRequest.h
//  数据处理
//
//  Created by rimi on 15/3/23.
//  Copyright (c) 2015年 yangkai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WebRequest : NSObject
+(void)webRequestWithURLMethod:(NSString*)url parmas:(id)parmas success:(void(^)(id result))success fail:(void(^)(NSString* result))fail;

@end
