//
//  SearchViewController.h
//  NintexFlightSearch
//
//  Copyright (c) 2015 Thong Vu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Itinerary.h"
#import "ResultsViewController.h"
#import "CustomDateTimePicker.h"
#import "DataService.h"

@interface SearchViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UILabel *departureAirportLabel;
@property (weak, nonatomic) IBOutlet UILabel *arrivalAirportLabel;
@property (weak, nonatomic) IBOutlet UILabel *departureDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *returnDateLabel;


@property (weak, nonatomic) IBOutlet UITextField *departureAirportTextfield;
@property (weak, nonatomic) IBOutlet UITextField *arrivalAirportTextfield;
@property (weak, nonatomic) IBOutlet UITextField *departureDateTextfield;
@property (weak, nonatomic) IBOutlet UITextField *returnDateTextfield;

@property (weak, nonatomic) IBOutlet UIButton *searchButton;
- (IBAction)searchButtonPress:(id)sender;

@property (nonatomic, strong) NSMutableArray *flightResults;
@property (nonatomic, strong) Itinerary *currentItinerary;
@property (nonatomic, strong) ResultsViewController *resultsViewController;

@property (nonatomic, strong) CustomDateTimePicker *departDatePicker;
@property (nonatomic, strong) CustomDateTimePicker *returnDatePicker;
@property (nonatomic, strong) NSDateFormatter *dateFormatter;

@property (nonatomic, strong) NSString *departureAirportCode;
@property (nonatomic, strong) NSString *arrivalAirportCode;
@property (nonatomic, strong) NSString *departureDateStr;
@property (nonatomic, strong) NSString *returnDateStr;
@property (nonatomic, strong) NSDate *departureDate;
@property (nonatomic, strong) NSDate *returnDate;

@property (nonatomic, strong) UIBarButtonItem *activityItem;
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;

-(void) searchForFlights;

@end

