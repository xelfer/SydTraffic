//
//  FavouritesViewController.h
//  SydTraffic
//
//  Created by Nicolas Triantafillou on 26/09/13.
//  Copyright (c) 2013 Nicolas Triantafillou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LXReorderableCollectionViewFlowLayout.h"

@interface FavouritesViewController : UIViewController <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
{
    IBOutlet UIToolbar *toolBar;
    UIImageView *background;
    IBOutlet UICollectionView *collection;
    NSMutableDictionary *faveList;
    NSIndexPath *ip;
    IBOutlet UILabel *label;
    IBOutlet UIImageView *image;
    IBOutlet UIView *smallview;
}


@property (atomic, strong) IBOutlet UIToolbar *toolBar;
@property (atomic, strong) UIImageView *background;
@property (atomic, strong) IBOutlet UICollectionView *collection;
@property (atomic, strong) NSMutableDictionary *faveList;
@property (atomic, strong) NSIndexPath *ip;
@property (atomic, strong) IBOutlet UILabel *label;
@property (atomic, strong) IBOutlet UIImageView *image;
@property (atomic, strong) IBOutlet UIView *smallview;

- (IBAction)back:(id)sender;


@end
