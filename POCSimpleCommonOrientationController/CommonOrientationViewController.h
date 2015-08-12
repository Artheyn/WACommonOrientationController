//
//  CommonOrientationViewController.h
//  POCSimpleCommonOrientationController
//
//  Created by Alexandre KARST on 24/11/2012.
//  Copyright (c) 2015 Alexandre KARST. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CommonPortraitViewController;
@class CommonLandscapeViewController;

@interface CommonOrientationViewController : UIViewController {
    // View that will contain the portrait/landscape view
    UIView *viewContent;
    
    // Portrait/Landscape viewController management
    UIViewController *viewControllerCurrent;
    CommonPortraitViewController *viewControllerPortrait;
    CommonLandscapeViewController *viewControllerLandscape;
    NSString *baseName;
    NSBundle *nibBundle;
    
    // To know if the orientation has been changed according the current interface orientation
    BOOL boolOrientationChanged;
    UIInterfaceOrientation interfaceOrientationCurrent;
}

@property(nonatomic,retain) IBOutlet UIView *viewContent;


- (id)initWithBaseName:(NSString *)iBaseName bundle:(NSBundle *)iNibBundleOrNil;

@end
