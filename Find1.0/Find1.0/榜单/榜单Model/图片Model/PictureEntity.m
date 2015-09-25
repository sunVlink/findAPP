//
//  PictureEntity.m
//  Find1.0
//
//  Created by APPLE on 15/9/2.
//  Copyright (c) 2015年 APPLE. All rights reserved.
//

#import "PictureEntity.h"


@implementation PictureEntity

- (instancetype)initWithDic:(NSDictionary *)dic{
    if (self = [super init]) {
        self.likeCount = [dic objectForKey:@"likeCount"];
        self.pictureId = [dic objectForKey:@"pictureId"];
        self.pictureUrl = [dic objectForKey:@"pictureUrl"];
    }
    return self;
}



@end
