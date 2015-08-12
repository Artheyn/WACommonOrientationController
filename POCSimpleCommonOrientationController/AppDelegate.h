//
//  AppDelegate.h
//  POCSimpleCommonOrientationController
//
//  Created by Alexandre KARST on 24/11/2012.
//  Copyright (c) 2015 Alexandre KARST. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HomeCommonOrientationViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) HomeCommonOrientationViewController *viewControllerCommon;

@end