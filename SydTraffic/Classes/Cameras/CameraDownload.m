//
//  CameraDownload.m
//  SydTraffic
//
//  Created by Nicolas Triantafillou on 16/10/13.
//  Copyright (c) 2013 Nicolas Triantafillou. All rights reserved.
//

#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0) //1
#define kLatestCamerasURL [NSURL URLWithString:@"http://triso.me/sydtraffic/cams.json"] //confirmed working
#define kLatestCamerasURLRMS [NSURL URLWithString:@"http://triso.me/sydtraffic/traffic-cam.json"] //RMS camera list (requires wget)


#import "CameraDownload.h"


@implementation CameraDownload

-(id)init
{
    
    return self;
    
}

-(void)getFeed
{
    [SVProgressHUD showWithStatus:@"Updating camera list from RMS"];

    dispatch_async(kBgQueue, ^{
        NSData* data = [NSData dataWithContentsOfURL:
                        kLatestCamerasURL];
        [self performSelectorOnMainThread:@selector(fetchedData:)
                               withObject:data waitUntilDone:YES];
    });

}

- (void)fetchedData:(NSData *)responseData {
    //parse out the json data
    NSError* error;
    NSDictionary* json = [NSJSONSerialization
                          JSONObjectWithData:responseData //1
                          
                          options:kNilOptions
                          error:&error];
    
    NSArray* latestCams = [json objectForKey:@"features"]; //2
    
    NSMutableDictionary *allCameras = [[NSMutableDictionary alloc] init];
    
    for (int x=0; x<[latestCams count]; x++)
    {
        
        NSDictionary *cam = [latestCams objectAtIndex:x];
        
        NSDictionary *geom = [cam objectForKey:@"geometry"];
        NSArray *coords = [geom objectForKey:@"coordinates"];
        NSNumber *lon = [coords objectAtIndex:0];
        NSNumber *lat = [coords objectAtIndex:1];
        
        NSDictionary *camprops = [cam objectForKey:@"properties"];
        
        NSString *camname = [camprops objectForKey:@"title"];
        NSString *camdesc = [camprops objectForKey:@"view"];
        NSString *camurl  = [camprops objectForKey:@"href"];
        NSString *region =  [camprops objectForKey:@"region"];
        
        
        [allCameras setObject:camdesc forKey:camname];

        
        NSDictionary *thisCamera =
        @{
                        @"name" : camname,
                        @"desc" : camdesc,
                        @"url"  : camurl,
                        @"region" : region,
                        @"lon" : lon,
                        @"lat" : lat
        };
        
        [allCameras setObject:thisCamera forKey:camname];
    }

    // NSLog(@"at the end of all stuff theres %d cameras", [allCameras count]);
    
    
    //  NSLog(@"random camera name: %@", [[allCameras objectForKey:[keyArray objectAtIndex:1]] objectForKey:@"name"]);

    // write to file
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:@"C.plist"];
    [allCameras writeToFile:filePath atomically:YES];
    NSLog(@"wrote new file");
    
    [SVProgressHUD showSuccessWithStatus:@"Camera list updated!"];


    
}
@end
