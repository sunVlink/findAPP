//
//  SquareListEntity.m
//  Find1.0
//
//  Created by APPLE on 15/8/27.
//  Copyright (c) 2015年 APPLE. All rights reserved.
//

#import "SquareListEntity.h"
#import "TagEntity.h"
#import "ImageTagEntity.h"


@implementation SquareListEntity

- (instancetype)initWithDictionary:(NSDictionary *)dic
{
    if (self = [super init]) {
        self.author = [[UserEntity alloc] initWithDic:[dic objectForKey:@"author"]];
        self.canLike = [dic objectForKey:@"canLike"];
        self.commentCount = [dic objectForKey:@"commentCount"];
        self.comments = [dic objectForKey:@"comments"];
        self.createDate = [dic objectForKey:@"createDate"];
        self.createMinute = [dic objectForKey:@"createMinute"];
        self.emogjCount = [dic objectForKey:@"emogjCount"];
        self.expireSeconds = [dic objectForKey:@"expireSeconds"];  
        self.likeCount = [dic objectForKey:@"likeCount"];
        self.location = [dic objectForKey:@"location"];
        self.pictureId = [dic objectForKey:@"pictureId"];
        self.pictureTags = [self imageTagData:[dic objectForKey:@"pictureTags"]];
        self.pictureUrl = [dic objectForKey:@"pictureUrl"];
        self.title = [dic objectForKey:@"title"];
    }
    return self;
}

- (NSArray *)parseTagData:(NSArray *)array
{
    NSMutableArray *arr = [NSMutableArray array];
    for (NSDictionary *dic in array) {
        TagEntity *entity =[[TagEntity alloc] initWithDic:dic];
        [arr addObject:entity];
    }
    return arr;
}


- (NSArray *)imageTagData:(NSArray *)array
{
    NSMutableArray *arr = [NSMutableArray array];
    for (NSDictionary *dic in array) {
        ImageTagEntity *entity =[[ImageTagEntity alloc] initWithDic:dic];
        [arr addObject:entity];
    }
    return arr;
}



@end
