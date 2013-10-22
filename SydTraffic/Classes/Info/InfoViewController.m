//
//  InfoViewController.m
//  SydTraffic
//
//  Created by Nicolas Triantafillou on 13/09/13.
//  Copyright (c) 2013 Nicolas Triantafillou. All rights reserved.
//

#import "InfoViewController.h"
#import "SharedData.h"

@interface InfoViewController ()

@end

@implementation InfoViewController


- (IBAction)back:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (IBAction)emailMe:(id)sender {
	NSString *emailSubject = [NSString stringWithFormat:@"Feedback for SydTraffic %@",[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]];
	NSString *emailURL = [NSString stringWithFormat:@"mailto:nick@triso.me?subject=%@",[emailSubject stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
	
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:emailURL]];
    NSLog(@"emailing");
    
}



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
    
    [versiontext setText:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]];

    UIImageView *coverStatus = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    coverStatus.image = [UIImage imageNamed:@"trans50.png"];
    [self.view addSubview:coverStatus];
    [self.view sendSubviewToBack:coverStatus];
    
    // set the background
    background = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0,
                                                              [UIScreen mainScreen].bounds.size.width,
                                                              [UIScreen mainScreen].bounds.size.height)];
    
    // fill the image from the top, to suit 3.5 inch devices
    [background setContentMode:UIViewContentModeScaleAspectFill];
    background.image = [UIImage imageNamed:[NSString stringWithFormat:@"bg%@.jpg",[SharedData sharedInstance].bg]];
    [self.view addSubview:background];
    [self.view sendSubviewToBack:background];
    
    [toolBar setBackgroundColor:[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.8]];
    
    
    // gets rid of the top 1px white border above the toolbar
    toolBar.clipsToBounds = YES;
    
  }

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(UIStatusBarStyle) preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

@end
