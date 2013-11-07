//
//  CameraViewController.h
//  SydTraffic
//
//  Created by Nicolas Triantafillou on 3/10/13.
//  Copyright (c) 2013 Nicolas Triantafillou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SharedData.h"
#import "UIImageView+AFNetworking.h"
#import "SVProgressHUD.h"

@interface CameraViewController : UIViewController
{
    UIImageView *background;
    IBOutlet UIToolbar *toolBar;
    IBOutlet UILabel *desc;
    IBOutlet UILabel *t;
    IBOutlet UIImageView *i;
    IBOutlet UIBarButtonItem *fave;
    IBOutlet UIBarButtonItem *refresh;

@public
    NSString *thetitle;
    NSString *theurl;
    NSString *thedesc;
   
}

- (IBAction)refresh:(id)sender;


@property (nonatomic, strong) IBOutlet UILabel *t;
@property (nonatomic, strong) IBOutlet UIImageView *i;
@property (nonatomic, strong) IBOutlet UIBarButtonItem *fave;
@property (nonatomic, strong) IBOutlet UILabel *desc;
@property (nonatomic, strong) IBOutlet UIToolbar *toolBar;
@property (nonatomic, strong) UIImageView *background;

@property (nonatomic, strong) IBOutlet NSString *thetitle;
@property (nonatomic, strong) IBOutlet NSString *theurl;
@property (nonatomic, strong) IBOutlet NSString *thedesc;
@property (nonatomic, strong) IBOutlet UIBarButtonItem *refresh;





@end
