//
//  FavouriteInfoViewController.h
//  SydTraffic
//
//  Created by Nicolas Triantafillou on 27/10/2013.
//  Copyright (c) 2013 Nicolas Triantafillou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SharedData.h"

@interface FavouriteInfoViewController : UIViewController {
    UIImageView *background;
    IBOutlet UIToolbar *toolBar;
}

@property (atomic, strong) UIImageView *background;
@property (atomic, strong) IBOutlet UIToolbar *toolBar;


@end
