//
//  MapViewController.m
//  SydTraffic
//
//  Created by Nicolas Triantafillou on 13/09/13.
//  Copyright (c) 2013 Nicolas Triantafillou. All rights reserved.
//

#import "MapViewController.h"
#import "CameraViewController.h"

@interface MapViewController ()

@end

@implementation MapViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (IBAction)back:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)location:(id)sender
{
    CLLocationCoordinate2D location;
	MKCoordinateRegion region;
	MKCoordinateSpan span;
	span.latitudeDelta = 0.1;
	span.longitudeDelta = 0.1;
	region.span = span;
	location = mapView.userLocation.location.coordinate;
	region.center = location;
	[mapView setRegion:region animated:YES];
	[mapView regionThatFits:region];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    mapView.delegate = self;
    
    [toolBar setBackgroundColor:[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.5]];

    mapView.showsUserLocation = YES;

    // default position covering all sydney cams
	CLLocationCoordinate2D defaultcoord;
	defaultcoord.latitude = -33.634059;
	defaultcoord.longitude = 151.085358;
    
	mapView.region = MKCoordinateRegionMakeWithDistance(defaultcoord, 80000, 80000);
    
    
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:@"C.plist"];
    NSDictionary *cameraList = [NSMutableDictionary dictionaryWithContentsOfFile:filePath];
    
    // if it's nil, there was no file, load from the provided and write it to the file
    if (cameraList == nil)
    {
        // should only used once ever until reinstall
        cameraList = [[NSMutableDictionary alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Cameras" ofType:@"plist"]];
        [cameraList writeToFile:filePath atomically:YES];
    }

    
    
    
    //NSMutableArray *cameraList = [[NSMutableArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Cameras" ofType:@"plist"]];
    
    // iterate through our camera list and add the annotations to the map
    
    
    
    NSArray *keyArray = [cameraList allKeys];
    NSDictionary *tmpcamera;
    for (int x=0; x<[cameraList count]; x++) {
        tmpcamera = [cameraList objectForKey:[keyArray objectAtIndex:x]];
        CGFloat latDelta = [[tmpcamera objectForKey:@"lat"] floatValue];
        CGFloat longDelta= [[tmpcamera objectForKey:@"lon"] floatValue];
        CLLocationCoordinate2D newCoord = {latDelta,longDelta};
        MapAnnotation* annotation = [[MapAnnotation alloc] initWithCoordinate:newCoord
                                       title:[tmpcamera objectForKey:@"name"]
                                       url:[tmpcamera objectForKey:@"url"]
                                       desc:[tmpcamera objectForKey:@"desc"]
                                     ];
        [mapView addAnnotation:annotation];

    }

}

-(MKAnnotationView *)mapView:(MKMapView *)mV viewForAnnotation:(id <MKAnnotation>)annotation
{
	MKPinAnnotationView *pinView = nil;
	if(annotation != mapView.userLocation)
	{
		static NSString *defaultPinID = @"com.invasivecode.pin";
		pinView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:defaultPinID];
        
		if ( pinView == nil ) {
            pinView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:defaultPinID];
            pinView.canShowCallout = YES;
            pinView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
            
        } else {
            pinView.annotation = annotation;
        }
	
    }
	
    return pinView;
}


- (void)mapView:(MKMapView *)emapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
	
    if (view.annotation == emapView.userLocation)
        return;
    
	mapannotation = (MapAnnotation*)view.annotation;
    
	
	//if (cameraViewController == nil) {
	//	cameraViewController = [[CameraViewController alloc] initWithNibName:@"CameraViewController" bundle:[NSBundle mainBundle]];
	//} else {
	//	[cameraViewController.cameraImage setImage:nil];
	//}
	
	//[cameraViewController set:mapannotation.url withTitle:mapannotation.title withDesc:mapannotation.desc];
	//[self.navigationController pushViewController:cameraViewController animated:YES];
	//cameraViewController.ct.text = mapannotation.desc;
    
    //[self performSegueWithIdentifier:@"camview" sender:self];
    [self performSegueWithIdentifier:@"camview" sender:self];

    
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"camview"])
    {
        CameraViewController *destViewController = [segue destinationViewController];
        
        
        destViewController.thetitle = mapannotation.title;
        destViewController.thedesc = mapannotation.desc;
        destViewController.theurl = mapannotation.url;
        
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
