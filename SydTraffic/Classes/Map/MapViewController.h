//
//  MapViewController.h
//  SydTraffic
//
//  Created by Nicolas Triantafillou on 13/09/13.
//  Copyright (c) 2013 Nicolas Triantafillou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "MapAnnotation.h"

@interface MapViewController : UIViewController <MKMapViewDelegate>
{
    IBOutlet MKMapView *mapView;
    IBOutlet UIToolbar *toolBar;
    MapAnnotation *mapannotation;
}

- (IBAction)back:(id)sender;
- (IBAction)location:(id)sender;


@end
