//
//  SquareNetworkDelegate.m
//  Find1.0
//
//  Created by APPLE on 15/8/27.
//  Copyright (c) 2015年 APPLE. All rights reserved.
//

#import "SquareNetworkDelegate.h"
#import "HttpRequstHelper.h"
#import "SquareListEntity.h"

@implementation SquareNetworkDelegate

+ (SquareNetworkDelegate *)squareNetworkDelegate
{
    return [[self alloc]init];
}

- (void)getSquareListData:(NSString *)url params:(id)params success:(void(^)(id result))success fail:(void(^)(NSString* result))fail
{
    [WebRequest webRequestWithURLMethod:url parmas:params success:^(id result) {
        

        NSMutableArray *array = [NSMutableArray array];
        for (NSDictionary *dic in result[@"data"]) {
            SquareListEntity *entity = [[SquareListEntity alloc] initWithDictionary:dic];
            [array addObject:entity];
        }
        success(array);
    } fail:^(NSString *result) {
        fail(result);
    }];
}

@end
