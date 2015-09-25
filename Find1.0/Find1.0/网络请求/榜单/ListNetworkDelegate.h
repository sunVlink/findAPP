//
//  ListNetworkDelegate.h
//  Find1.0
//
//  Created by APPLE on 15/9/2.
//  Copyright (c) 2015年 APPLE. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ListNetworkDelegate : NSObject

+ (ListNetworkDelegate *)listNetwokDelegate;

- (void)getListData:(NSString *)url params:(id)params success:(void(^)(id result))success fail:(void(^)(NSString* result))fail;

@end
