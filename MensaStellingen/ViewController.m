//
//  ViewController.m
//  MensaStellingen
//
//  Created by wolf on 14.10.15.
//  Copyright © 2015 WP. All rights reserved.
//

#import "ViewController.h"
#import "MensaConnector.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    
    [MensaConnector fetchLunchplanOnComplete:^(NSData* data, NSError* error)
     {
         if(error)
         {
             NSLog(@"%@", error);
         }
         else
         {
             NSArray* result = [MensaConnector parseLunchplan:data];
             NSLog(@"%@", result);
         }
         
     }];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
