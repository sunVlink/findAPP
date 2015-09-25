//
//  PersonalDataViewController.h
//  SquareDemo1.1
//
//  Created by APPLE on 15/7/14.
//  Copyright (c) 2015年 APPLE. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PersonalDataViewController : UIViewController<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic,strong)NSDictionary * userData;

@end
