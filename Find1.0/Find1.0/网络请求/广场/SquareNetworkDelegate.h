//
//  SquareNetworkDelegate.h
//  Find1.0
//
//  Created by APPLE on 15/8/27.
//  Copyright (c) 2015年 APPLE. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SquareNetworkDelegate : NSObject

+ (SquareNetworkDelegate *)squareNetworkDelegate;

- (void)getSquareListData:(NSString *)url params:(id)params success:(void(^)(id result))success fail:(void(^)(NSString* result))fail;

@end
