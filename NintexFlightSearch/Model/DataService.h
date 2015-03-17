//
//  DataService.h
//  NintexFlightSearch
//
//  Copyright (c) 2015 Thong Vu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataService : NSObject

+ (DataService*) sharedInstance;

- (void) makeJSONResquest:(NSString *)url requestParams: (NSDictionary*) params withCompletionHandler:(void (^)(NSData *))completionHandler;

@end
