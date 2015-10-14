//
//  MensaConnector.m
//  MensaStellingen
//
//  Created by wolf on 14.10.15.
//  Copyright © 2015 WP. All rights reserved.
//

#import "MensaConnector.h"
#import "HTMLReader.h"
#import "HTMLTextNode.h"


#define STELLINGEN_MENSA_URL @"http://speiseplan.studierendenwerk-hamburg.de/de/580/2015/0/"

@implementation MensaConnector






+(NSArray*) parseLunchplan:(NSData*) data
{
    NSMutableArray* result = [NSMutableArray new];
    
    HTMLDocument* document = [HTMLDocument documentWithString:[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]];
    NSArray* tableRows = [document nodesMatchingSelector:@"tr"];
    

    NSError* error = nil;
    NSArray* regexes = @[
                         [NSRegularExpression regularExpressionWithPattern:@"[^\\p{Alpha}- ]*" options:NSRegularExpressionCaseInsensitive error:&error],
                         [NSRegularExpression regularExpressionWithPattern:@"[ ]{2,}" options:NSRegularExpressionCaseInsensitive error:&error]
                         ];
    
    
    for(HTMLElement* tr in tableRows)
    {
        if(tr.attributes[@"id"])
            continue;
        
        for(HTMLElement* child in tr.childElementNodes)
        {
            if([child.attributes[@"class"] isEqual:@"dish-description"])
            {
                NSString* description = [NSMutableString new];
                
                for(id textNodeOrElement in child.children)
                {
                    
                    if( [[textNodeOrElement class] isSubclassOfClass:[HTMLTextNode class] ])
                    {
                        //NSLog(@"%@", @"is sublcass");
                        HTMLTextNode* textNode = textNodeOrElement;
                        [(NSMutableString*)description appendString:textNode.textContent];
                    }
                }
                
                description = [regexes[0] stringByReplacingMatchesInString:description options:kNilOptions range:NSMakeRange(0, description.length)
                                                              withTemplate:@""] ;
                description = [regexes[1] stringByReplacingMatchesInString:description options:kNilOptions range:NSMakeRange(0, description.length)
                                                              withTemplate:@" "];
                description = [description stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
                
                
                [result addObject:description];
            }
        }
    }
    
    
    return result;
}




+(void) fetchLunchplanOnComplete:(void(^)(NSData* data, NSError* error)) completion
{
    NSURL* url = [NSURL URLWithString:STELLINGEN_MENSA_URL];
    NSURLRequest* req = [NSURLRequest requestWithURL:url];
    
    NSOperationQueue* q = [NSOperationQueue new];
    [NSURLConnection sendAsynchronousRequest:req queue:q completionHandler:
     ^(NSURLResponse* response, NSData* data, NSError* error)
     {
         if(data)
         {
             completion(data,nil);
         }
         else
         {
             completion(nil,error);
         }
     }];
    
}

@end
