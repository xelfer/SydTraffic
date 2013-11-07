//
//  CameraListTableViewController.m
//  SydTraffic
//
//  Created by Nicolas Triantafillou on 14/09/13.
//  Copyright (c) 2013 Nicolas Triantafillou. All rights reserved.
//

#import "CameraListTableViewController.h"
#import "SharedData.h"
#import "CameraViewController.h"
#import "CameraDownload.h"

@interface CameraListTableViewController ()

@end

@implementation CameraListTableViewController
@synthesize tableView, cameraList, background, toolBar;

- (void)refreshDisplay:(UITableView *)tableView
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:@"C.plist"];
    cameraList = [NSDictionary dictionaryWithContentsOfFile:filePath];
    
    // if it's nil, there was no file, load from the provided
    if (cameraList == nil)
    {
        NSLog(@"this shouldn't happen at all, we should have a file if we got this far");
        cameraList = [[NSMutableDictionary alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Cameras" ofType:@"plist"]];
    } else {
        NSLog(@"loaded new data from file");
    }
    [self.tableView reloadData];
    
}


- (IBAction)back:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (IBAction)refresh:(id)sender
{
    CameraDownload *cd = [CameraDownload alloc];
    [cd getFeed];
    
    // refresh with a delay
    [self performSelector:(@selector(refreshDisplay:)) withObject:(tableView) afterDelay:2.0];

    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // put a transparent image under the status bar to make it translucent but tinted
    UIImageView *coverStatus = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 20)];
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
    
    // make the tableview the delegate for the uitableviewcontroller
    [tableView setDelegate:self];
    [tableView setDataSource:self];
    
    // set the transparency on the table and toolbars
    [tableView setBackgroundColor:[UIColor clearColor]];
    [toolBar setBackgroundColor:[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.8]];
    
    // gets rid of the top 1px white border above the toolbar
    toolBar.clipsToBounds = YES;
    
    // is there a new camera list file? (generated when refresh is first hit)
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:@"C.plist"];
    cameraList = [NSMutableDictionary dictionaryWithContentsOfFile:filePath];

    // if it's nil, there was no file, load from the provided and write it to the file
    if (cameraList == nil)
    {
        // only used once ever until reinstall
        cameraList = [[NSMutableDictionary alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Cameras" ofType:@"plist"]];
        [cameraList writeToFile:filePath atomically:YES];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int SYD_MET = 0;    int SYD_SOUTH = 0;
    int SYD_WEST = 0;   int SYD_NORTH = 0;
    int REG_SOUTH = 0;
    NSArray *keyArray = [cameraList allKeys];
    
    for (int x=0; x<[cameraList count]; x++)
    {
        NSString *tmpregion = [[cameraList objectForKey:[keyArray objectAtIndex:x]] objectForKey:@"region"];
        
        if ([tmpregion isEqualToString:@"SYD_MET"])
        {
            SYD_MET++;
        } else if ([tmpregion isEqualToString:@"SYD_SOUTH"])
        {
            SYD_SOUTH++;
        } else if ([tmpregion isEqualToString:@"SYD_NORTH"])
        {
            SYD_NORTH++;
        } else if ([tmpregion isEqualToString:@"SYD_WEST"])
        {
            SYD_WEST++;
        } else if ([tmpregion isEqualToString:@"REG_SOUTH"])
        {
            REG_SOUTH++;
        }
    }
    
    int intSection = section;
    int returnval = 0;
    
    switch (intSection) {
        case 0:
            returnval = SYD_MET;
            break;
        case 1:
            returnval = SYD_SOUTH;
            break;
        case 2:
            returnval = SYD_NORTH;
            break;
        case 3:
            returnval = SYD_WEST;
            break;
        case 4:
            returnval = REG_SOUTH;
            break;
    }
    
    return returnval;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [self->tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
	
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    
    // iterate through the dictionary
    // find the region (indexPath.section)
    // iterate through regions until you find the indexPath.row'th occurrance
    int rowfound = -1;
    NSString *lookingforregion;
    
    switch (indexPath.section) {
        case 0:
            lookingforregion = [NSString stringWithFormat:@"SYD_MET"];
            break;
        case 1:
            lookingforregion = [NSString stringWithFormat:@"SYD_SOUTH"];
            break;
        case 2:
            lookingforregion = [NSString stringWithFormat:@"SYD_NORTH"];
            break;
        case 3:
            lookingforregion = [NSString stringWithFormat:@"SYD_WEST"];
            break;
        case 4:
            lookingforregion = [NSString stringWithFormat:@"REG_SOUTH"];
            break;
    }
    
    NSArray *keyArray = [cameraList allKeys];
    NSDictionary *tmpcamera;

    for (int x=0; x<[cameraList count]; x++) {
        tmpcamera = [cameraList objectForKey:[keyArray objectAtIndex:x]];
        if ([[tmpcamera objectForKey:@"region"] isEqualToString:lookingforregion]) {
            rowfound++;
            if (rowfound == indexPath.row) {
                cell.textLabel.text = [tmpcamera objectForKey:@"name"];
                break;
            }
        }
    }
    
    return cell;
}

// transparent cells


- (void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.backgroundColor = [[UIColor alloc] initWithRed:0.0 green:0.0 blue:0.0 alpha:0.4];
    cell.textLabel.textColor = [UIColor whiteColor];
}


- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.bounds.size.width, 30)];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 3, self.tableView.bounds.size.width - 10, 18)];
    
    int intSection = section;
    NSString *returnval;

    switch (intSection) {
        case 0:
            returnval = [NSString stringWithFormat:@"Inner Sydney"];
            break;
        case 1:
            returnval = [NSString stringWithFormat:@"Sydney South"];
            break;
        case 2:
            returnval = [NSString stringWithFormat:@"Sydney North"];
            break;
        case 3:
            returnval = [NSString stringWithFormat:@"Sydney West"];
            break;
        case 4:
            returnval = [NSString stringWithFormat:@"Regional South"];
            break;
    }
    
    label.text = returnval;
    label.textColor = [UIColor whiteColor];
    
    [headerView setBackgroundColor:[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.8]];
    label.backgroundColor = [UIColor clearColor];//[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.5];
    
    [headerView addSubview:label];
    
    return headerView;
}

