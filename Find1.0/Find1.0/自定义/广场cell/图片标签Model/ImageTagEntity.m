//
//  ImageTagEntity.m
//  Find1.0
//
//  Created by APPLE on 15/8/31.
//  Copyright (c) 2015年 APPLE. All rights reserved.
//

#import "ImageTagEntity.h"

@implementation ImageTagEntity

- (instancetype)initWithDic:(NSDictionary *)imageDic
{
    if (self = [super init]) {
        self.imageTagId = [imageDic objectForKey:@"tagId"];
        self.imageTitle = [imageDic objectForKey:@"tagName"];
    }
    return self;
}


@end
