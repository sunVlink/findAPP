//
//  ImageTagEntity.h
//  Find1.0
//
//  Created by APPLE on 15/8/31.
//  Copyright (c) 2015年 APPLE. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImageTagEntity : MTLModel

@property (nonatomic, strong) NSNumber *imageTagId;
@property (nonatomic, strong) NSString *imageTitle;
- (instancetype)initWithDic:(NSDictionary *)imageDic;

@end
