//
//  SquareListEntity.h
//  Find1.0
//
//  Created by APPLE on 15/8/27.
//  Copyright (c) 2015年 APPLE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserEntity.h"

@interface SquareListEntity : MTLModel

@property (nonatomic, strong) UserEntity *author;
@property (nonatomic, strong) NSNumber *canLike; 
@property (nonatomic, strong) NSNumber *commentCount;
@property (nonatomic, strong) NSArray *comments;
@property (nonatomic, strong) NSString *createDate;
@property (nonatomic, strong) NSNumber *createMinute;
@property (nonatomic, strong) NSNumber *emogjCount;
@property (nonatomic, strong) NSNumber *expireSeconds;    //图片消失时间
@property (nonatomic, strong) NSNumber *likeCount;
@property (nonatomic, strong) NSString *location;
@property (nonatomic, strong) NSNumber *pictureId;
@property (nonatomic, strong) NSArray  *pictureTags;
@property (nonatomic, strong) NSString *pictureUrl;
@property (nonatomic, strong) NSString *title;


- (instancetype)initWithDictionary:(NSDictionary *)dic;


@end
