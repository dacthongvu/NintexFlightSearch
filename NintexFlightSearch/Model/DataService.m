//
//  DataService.m
//  NintexFlightSearch
//
//  Copyright (c) 2015 Thong Vu. All rights reserved.
//

#import "DataService.h"

@implementation DataService

+ (DataService*) sharedInstance
{
	static DataService* singleton;
    
	if (!singleton) 
	{
		singleton = [[DataService alloc] init];
		
	}
	return singleton;
}

-(void) makeJSONResquest:(NSString *)url requestParams: (NSDictionary*) params withCompletionHandler:(void (^)(NSData *))completionHandler{
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL: [NSURL URLWithString:url]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:60.0];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    /*
     //Sample request json doesn't work so don't know how to make call to webservice.
     //This is commented out for web service to work (return everything)
     
     NSError *error;
     NSData *requestData = [NSJSONSerialization dataWithJSONObject: params options: kNilOptions error: &error];
     [request setHTTPBody: requestData];
     */
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            completionHandler(data);
        }];
    }];
    
    [task resume];
}

@end
