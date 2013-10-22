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


@property (retain, strong) IBOutlet UIToolbar *toolBar;
@property (retain, strong) UIImageView *background;
@property (retain, strong) IBOutlet UICollectionView *collection;
@property (retain, strong) NSMutableDictionary *faveList;
@property (retain, strong) NSIndexPath *ip;
@property (retain, strong) IBOutlet UILabel *label;
@property (retain, strong) IBOutlet UIImageView *image;
@property (retain, strong) IBOutlet UIView *smallview;

- (IBAction)back:(id)sender;


@end
