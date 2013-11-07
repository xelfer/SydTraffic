//
//  FavouriteInfoViewController.m
//  SydTraffic
//
//  Created by Nicolas Triantafillou on 27/10/2013.
//  Copyright (c) 2013 Nicolas Triantafillou. All rights reserved.
//

#import "FavouriteInfoViewController.h"

@interface FavouriteInfoViewController ()

@end

@implementation FavouriteInfoViewController

@synthesize background, toolBar;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (IBAction)back:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(UIStatusBarStyle) preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    // put a transparent image under the status bar to make it translucent but tinted
    UIImageView *coverStatus = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    coverStatus.image = [UIImage imageNamed:@"trans50.png"];
    [self.view addSubview:coverStatus];
    [self.view sendSubviewToBack:coverStatus];
    
    // set the background
    self.background = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0,
                                                                   [UIScreen mainScreen].bounds.size.width,
                                                                   [UIScreen mainScreen].bounds.size.height)];
    
    // fill the image from the top, to suit 3.5 inch devices
    [self.background setContentMode:UIViewContentModeScaleAspectFill];
    self.background.image = [UIImage imageNamed:[NSString stringWithFormat:@"bg%@.jpg",[SharedData sharedInstance].bg]];
    [self.view addSubview:background];
    [self.view sendSubviewToBack:background];
    
    [self.toolBar setBackgroundColor:[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.8]];
    
    // gets rid of the top 1px white border above the toolbar
    self.toolBar.clipsToBounds = YES;
    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
