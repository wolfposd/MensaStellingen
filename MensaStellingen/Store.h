//
//  Store.h
//  MensaStellingen
//
//  Created by wolf on 14.10.15.
//  Copyright © 2015 WP. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Store : NSObject


+(BOOL) isLastFetchToday;

+(void) setLastFetchToday;

+(NSArray*) lastStoredLunch;

+(void) setLastStoredLunch:(NSArray*) lunch;


@end
