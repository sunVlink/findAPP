//
//  ListEntity.h
//  Find1.0
//
//  Created by APPLE on 15/9/2.
//  Copyright (c) 2015年 APPLE. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ListEntity : MTLModel

@property (nonatomic,strong) NSArray * listPicture;
@property (nonatomic,strong) NSNumber * tagId;
@property (nonatomic,strong) NSString * tagName;

- (instancetype)initWithDictionary:(NSDictionary *)dic;

@end
