//
//  TagEntity.m
//  Find1.0
//
//  Created by APPLE on 15/8/27.
//  Copyright (c) 2015年 APPLE. All rights reserved.
//

#import "TagEntity.h"

@implementation TagEntity

- (instancetype)initWithDic:(NSDictionary *)dic
{
    if (self = [super init]) {
        self.tagId = [dic objectForKey:@"tagId"];
        self.title = [dic objectForKey:@"tagName"];
    }
    return self;
}

@end
