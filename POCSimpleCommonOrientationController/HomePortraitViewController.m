//
//  HomePortraitViewController.m
//  POCSimpleCommonOrientationController
//
//  Created by Alexandre KARST on 24/11/2012.
//  Copyright (c) 2015 Alexandre KARST. All rights reserved.
//

#import "HomePortraitViewController.h"
#import "FirstPushedViewController.h"

@interface HomePortraitViewController ()

@end

@implementation HomePortraitViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    NSLog(@"Portrait : %@", self.view);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - User actions

- (IBAction)actionPush:(id)sender {
    FirstPushedViewController *viewControllerFirstPushed = [[FirstPushedViewController alloc] initWithNibName:@"FirstPushedViewController" bundle:nil];
    [[self navigationController] pushViewController:viewControllerFirstPushed animated:YES];
    [viewControllerFirstPushed release];
}

@end
