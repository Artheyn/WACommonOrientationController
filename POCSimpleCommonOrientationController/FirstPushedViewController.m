//
//  FirstPushedViewController.m
//  POCSimpleCommonOrientationController
//
//  Created by Alexandre KARST on 24/11/2012.
//  Copyright (c) 2015 Alexandre KARST. All rights reserved.
//

#import "FirstPushedViewController.h"
#import "SecondPushedCommonOrientationViewController.h"

@interface FirstPushedViewController ()

@end

@implementation FirstPushedViewController

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

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)actionPush:(id)sender
{
    SecondPushedCommonOrientationViewController *commonSecondPushed = [[SecondPushedCommonOrientationViewController alloc] initWithBaseName:@"SecondPushed" bundle:nil];
    [self.navigationController pushViewController:commonSecondPushed animated:YES];
    [commonSecondPushed release];
}

@end
