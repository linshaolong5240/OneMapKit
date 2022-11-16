//
//  OMKAppDelegate.m
//  OneMapKit
//
//  Created by Sauron on 11/16/2022.
//  Copyright (c) 2022 linshaolong5240. All rights reserved.
//

#import "OMKAppDelegate.h"
#import <OneMapKit/OneMapKit.h>
#import "OMKDemoViewController.h"

@implementation OMKAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    OMKConfig *mapConfig = [[OMKConfig alloc] init];
    mapConfig.aMapKey = @"6b84213157c7640fd007c800ac20ecf4";
    mapConfig.baiduMapKey = @"qCfINkbXjt4D2PwngcczywFRHjvqcM7b";
    mapConfig.tencentMapKey = @"6LDBZ-OG3C6-7GGSW-EPAJH-NN6S5-3JFVQ";
    
    //高德地图
    [[OMKAManager sharesInstance] setApiKey:@"6b84213157c7640fd007c800ac20ecf4"];
    [[OMKAManager sharesInstance] setPrivacyAgreement:YES];
    
    //百度地图
    [[OMKBManager sharesInstance] setApiKey:@"qCfINkbXjt4D2PwngcczywFRHjvqcM7b"];
    [[OMKBManager sharesInstance] setPrivacyAgreement:YES];
    
    //腾讯地图
    [[OMKQManager sharesInstance] setApiKey:@"6LDBZ-OG3C6-7GGSW-EPAJH-NN6S5-3JFVQ"];
    [[OMKQManager sharesInstance] setPrivacyAgreement:YES];
    
    self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    self.window.backgroundColor = UIColor.whiteColor;
    UIViewController *rootViewController = [[UINavigationController alloc] initWithRootViewController:[[OMKDemoViewController alloc] init]];
    self.window.rootViewController = rootViewController;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
