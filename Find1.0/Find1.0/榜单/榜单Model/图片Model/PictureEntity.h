//
//  PictureEntity.h
//  Find1.0
//
//  Created by APPLE on 15/9/2.
//  Copyright (c) 2015年 APPLE. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PictureEntity : MTLModel

@property (nonatomic,strong) NSNumber * likeCount;
@property (nonatomic,strong) NSNumber * pictureId;
@property (nonatomic,strong) NSString * pictureUrl;

- (instancetype)initWithDic:(NSDictionary *)dic;

@end
