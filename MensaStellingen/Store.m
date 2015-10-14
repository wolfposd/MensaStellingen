//
//  Store.m
//  MensaStellingen
//
//  Created by wolf on 14.10.15.
//  Copyright © 2015 WP. All rights reserved.
//

#import "Store.h"

@implementation Store



+(BOOL) isLastFetchToday
{
    NSLog(@"%@", @"Store isLastFetchToday");
    NSDate* lastFetch = [[NSUserDefaults standardUserDefaults] objectForKey:@"lastfetch"];
    
    
    if(!lastFetch)
        return NO;
    else
    {
        NSDate* now = [NSDate date];
        return [self isSameDayWithDate1:now date2:lastFetch];
    }
}

+(BOOL)isSameDayWithDate1:(NSDate*)date1 date2:(NSDate*)date2
{
    NSCalendar* calendar = [NSCalendar currentCalendar];
    
    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay;
    NSDateComponents* comp1 = [calendar components:unitFlags fromDate:date1];
    NSDateComponents* comp2 = [calendar components:unitFlags fromDate:date2];
    
    return [comp1 day]   == [comp2 day] &&
    [comp1 month] == [comp2 month] &&
    [comp1 year]  == [comp2 year];
}



+(void) setLastFetchToday
{
    NSLog(@"%@", @"Store setLastFetchToday");
    [[NSUserDefaults standardUserDefaults] setObject:[NSDate date] forKey:@"lastfetch"];
}

+(NSArray*) lastStoredLunch
{
    NSLog(@"%@", @"Store lastStoredLunch");
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"lunch"];
}

+(void) setLastStoredLunch:(NSArray*) lunch
{
    NSLog(@"%@", @"Store setLastStoredLunch");
    [[NSUserDefaults standardUserDefaults] setObject:lunch forKey:@"lunch"];
}


@end
