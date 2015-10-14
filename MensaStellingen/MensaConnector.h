//
//  MensaConnector.h
//  MensaStellingen
//
//  Created by wolf on 14.10.15.
//  Copyright © 2015 WP. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MensaConnector : NSObject

+(NSArray*) parseLunchplan:(NSData*) data;




+(void) fetchLunchplanOnComplete:(void(^)(NSData* data, NSError* error)) completion;




@end