-(UIStatusBarStyle) preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"camview" sender:self];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"camview"])
    {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        CameraViewController *destViewController = [segue destinationViewController];

        
        int rowfound = -1;
        NSString *lookingforregion;
        
        switch (indexPath.section) {
            case 0:
                lookingforregion = [NSString stringWithFormat:@"SYD_MET"];
                break;
            case 1:
                lookingforregion = [NSString stringWithFormat:@"SYD_SOUTH"];
                break;
            case 2:
                lookingforregion = [NSString stringWithFormat:@"SYD_NORTH"];
                break;
            case 3:
                lookingforregion = [NSString stringWithFormat:@"SYD_WEST"];
                break;
            case 4:
                lookingforregion = [NSString stringWithFormat:@"REG_SOUTH"];
                break;
        }
        
        NSArray *keyArray = [cameraList allKeys];
        //NSDictionary *tmpcamera = [cameraList objectForKey:[keyArray objectAtIndex:indexPath.row]];
        NSDictionary *tmpcamera;
        
        for (int x=0; x<[cameraList count]; x++) {
            tmpcamera = [cameraList objectForKey:[keyArray objectAtIndex:x]];
            if ([[tmpcamera objectForKey:@"region"] isEqualToString:lookingforregion]) {
                rowfound++;
                if (rowfound == indexPath.row) {
                    destViewController.thetitle = [tmpcamera objectForKey:@"name"];
                    destViewController.theurl = [tmpcamera objectForKey:@"url"];
                    destViewController.thedesc = [tmpcamera objectForKey:@"desc"];

                    break;
                }
            }
        }

    }
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSIndexPath *indexPath = [tableView indexPathForSelectedRow];
    [tableView reloadData];
    if(indexPath) {
        [tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    }
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    NSIndexPath *indexPath = [tableView indexPathForSelectedRow];
    if(indexPath) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
    
}

@end