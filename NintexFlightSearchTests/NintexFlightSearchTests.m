//
//  NintexFlightSearchTests.m
//  NintexFlightSearchTests
//
//  Created by AppsWiz on 16/03/2015.
//  Copyright (c) 2015 Thong Vu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "SearchViewController.h"
#import "ResultsViewController.h"
//
//  NintexFlightSearchTests.m
//  NintexFlightSearch
//
//  Copyright (c) 2015 Thong Vu. All rights reserved.
//

@interface NintexFlightSearchTests : XCTestCase

@property (nonatomic) SearchViewController *searchVc;
@property (nonatomic) ResultsViewController *resultsVc;

@end

@implementation NintexFlightSearchTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    self.searchVc = [[SearchViewController alloc] init];
    self.searchVc.departureAirportCode = @"MEl";
    self.searchVc.arrivalAirportCode = @"LHR";
    self.searchVc.departureDateStr = @"2012-12-24T00:00:00+11:00";
    self.searchVc.returnDateStr = @"2013-01-03T00:00:00+11:00";
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testSearchForFlightsPerformance {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
        [self.searchVc searchForFlights];
    }];
}

@end
