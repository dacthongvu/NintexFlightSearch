//
//  Itinerary.h
//  NintexFlightSearch
//
//  Copyright (c) 2015 Thong Vu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Itinerary : NSObject  {

}

@property (nonatomic, strong) NSString *itineraryId;
@property (nonatomic, strong) NSString *airlineLogoAddress;
@property (nonatomic, strong) NSString *airlineName;
@property (nonatomic, strong) NSString *inboundFlightsDuration;
@property (nonatomic, strong) NSString *outboundFlightsDuration;
@property (atomic, assign) int stops;
@property (atomic, assign) float totalAmount;


@end
