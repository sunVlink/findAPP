//
//  TagEntity.h
//  Find1.0
//
//  Created by APPLE on 15/8/27.
//  Copyright (c) 2015年 APPLE. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TagEntity : MTLModel

@property (nonatomic, strong) NSNumber *tagId;
@property (nonatomic, strong) NSString *title;
- (instancetype)initWithDic:(NSDictionary *)dic;

@end
