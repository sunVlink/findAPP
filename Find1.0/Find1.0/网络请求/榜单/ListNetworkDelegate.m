//
//  ListNetworkDelegate.m
//  Find1.0
//
//  Created by APPLE on 15/9/2.
//  Copyright (c) 2015年 APPLE. All rights reserved.
//

#import "ListNetworkDelegate.h"
#import "ListEntity.h"

@implementation ListNetworkDelegate

+ (ListNetworkDelegate *)listNetwokDelegate{
    return [[self alloc]init];
}


- (void)getListData:(NSString *)url params:(id)params success:(void(^)(id result))success fail:(void(^)(NSString* result))fail
{
    [WebRequest webRequestWithURLMethod:url parmas:params success:^(id result) {
        
        NSMutableArray *array = [NSMutableArray array];
        for (NSDictionary *dic in result[@"data"]) {
            ListEntity *entity = [[ListEntity alloc] initWithDictionary:dic];
            [array addObject:entity];
        }
        success(array);
    } fail:^(NSString *result) {
        fail(result);
    }];
}


@end
