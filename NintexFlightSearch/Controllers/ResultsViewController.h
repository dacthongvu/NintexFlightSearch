//
//  ResultsViewController.h
//  NintexFlightSearch
//
//  Copyright (c) 2015 Thong Vu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsyncImageView.h"
#import "Itinerary.h"

@interface ResultsViewController : UITableViewController <AsyncImageViewDelegate>

@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) Itinerary *currentItinerary;

@property (nonatomic, strong) IBOutlet UITableViewCell *tableViewCell;
@property (nonatomic, strong) IBOutlet AsyncImageView *itemLogo;
@property (nonatomic, strong) IBOutlet UILabel *labelAirlineName;
@property (nonatomic, strong) IBOutlet UILabel *labelInboundFlightsDuration;
@property (nonatomic, strong) IBOutlet UILabel *labelOutboundFlightsDuration;
@property (nonatomic, strong) IBOutlet UILabel *labelStops;
@property (nonatomic, strong) IBOutlet UILabel *labelTotalAmount;

@end

