//
//  SearchViewController.m
//  NintexFlightSearch
//
//  Copyright (c) 2015 Thong Vu. All rights reserved.
//

#import "SearchViewController.h"

@implementation SearchViewController

@synthesize departureAirportLabel, arrivalAirportLabel, departureDateLabel, returnDateLabel;
@synthesize departureAirportTextfield, arrivalAirportTextfield, departureDateTextfield, returnDateTextfield;
@synthesize departureAirportCode, arrivalAirportCode, departDatePicker, returnDatePicker, dateFormatter, returnDate, departureDate;
@synthesize flightResults, currentItinerary, resultsViewController, activityIndicator, activityItem;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSLocalizedString(@"Flight Search Form", "");
    
    //Labels
    self.departureAirportLabel.text = NSLocalizedString(@"Departure Airport", @"");
    self.arrivalAirportLabel.text = NSLocalizedString(@"Arrival Airport", @"");
    self.departureDateLabel.text = NSLocalizedString(@"Departure Date", @"");
    self.returnDateLabel.text = NSLocalizedString(@"Return Date", @"");
    
    //Text fields
    self.departureAirportTextfield.placeholder = NSLocalizedString(@"e.g MEL", @"");
    self.arrivalAirportTextfield.placeholder = NSLocalizedString(@"e.g LHR", @"");
    self.departureDateTextfield.placeholder = NSLocalizedString(@"select date", @"");
    self.returnDateTextfield.placeholder = NSLocalizedString(@"select date", @"");
    
    self.departureAirportTextfield.delegate = self;
    self.arrivalAirportTextfield.delegate = self;
    self.departureDateTextfield.delegate = self;
    self.returnDateTextfield.delegate = self;
    
    // Date pickers
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    
    self.departDatePicker = [[CustomDateTimePicker alloc] initWithFrame:CGRectMake(0, screenHeight/2 - 35, screenWidth, screenHeight/2 + 35)];
    [self.departDatePicker addTargetForDoneButton:self action:@selector(departDonePressed)];
    [self.departDatePicker addTargetForCancelButton:self action:@selector(departCancelPressed)];
    [self.departDatePicker setMode:UIDatePickerModeDate];
    [self.departDatePicker setMinDate: [NSDate date]];
    [self.departureDateTextfield setInputView: self.departDatePicker];
    
    self.returnDatePicker = [[CustomDateTimePicker alloc] initWithFrame:CGRectMake(0, screenHeight/2 - 35, screenWidth, screenHeight/2 + 35)];
    [self.returnDatePicker addTargetForDoneButton:self action:@selector(returnDonePressed)];
    [self.returnDatePicker addTargetForCancelButton:self action:@selector(returnCancelPressed)];
    [self.returnDatePicker setMode:UIDatePickerModeDate];
    [self.returnDatePicker setMinDate: [NSDate date]];
    [self.returnDateTextfield setInputView: self.returnDatePicker];
    
    self.dateFormatter = [[NSDateFormatter alloc] init];
    [self.dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
    
    // Search button
    UIImage *buttonImage = [[UIImage imageNamed:@"orangeButton.png"]
                            resizableImageWithCapInsets:UIEdgeInsetsMake(18, 18, 18, 18)];
    UIImage *buttonImageHighlight = [[UIImage imageNamed:@"orangeButtonHighlight.png"]
                                     resizableImageWithCapInsets:UIEdgeInsetsMake(18, 18, 18, 18)];
    [self.searchButton setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [self.searchButton setBackgroundImage:buttonImageHighlight forState:UIControlStateHighlighted];
    [self.searchButton setTitle: NSLocalizedString(@"Search", @"") forState:UIControlStateNormal];
    
    // Search activity indicator
    self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.activityIndicator.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
    self.activityItem = [[UIBarButtonItem alloc] initWithCustomView:self.activityIndicator];
    [self.navigationItem setRightBarButtonItem:self.activityItem animated:NO];
    
}

-(void) searchForFlights {
    [self.activityIndicator startAnimating];
    
    NSString* url = @"http://nmflightservice.cloudapp.net/api/Flight";
    
    NSDictionary *params = [[NSDictionary alloc] initWithObjectsAndKeys:
                            self.departureAirportCode, @"DepartureAirportCode",
                            self.arrivalAirportCode, @"ArrivalAirportCode",
                            self.departureDateStr, @"DepartureDate",
                            self.returnDateStr, @"ReturnDate",
                            nil];
    
    /*
    // Sample request data - tested and found not working
    
    NSDictionary *params = [[NSDictionary alloc] initWithObjectsAndKeys:
                            @"MEl", @"DepartureAirportCode",
                            @"LHR", @"ArrivalAirportCode",
                            @"2012-12-24T00:00:00+11:00", @"DepartureDate",
                            @"2013-01-03T00:00:00+11:00", @"ReturnDate",
                            nil];
     */

    [[DataService sharedInstance] makeJSONResquest:url requestParams: params withCompletionHandler:^(NSData *data) {
        // Check if any data returned.
        
        if (data != nil && data.length > 0) {
            self.flightResults = [[NSMutableArray alloc] init];
            
            NSError *error;
            NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
            
            if (error != nil) {
                NSLog(@"%@", [error localizedDescription]);
                [self showErrorWithtitle: NSLocalizedString(@"Data Error", "") message: NSLocalizedString(@"An error has occurred, please try again", "")];
            }
            else{
                
                for(NSDictionary *item in jsonArray) {
                    self.currentItinerary = [[Itinerary alloc] init];
                    self.currentItinerary.itineraryId = [item objectForKey: @"ItineraryId"];
                    self.currentItinerary.airlineLogoAddress = [item objectForKey: @"AirlineLogoAddress"];
                    self.currentItinerary.airlineName = [item objectForKey: @"AirlineName"];
                    self.currentItinerary.inboundFlightsDuration = [item objectForKey: @"InboundFlightsDuration"];
                    self.currentItinerary.outboundFlightsDuration = [item objectForKey: @"OutboundFlightsDuration"];
                    self.currentItinerary.stops = [[item objectForKey: @"Stops"] intValue];
                    self.currentItinerary.totalAmount = [[item objectForKey: @"TotalAmount"] floatValue];
                    
                    [self.flightResults addObject: self.currentItinerary];
                }
            }
            [self.activityIndicator stopAnimating];
            self.resultsViewController = [[ResultsViewController alloc] init];
            resultsViewController.dataArray = self.flightResults;
            [self.navigationController pushViewController:self.resultsViewController animated:YES];
        }
        else {
            [self showErrorWithtitle: NSLocalizedString(@"Data Error", "") message: NSLocalizedString(@"An error has occurred, please try again", "")];
        }
    }];
}

-(void) showErrorWithtitle: (NSString*) title message: (NSString*) message {
    [self.activityIndicator stopAnimating];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle: title message: message delegate:nil cancelButtonTitle:nil otherButtonTitles: NSLocalizedString(@"OK", ""), nil];
    [alert show];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)searchButtonPress:(id)sender {
    if ([self validateDataForSubmit]) {
        [self searchForFlights];
    }
}

