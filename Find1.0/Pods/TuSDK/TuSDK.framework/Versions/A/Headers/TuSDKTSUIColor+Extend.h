//
//  TuSDKTSUIColor+Extend.h
//  TuSDK
//
//  Created by Clear Hu on 15/2/18.
//  Copyright (c) 2015年 Lasque. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *  颜色扩展
 */
@interface UIColor(TuSDKTSUIColorExtend)
/**
 *  十六进制转为颜色对象
 *
 *  @param hexString 十六进制字符串 @"#FF5534"
 *
 *  @return 颜色对象 (为空或者错误返回透明)
 */
+ (UIColor *)lsqClorWithHex:(NSString *)hexString;
@end
