//
//  SingleSession.m
//  Find1.0
//
//  Created by APPLE on 15/9/24.
//  Copyright (c) 2015年 APPLE. All rights reserved.
//

#import "SingleSession.h"

@implementation SingleSession

static SingleSession * instance;

+ (SingleSession *) GetInstance{
    @synchronized(self) {
    if (instance == nil ) {
        instance = [[self alloc] init];
      }
    }
    return instance;
}

- (id)init{
    if ( self= [super init]) {
        self.singleUserData = [[NSDictionary alloc]init];
    }
    return self;
}

@end
