//
//  FavouritesViewController.h
//  SydTraffic
//
//  Created by Nicolas Triantafillou on 26/09/13.
//  Copyright (c) 2013 Nicolas Triantafillou. All rights reserved.
//

#import <UIKit/UIKit.h>

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



- (IBAction)back:(id)sender;


@end
