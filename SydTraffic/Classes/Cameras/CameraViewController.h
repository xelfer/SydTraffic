//
//  CameraViewController.h
//  SydTraffic
//
//  Created by Nicolas Triantafillou on 3/10/13.
//  Copyright (c) 2013 Nicolas Triantafillou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CameraViewController : UIViewController
{
    UIImageView *background;
    IBOutlet UIToolbar *toolBar;
    IBOutlet UILabel *desc;
    IBOutlet UILabel *t;
    IBOutlet UIImageView *i;
    IBOutlet UIBarButtonItem *fave;

@public
    NSString *thetitle;
    NSString *theurl;
    NSString *thedesc;
   
}

- (IBAction)refresh:(id)sender;


@property (nonatomic, strong) UILabel *t;
@property (nonatomic, strong) NSString *thetitle;
@property (nonatomic, strong) NSString *theurl;
@property (nonatomic, strong) NSString *thedesc;


@end
