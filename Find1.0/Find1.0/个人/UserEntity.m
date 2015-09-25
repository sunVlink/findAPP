//
//  UserEntity.m
//  Find1.0
//
//  Created by APPLE on 15/8/27.
//  Copyright (c) 2015年 APPLE. All rights reserved.
//

#import "UserEntity.h"
#import "TagEntity.h"

@implementation UserEntity

- (instancetype)initWithDic:(NSDictionary *)dic
{
    if (self = [super init]) {
        self.age = [dic objectForKey:@"age"];
        self.avatar = [dic objectForKey:@"avatar"];
        self.city = [dic objectForKey:@"city"];
        self.gender = [dic objectForKey:@"gender"];
        self.nickName = [dic objectForKey:@"nickName"];
        self.userId = [dic objectForKey:@"userId"];
        self.userTags = [self parseTagData:[dic objectForKey:@"userTags"]];
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



@end
