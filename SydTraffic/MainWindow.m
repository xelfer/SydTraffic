//
//  ViewController.m
//  SydTraffic
//
//  Created by Nicolas Triantafillou on 21/09/13.
//  Copyright (c) 2013 Nicolas Triantafillou. All rights reserved.
//

#import "MainWindow.h"
#import "TestFlight.h"
#import "SharedData.h"

@interface MainWindow ()

@end


@implementation MainWindow
@synthesize blackbox, background;

- (void)viewDidLoad
{
    // testflight
    [TestFlight takeOff:@"cc277be4-e73a-44a8-a2e3-e661a99e4400"];

    // set random wallpaper
    background = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0,
                                                                [UIScreen mainScreen].bounds.size.width,
                                                                [UIScreen mainScreen].bounds.size.height)];
    
    // fill the image from the top, to suit 3.5 inch devices
    [background setContentMode:UIViewContentModeScaleAspectFill];
    
    [self refresh:nil];

    [self.view addSubview:background];
    [self.view sendSubviewToBack:background];

}


-(IBAction)refresh:(id)sender
{
    [SharedData sharedInstance].bg = [NSNumber numberWithInt:1+arc4random_uniform(13)];
    background.image = [UIImage imageNamed:[NSString stringWithFormat:@"bg%@.jpg",[SharedData sharedInstance].bg]];
    NSLog(@"bg is %@", [SharedData sharedInstance].bg);
}

-(UIStatusBarStyle) preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
