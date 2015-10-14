//
//  InterfaceController.m
//  MensaStellingen WatchKit 1 Extension
//
//  Created by wolf on 14.10.15.
//  Copyright © 2015 WP. All rights reserved.
//

#import "InterfaceController.h"
#import "LabelRowController.h"


@interface InterfaceController()
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceTable *table;
@end


@implementation InterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];

    // Configure interface objects here.
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
    
    
    NSDictionary* appData = @{@"fetch":@YES};
    
    [WKInterfaceController openParentApplication:appData reply:
     ^(NSDictionary *replyInfo, NSError *error)
     {
         NSArray* result = replyInfo[@"result"];
         NSLog(@"got result: %@", result);
         
         [self populateTable:result];
     }];
    
    
}

-(void) populateTable:(NSArray*) result
{
    [self.table setNumberOfRows:result.count withRowType:@"LabelRowController"];
    for(int i=0; i < result.count; i++)
    {
        LabelRowController* labelrow= [self.table rowControllerAtIndex:i];
        [labelrow.textLabel setText: result[i]];
        
    }
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

@end



