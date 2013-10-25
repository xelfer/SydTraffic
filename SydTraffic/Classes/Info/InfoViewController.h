//
//  InfoViewController.h
//  SydTraffic
//
//  Created by Nicolas Triantafillou on 13/09/13.
//  Copyright (c) 2013 Nicolas Triantafillou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InfoViewController : UIViewController
{
    UIImageView *background;
    IBOutlet UIToolbar *toolBar;
    IBOutlet UILabel *versiontext;
}

- (IBAction)back:(id)sender;
- (IBAction)emailMe:(id)sender;

@property (atomic, strong) UIImageView *background;
@property (atomic, strong) IBOutlet UIToolbar *toolBar;
@property (atomic, strong) IBOutlet UILabel *versiontext;

@end