#pragma mark UITextFieldDelegate

-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if(textField == self.departureDateTextfield){
        if (self.returnDateStr) {
            [self.departDatePicker setMaxDate: self.returnDate];
        }
    }
    else if(textField == self.returnDateTextfield){
        if (self.departureDateStr) {
            [self.returnDatePicker setMinDate: self.departureDate];
        }
    }
}

-(void) textFieldDidEndEditing:(UITextField *)textField{
    
    if(textField == self.departureAirportTextfield){
        self.departureAirportCode = self.departureAirportTextfield.text;
    }
    else if(textField == self.arrivalAirportTextfield){
        self.arrivalAirportCode = self.arrivalAirportTextfield.text;
    }
}


-(void)departDonePressed {
    self.departureDate = self.departDatePicker.picker.date;
    
    [self.dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZ"];
    self.departureDateStr = [self.dateFormatter stringFromDate: self.departureDate];
    
    [self.dateFormatter setDateFormat:@"dd/MM/yyyy"];
    self.departureDateTextfield.text = [self.dateFormatter stringFromDate: self.departureDate];
    
    [self.departureDateTextfield resignFirstResponder];
}

-(void)departCancelPressed {
    [self.departureDateTextfield resignFirstResponder];
}

-(void)returnDonePressed {
    self.returnDate = self.returnDatePicker.picker.date;
    
    [self.dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZ"];
    self.returnDateStr = [self.dateFormatter stringFromDate: self.returnDate];
    
    [self.dateFormatter setDateFormat:@"dd/MM/yyyy"];
    self.returnDateTextfield.text = [self.dateFormatter stringFromDate: self.returnDate];
    
    [self.returnDateTextfield resignFirstResponder];
}

-(void)returnCancelPressed {
    [self.returnDateTextfield resignFirstResponder];
}

-(BOOL) validateDataForSubmit{
    if ([self.departureAirportTextfield.text length] == 0) {
        [self showErrorWithtitle: NSLocalizedString(@"Input Error", "") message: NSLocalizedString(@"Please enter Departure Airport Textfield.", "")];
        [self.departureAirportTextfield becomeFirstResponder];
        return false;
    }
    else if ([self.arrivalAirportTextfield.text length] == 0) {
        [self showErrorWithtitle: NSLocalizedString(@"Input Error", "") message: NSLocalizedString(@"Please enter Arrival Airport Textfield.", "")];
        [self.arrivalAirportTextfield becomeFirstResponder];
        return false;
    }
    else if ([self.departureDateTextfield.text length] == 0) {
        [self showErrorWithtitle: NSLocalizedString(@"Input Error", "") message: NSLocalizedString(@"Please select Departure Date.", "")];
        [self.departureDateTextfield becomeFirstResponder];
        return false;
    }
    else if ([self.returnDateTextfield.text length] == 0) {
        [self showErrorWithtitle: NSLocalizedString(@"Input Error", "") message: NSLocalizedString(@"Please select Return Date.", "")];
        [self.returnDateTextfield becomeFirstResponder];
        return false;
    }
    
    return true;
}

@end
