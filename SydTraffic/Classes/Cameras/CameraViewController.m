//
//  CameraViewController.m
//  SydTraffic
//
//  Created by Nicolas Triantafillou on 3/10/13.
//  Copyright (c) 2013 Nicolas Triantafillou. All rights reserved.
//

#import "CameraViewController.h"
#import "SharedData.h"
#import "UIImageView+AFNetworking.h"


@interface CameraViewController ()

@end

@implementation CameraViewController

@synthesize t, thetitle, thedesc, theurl;

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

- (IBAction)refresh:(id)sender
{
    [self updateTrafficImage];
}

- (IBAction)fave:(id)sender
{
   
    NSMutableDictionary *cameraList;
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSString *favpath = [documentsDirectory stringByAppendingPathComponent:@"F.plist"];
    
    // load the favourite list, or create the array if it's empty
	NSMutableDictionary *favList;
    favList = [[NSMutableDictionary alloc] initWithContentsOfFile:favpath];
    if ([favList count] == 0)
    {
		favList = [[NSMutableDictionary alloc] init];
	}
    
    // load the camera list
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:@"C.plist"];
    cameraList = [NSMutableDictionary dictionaryWithContentsOfFile:filePath];

    NSArray *keyArray = [favList allKeys];
    // if it's in favourites, remove it
    for (int favcount=0; favcount < [keyArray count]; favcount++)
    {
        if ([[[favList objectForKey:[keyArray objectAtIndex:favcount]] objectForKey:@"name"] isEqualToString:t.text]) {
            
			[favList removeObjectForKey:[keyArray objectAtIndex:favcount]];
			[favList writeToFile:favpath atomically:YES];
            [fave setImage:[UIImage imageNamed:@"unfave.png"]];

            return;
        }
    
    }
    
    // if we're this far, it's not in favourites, add it
    NSArray *camkeyArray = [cameraList allKeys];
    NSDictionary *tmpcamera;
    NSString *n; NSString *d; NSString *u; NSString *la; NSString *lo; NSString *r;

    // find the camera we want to add to favourites.
    for (int x=0; x<[cameraList count]; x++) {
        tmpcamera = [cameraList objectForKey:[camkeyArray objectAtIndex:x]];
        if ([[tmpcamera objectForKey:@"name"] isEqualToString:t.text]) {
            n = [tmpcamera objectForKey:@"name"];
            d = [tmpcamera objectForKey:@"desc"];
            u = [tmpcamera objectForKey:@"url"];
            la = [tmpcamera objectForKey:@"lat"];
            lo = [tmpcamera objectForKey:@"lon"];
            r = [tmpcamera objectForKey:@"region"];
            x=[cameraList count];
        }
    }
    
    // add dictionary to dictionary, write to disk
    NSDictionary *thisCamera =
    @{
      @"name" : n,
      @"desc" : d,
      @"url"  : u,
      @"region" : r,
      @"lon" : lo,
      @"lat" : la
      };
    
    //int key = [favList count] + 1;
    NSDate *today = [NSDate date];
    
    NSLog(@"the date is %@", today);
    NSString *datekey = [NSString stringWithFormat:@"%@", today];
    
    [favList setObject:thisCamera forKey:datekey];
	[favList writeToFile:favpath atomically:YES];
    [fave setImage:[UIImage imageNamed:@"fave.png"]];
    
}

- (void) updateTrafficImage
{
    [i setImageWithURL:[NSURL URLWithString:self.theurl] placeholderImage:[UIImage imageNamed:@"trans.png"]];
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
    background = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0,
                                                              [UIScreen mainScreen].bounds.size.width,
                                                              [UIScreen mainScreen].bounds.size.height)];
    
    // fill the image from the top, to suit 3.5 inch devices
    [background setContentMode:UIViewContentModeScaleAspectFill];
    background.image = [UIImage imageNamed:[NSString stringWithFormat:@"bg%@.jpg",[SharedData sharedInstance].bg]];
    [self.view addSubview:background];
    [self.view sendSubviewToBack:background];
    
    [toolBar setBackgroundColor:[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.5]];
    
    // gets rid of the top 1px white border above the toolbar
    toolBar.clipsToBounds = YES;
    
    desc.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"trans50.png"]];
    t.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"trans50.png"]];
    
    t.text = thetitle;
    desc.text = thedesc;
    
    // if it's already favourited, set reload button, otherwise fav
    
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSString *path = [documentsDirectory stringByAppendingPathComponent:@"F.plist"];
	NSDictionary *favList;
    
	favList = [[NSDictionary alloc] initWithContentsOfFile:path];
    
    NSArray *keyArray = [favList allKeys];
    
    int found=0;
    for (int favcount=0; favcount < [keyArray count]; favcount++)
    {
        if ([[[favList objectForKey:[keyArray objectAtIndex:favcount]] objectForKey:@"name"] isEqualToString:t.text]) {
            [fave setImage:[UIImage imageNamed:@"fave.png"]];
            found=1;
        }
    }
    
    if (!found) {
        [fave setImage:[UIImage imageNamed:@"unfave.png"]];
        
    }
    
    [self updateTrafficImage];

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
