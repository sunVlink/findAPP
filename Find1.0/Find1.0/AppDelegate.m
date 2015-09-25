//
//  AppDelegate.m
//  Find1.0
//
//  Created by APPLE on 15/8/22.
//  Copyright (c) 2015年 APPLE. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
//    if(![[NSUserDefaults standardUserDefaults] boolForKey:@"firstLaunch"]){
//        
//        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstLaunch"];
//        [[NSUserDefaults standardUserDefaults] synchronize];
//        
//        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isTourist"];
//        [[NSUserDefaults standardUserDefaults] synchronize];
//        NSLog(@"第一次启动");
//        
//    }else{
//        NSLog(@"已经不是第一次启动了");
//    }

    
  
    RootViewController * viewVC =[RootViewController new];
    UINavigationController * rootVC = [[UINavigationController alloc]initWithRootViewController:viewVC];
    self.window.rootViewController = rootVC;
    
    //    设置状态栏颜色为白色
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
