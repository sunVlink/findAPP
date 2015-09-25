//
//  HttpRequstHelper.m
//  Find1.0
//
//  Created by APPLE on 15/8/27.
//  Copyright (c) 2015年 APPLE. All rights reserved.
//

#import "HttpRequstHelper.h"

@implementation HttpRequstHelper

+ (instancetype)sharedInstance
{
    static HttpRequstHelper *helper;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        helper = [HttpRequstHelper new];
    });
    return helper;
}

- (SquareNetworkDelegate *)getSquareDelegate
{
    return [SquareNetworkDelegate squareNetworkDelegate];
}

- (ListNetworkDelegate *)getListDelegate{
    return [ListNetworkDelegate listNetwokDelegate];
}

@end
