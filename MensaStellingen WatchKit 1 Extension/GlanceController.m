//
//  GlanceController.m
//  MensaStellingen WatchKit 1 Extension
//
//  Created by wolf on 14.10.15.
//  Copyright © 2015 WP. All rights reserved.
//

#import "GlanceController.h"
#import "LabelRowController.h"


@interface GlanceController()

@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceTable *table;

@end


@implementation GlanceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];

    // Configure interface objects here.
    NSDictionary* appData = @{@"fetch":@YES};
    
    [WKInterfaceController openParentApplication:appData reply:
     ^(NSDictionary *replyInfo, NSError *error)
     {
         NSArray* result = replyInfo[@"result"];
         NSLog(@"got result in glance: %@", result);
         
         [self populateTable:result];
     }];
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
    
    
    
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}


-(void) populateTable:(NSArray*) result
{
    NSLog(@"%@", @"populating glance view");
    [self.table setNumberOfRows:result.count withRowType:@"LabelRowController"];
    for(int i=0; i < result.count; i++)
    {
        LabelRowController* labelrow= [self.table rowControllerAtIndex:i];
        [labelrow.textLabel setText: result[i]];
        
    }
}

@end



