//
//  ResultsViewController.m
//  NintexFlightSearch
//
//  Copyright (c) 2015 Thong Vu. All rights reserved.
//

#import "ResultsViewController.h"

@implementation ResultsViewController

@synthesize dataArray, currentItinerary, tableView, itemLogo, labelAirlineName, labelInboundFlightsDuration, labelOutboundFlightsDuration, labelStops, labelTotalAmount;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSLocalizedString(@"Flight Search Results", @"");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark  UITableView Datasouce & Delegate Methods

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}

- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}


-(NSString*) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @"";
}

-(NSString*) tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
    return @"";
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return ([self.dataArray count] > 0) ? [self.dataArray count] : 1;
}

-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell;
    
    if (indexPath.row == 0 && [self.dataArray count] == 0) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
        cell.backgroundColor = [[UIColor alloc]initWithRed:229.0/255.0 green:229.0/255.0 blue:229.0/255.0 alpha:1];
        cell.textLabel.text = NSLocalizedString(@"No items to display!", @"");
        cell.textLabel.textColor = [UIColor darkGrayColor];
    }
    else {
        self.currentItinerary = [self.dataArray objectAtIndex: indexPath.row];
        
        cell = [self.tableView dequeueReusableCellWithIdentifier:@"CellIdentifier"];
        
        if (cell == nil){
            [[NSBundle mainBundle] loadNibNamed: @"TableCellView" owner:self options:nil];
            cell = self.tableViewCell;
        }
        
        if (indexPath.row % 2) {
            cell.backgroundColor = [[UIColor alloc]initWithRed:230.0/255.0 green:230.0/255.0 blue:230.0/255.0 alpha:1];
        } else {
            cell.backgroundColor = [[UIColor alloc]initWithRed:210.0/255.0 green:210.0/255.0 blue:210.0/255.0 alpha:1];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.labelAirlineName.text = self.currentItinerary.airlineName;
        self.labelInboundFlightsDuration.text = self.currentItinerary.inboundFlightsDuration;
        self.labelOutboundFlightsDuration.text = self.currentItinerary.outboundFlightsDuration;
        self.labelStops.text = self.currentItinerary.stops;
        self.labelTotalAmount.text = self.currentItinerary.totalAmount;
        
        if (self.currentItinerary.airlineLogoAddress.length > 0){
            self.itemLogo.imageUrl = [NSURL URLWithString: self.currentItinerary.airlineLogoAddress];
            self.itemLogo.userData = indexPath;
            self.itemLogo.delegate = self;
            [self.itemLogo startLoading];
        }
        else {
            self.itemLogo.image = [UIImage imageNamed: @"NoImage.png"];
        }
    }
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

#pragma mark AWAsyncImageView Delegate

-(void) didFinishLoadingImage:(UIImage *)image UserData:(id)userdata{
    
}

@end
