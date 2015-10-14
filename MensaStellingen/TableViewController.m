//
//  TableViewController.m
//  MensaStellingen
//
//  Created by wolf on 14.10.15.
//  Copyright © 2015 WP. All rights reserved.
//

#import "TableViewController.h"
#import "Store.h"
#import "MensaConnector.h"

@interface TableViewController ()

@property (nonatomic,retain) NSArray* items;


@end

@implementation TableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    self.title = @"Mensa Stellingen";
    
    [self prepareContent];
    
}

-(void) prepareContent
{
    if([Store isLastFetchToday])
    {
        NSLog(@"%@", @"loading store from storage");
        self.items = [Store lastStoredLunch];
        [self.tableView reloadData];
    }
    else
    {
        [MensaConnector fetchLunchplanOnComplete:^(NSData* data, NSError* error)
         {
             if(!error)
             {
                 NSLog(@"%@", @"fetched stuff no error");
                 NSArray* result = [MensaConnector parseLunchplan:data];
                 
                 [Store setLastFetchToday];
                 [Store setLastStoredLunch:result];
                 
                 self.items = result;
             }
             else
             {
                 self.items = @[@"Error fetching stuff", error.description];
             }
             [self.tableView reloadData];
             
         }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.items.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"normal" forIndexPath:indexPath];
    
    
    cell.textLabel.text = self.items[indexPath.row];
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
