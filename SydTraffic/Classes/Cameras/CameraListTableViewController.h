//
//  CameraListTableViewController.h
//  SydTraffic
//
//  Created by Nicolas Triantafillou on 14/09/13.
//  Copyright (c) 2013 Nicolas Triantafillou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CameraListTableViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
    NSDictionary *cameraList;
    IBOutlet UITableView *tableView;
    UIImageView *background;
    IBOutlet UIToolbar *toolBar;
}

- (IBAction)back:(id)sender;
- (IBAction)refresh:(id)sender;


@property (nonatomic, retain) IBOutlet UITableView *tableView;


@end
