//
//  SharedData.h
//  SydTraffic
//
//  Created by Nicolas Triantafillou on 26/09/13.
//  Copyright (c) 2013 Nicolas Triantafillou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SynthesizeSingleton.h"

@interface SharedData : NSData
{
    NSNumber *bg;
}

@property(nonatomic, retain) NSNumber *bg;

SYNTHESIZE_SINGLETON_FOR_CLASS_HEADER(SharedData);

@end
