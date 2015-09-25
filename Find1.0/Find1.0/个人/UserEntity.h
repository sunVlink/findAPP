//
//  UserEntity.h
//  Find1.0
//
//  Created by APPLE on 15/8/27.
//  Copyright (c) 2015年 APPLE. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserEntity : MTLModel

@property (nonatomic, strong) NSNumber *age;   
@property (nonatomic, strong) NSString *avatar;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSNumber *gender;
@property (nonatomic, strong) NSString *nickName;
@property (nonatomic, strong) NSNumber *userId;
@property (nonatomic, strong) NSArray *userTags;

- (instancetype)initWithDic:(NSDictionary *)dic;

@end
