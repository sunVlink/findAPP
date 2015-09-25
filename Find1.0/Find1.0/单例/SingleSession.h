//
//  SingleSession.h
//  Find1.0
//
//  Created by APPLE on 15/9/24.
//  Copyright (c) 2015年 APPLE. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SingleSession : NSObject

@property (nonatomic,strong) NSDictionary * singleUserData;
+ (SingleSession *) GetInstance;

@end
