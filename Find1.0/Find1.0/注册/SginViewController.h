//
//  SginViewController.h
//  SquareDemo1.1
//
//  Created by APPLE on 15/7/7.
//  Copyright (c) 2015年 APPLE. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SginViewController : UIViewController<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

- (void)chooseImage:(id)sender;

@property (retain, nonatomic)UIImageView *imageView;


@end
