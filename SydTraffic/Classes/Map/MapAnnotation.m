//
//  MapAnnotation.m
//  SydTraffic
//
//  Created by nick on 16/02/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MapAnnotation.h"


@implementation MapAnnotation

@synthesize coordinate, title, url, desc;

- (id)initWithCoordinate:(CLLocationCoordinate2D)c title:(NSString *)t url:(NSString *)u desc:(NSString *)d 
{
	self = [super init];
	coordinate = c;
	url = u;
	title = t;
	desc = d;
	return self;
}


@end
