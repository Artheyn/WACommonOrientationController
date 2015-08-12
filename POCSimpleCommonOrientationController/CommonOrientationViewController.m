//
//  CommonOrientationViewController.m
//  POCSimpleCommonOrientationController
//
//  Created by Alexandre KARST on 24/11/2012.
//  Copyright (c) 2015 Alexandre KARST. All rights reserved.
//

#import "CommonOrientationViewController.h"
#import "CommonPortraitViewController.h"
#import "CommonLandscapeViewController.h"

#pragma mark - (Private) interface

@interface CommonOrientationViewController (Private)

- (void)replaceContentView:(UIViewController *)newViewController;
- (UIViewController *)inactiveViewController;
- (void)handleStatusBarOrientationChanged:(NSNotification *)notification;

@end


#pragma mark - (Public) implementation

@implementation CommonOrientationViewController

@synthesize viewContent;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        boolOrientationChanged = NO;
        /**
         Observe the status bar orientation changes. It's important in two cases :
         - self.view isn't displayed (e.g. we are at n + 1 in a NavigationController hierarchy)
         - when we force an orientation at launch (e.g. landscape) the application takes a
         default orientation (e.g. portrait) before the [window makeKeyAndVisible] (at that moment
         the [self viewDidLoad] method is still called and the portrait/landscape controller constructed)
         is called and after that it adjusts the application orientation without trigger the rotation
         callbacks, so we must retain this change and restablish the good orientation
         controller when viewWillAppear is called.
         **/
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleStatusBarOrientationChanged:) name:@"event_status_bar_orientation_changed" object:nil];
    }
    return self;
}

- (id)initWithBaseName:(NSString *)iBaseName bundle:(NSBundle *)iNibBundleOrNil
{
    // Save the baseName to auto-instantiate the corresponding portrait/landscape controller
    baseName = [iBaseName retain];
    nibBundle = [iNibBundleOrNil retain];
    // Use the default "CommonOrientationViewController" nib
    return [self initWithNibName:@"CommonOrientationViewController" bundle:nibBundle];
}

#pragma mark - Memory management

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"event_status_bar_orientation_changed" object:nil];
    [viewContent release];
    viewControllerCurrent = nil;
    [viewControllerPortrait release];
    [viewControllerLandscape release];
    [baseName release];
    [nibBundle release];
    [super dealloc];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Load the portrait/landscape controller according to the current orientation
    interfaceOrientationCurrent = [[UIApplication sharedApplication] statusBarOrientation];
    if (UIInterfaceOrientationIsPortrait(interfaceOrientationCurrent)) {
        [self replaceContentView:[self viewControllerPortrait]];
    } else {
        [self replaceContentView:[self viewControllerLandscape]];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    /**
     Check orientation changes. It's important in two cases :
     - self.view isn't displayed (e.g. we are at n + 1 in a NavigationController hierarchy)
     - when we force an orientation at launch (e.g. landscape) the application takes a
     default orientation (e.g. portrait) before the [window makeKeyAndVisible] (at that moment
     the [self viewDidLoad] method is still called and the portrait/landscape controller constructed)
     is called and after that it adjusts the application orientation without trigger the rotation
     callbacks, so we must retain this change and restablish the good orientation
     controller when viewWillAppear is called.
     **/
    if (boolOrientationChanged) {
        boolOrientationChanged = NO;
        // Restore the good orientation state
        interfaceOrientationCurrent = [[UIApplication sharedApplication] statusBarOrientation];
        [self replaceContentView:[self inactiveViewController]];
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}


#pragma mark - Portrait/Landscape management

- (CommonPortraitViewController *)viewControllerPortrait
{
    if (!viewControllerPortrait) {
        // Append the baseName with the GenericName PortraitViewController
        // e.g.: baseName=Home -> HomePortraitViewController
        NSString *portraitClassName = [baseName stringByAppendingString:@"PortraitViewController"];
        // Create a class from this string and alloc/init it
        Class PortraitViewController = NSClassFromString(portraitClassName);
        
        if (PortraitViewController) {
            viewControllerPortrait = [[PortraitViewController alloc] initWithNibName:portraitClassName bundle:nibBundle];
        }
    }
    
    return viewControllerPortrait;
}

- (CommonLandscapeViewController *)viewControllerLandscape
{
    if (!viewControllerLandscape) {
        // Append the baseName with the GenericName LandscapeViewController
        // e.g.: baseName=Home -> HomeLandscapeViewController
        NSString *landscapeClassName = [baseName stringByAppendingString:@"LandscapeViewController"];
        // Create a class from this string and alloc/init it
        Class LandscapeViewController = NSClassFromString(landscapeClassName);
        if (LandscapeViewController) {
            viewControllerLandscape = [[LandscapeViewController alloc] initWithNibName:landscapeClassName bundle:nibBundle];
        }
    }
    
    return viewControllerLandscape;
}

#pragma mark - Rotation management

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [super willAnimateRotationToInterfaceOrientation:toInterfaceOrientation duration:duration];
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    [super didRotateFromInterfaceOrientation:fromInterfaceOrientation];
    
    if (boolOrientationChanged) {
        boolOrientationChanged = NO;
        // Swap the portrait/landscape controller with the landscape/portrait controller
        [self replaceContentView:[self inactiveViewController]];
        // Update the current orientation state
        interfaceOrientationCurrent = [[UIApplication sharedApplication] statusBarOrientation];
    }
}

#pragma mark - Orientation management

//- (NSUInteger)supportedInterfaceOrientations
//{
//    return UIInterfaceOrientationMaskLandscape;
//}

@end


#pragma mark - (Private) implementation

@implementation CommonOrientationViewController (Private)

- (void)replaceContentView:(UIViewController *)newViewController
{
    if (viewControllerCurrent != nil) {
        // Remove the current controller view from the contentView
        [viewControllerCurrent willMoveToParentViewController:nil];
        [viewControllerCurrent removeFromParentViewController];
        [[viewControllerCurrent view] removeFromSuperview];
    }
    
    // Adjust frame of the new view controller
    newViewController.view.frame = viewContent.bounds;
    newViewController.view.autoresizingMask = viewContent.autoresizingMask;
    // Add it to the content view
    [self addChildViewController:newViewController];
    [self.viewContent addSubview:newViewController.view];
    [newViewController didMoveToParentViewController:self];
    viewControllerCurrent = newViewController;
}

- (UIViewController *)inactiveViewController
{
    return viewControllerCurrent == (UIViewController*)viewControllerPortrait ? [self viewControllerLandscape] : [self viewControllerPortrait];
}

#pragma mark - (Observer) StatusBarOrientationChanged

/** Used to check the integrity in case of a force orientation at launch **/
// And to replace the good controller when the view isn't currently visible

- (void)handleStatusBarOrientationChanged:(NSNotification *)notification
{
    UIInterfaceOrientation newStatusBarOrientation = [[[notification userInfo] objectForKey:@"new_status_bar_orientation"] intValue];
    
    // Check if the orientation really changed (if we must switch the current controller e.g.: from portrait to landscape)
    boolOrientationChanged = !((UIInterfaceOrientationIsPortrait(interfaceOrientationCurrent) && UIInterfaceOrientationIsPortrait(newStatusBarOrientation)) || (UIInterfaceOrientationIsLandscape(interfaceOrientationCurrent) && UIInterfaceOrientationIsLandscape(newStatusBarOrientation)));
}

@end

