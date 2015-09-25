//
//  ListEntity.m
//  Find1.0
//
//  Created by APPLE on 15/9/2.
//  Copyright (c) 2015年 APPLE. All rights reserved.
//

#import "ListEntity.h"
#import "PictureEntity.h"

@implementation ListEntity

- (instancetype)initWithDictionary:(NSDictionary *)dic{
    if (self = [super init]) {
        self.listPicture = [self listPictureData:[dic objectForKey:@"listPicture"]];
        self.tagId = [dic objectForKey:@"tagId"];
        self.tagName = [dic objectForKey:@"tagName"];
    }
    return self;
}

- (NSArray *)listPictureData:(NSArray *)array
{
    NSMutableArray *arr = [NSMutableArray array];
    for (NSDictionary *dic in array) {
        PictureEntity *entity =[[PictureEntity alloc] initWithDic:dic];
        [arr addObject:entity];
    }
    return arr;
}



@end
