//
//  AppDelegate.m
//  POCSimpleCommonOrientationController
//
//  Created by Alexandre KARST on 24/11/2012.
//  Copyright (c) 2015 Alexandre KARST. All rights reserved.
//

#import "AppDelegate.h"

#import "CommonOrientationViewController.h"
#import "HomeCommonOrientationViewController.h"

@implementation AppDelegate

- (void)dealloc
{
    [_window release];
    [_viewControllerCommon release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    
    // If we want to test directly the CommonOrientationController
//    self.viewControllerCommon = [[[HomeCommonOrientationViewController alloc] initWithBaseName:@"Home" bundle:nil] autorelease];
//    self.window.rootViewController = self.viewControllerCommon;

    // If we want to test it in a navigation controller.
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:self.viewControllerCommon];
    self.window.rootViewController = navigationController;
    [navigationController release];
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

#pragma mark - (Delegate) UIApplicationDelegate


/** Used to check the integrity in case of a force orientation at launch **/

- (void)application:(UIApplication *)application willChangeStatusBarOrientation:(UIInterfaceOrientation)newStatusBarOrientation duration:(NSTimeInterval)duration
{
    
    // Catching the status bar orientation changes and submit to the observers.
    NSDictionary *dictionaryInfo = [[NSDictionary alloc] initWithObjectsAndKeys:[NSNumber numberWithInt:newStatusBarOrientation],@"new_status_bar_orientation", nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"event_status_bar_orientation_changed" object:self userInfo:dictionaryInfo];
    
    [dictionaryInfo autorelease];
}

@end
