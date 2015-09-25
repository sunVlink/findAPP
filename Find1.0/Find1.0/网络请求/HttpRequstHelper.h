//
//  HttpRequstHelper.h
//  Find1.0
//
//  Created by APPLE on 15/8/27.
//  Copyright (c) 2015年 APPLE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SquareNetworkDelegate.h"
#import "ListNetworkDelegate.h"
#import "WebRequest.h"

@interface HttpRequstHelper : NSObject

+ (instancetype)sharedInstance;

- (SquareNetworkDelegate *)getSquareDelegate;
- (ListNetworkDelegate *)getListDelegate;

@end
