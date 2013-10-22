//
//  MapAnnotation.h
//  SydTraffic
//
//  Created by nick on 16/02/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h> 


@interface MapAnnotation : NSObject <MKAnnotation> {
	CLLocationCoordinate2D coordinate; 
	NSString *title;
	NSString *url;
	NSString *desc;

}

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, retain) NSString *url;
@property (nonatomic, retain) NSString *desc;

- (id)initWithCoordinate:(CLLocationCoordinate2D)c title:(NSString *)t url:(NSString *)u desc:(NSString *)d;

@end
