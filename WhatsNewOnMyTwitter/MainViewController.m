//
//  MainViewController.m
//  WhatsNewOnMyTwitter
//
//  Created by David Sanchez on 11/15/13.
//  Copyright (c) 2013 David Sanchez. All rights reserved.
//

#import "MainViewController.h"
#import "math.h"
#import "WebServiceRequest.h"

@interface MainViewController ()


@end

@implementation MainViewController

@synthesize slider, sliderLabel, sliderValue;
@synthesize twitterFeedsArray, twitterResultTable;
@synthesize previousSliderDate, previousSliderValue;
@synthesize singleTwitterFeed;
@synthesize secondsUntilRefresh, timer;

- (void)viewDidLoad
{
    [super viewDidLoad];
    previousSliderValue = 6;
    secondsUntilRefresh = 600;
}

-(void)viewDidAppear:(BOOL)animated {
    previousSliderDate = [[NSDate alloc]init];
    [self fetch:nil];
    [timer invalidate];
     timer = [NSTimer scheduledTimerWithTimeInterval: secondsUntilRefresh
                                              target: self
                                            selector: @selector(fetchTimer:)
                                            userInfo: nil repeats: YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Detail View Controller

- (void)detailViewControllerDidFinish:(DetailViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (NSDictionary *)returnSingleTwitterFeed:(DetailViewController *)controller
{
    return singleTwitterFeed;
}

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
    self.detailPopoverController = nil;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSLog(@"we are getting inside the prepare for seque method");
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSLog(@"we are getting inside isEqualToString");
        [[segue destinationViewController] setDelegate:self];
    }
}

- (IBAction)togglePopover:(id)sender
{
    if (self.detailPopoverController) {
        [self.detailPopoverController dismissPopoverAnimated:YES];
        self.detailPopoverController = nil;
    } else {
        [self performSegueWithIdentifier:@"showDetail" sender:sender];
    }
}

#pragma mark - UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [twitterFeedsArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    NSDictionary *thisTwitterFeed = [twitterFeedsArray objectAtIndex:indexPath.row];
    cell.textLabel.text = [thisTwitterFeed objectForKey:@"text"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    singleTwitterFeed = [twitterFeedsArray objectAtIndex:indexPath.row];
    
    NSLog(@"!!!just before seque is called!!!");
    [self performSegueWithIdentifier:@"showDetail" sender:self];
}

#pragma mark - iOSRequestDelegate

-(void)fetchAddress:(NSString *)address
{
    NSLog(@"Loading Address: %@",address);
    [WebServiceRequest requestPath:address onCompletion:^(NSString *result, NSError *error){
        dispatch_async(dispatch_get_main_queue(), ^{
            if (!error) {
                // No Error
                [self stopFetching:result];
            } else {
                // Handle Error
                NSLog(@"ERROR: %@",error);
                [self stopFetching:@"Failed to Load"];
            }
        });
    }];
}

- (IBAction)fetch:(id)sender
{

    NSLog(@"start fetching: %@", [self getCurrentDateTimeString]);
    NSString *path = @"https://alpha-api.app.net/stream/0/posts/stream/global";
    [self startFetching];
    [self fetchAddress:path];
}

-(void) fetchTimer:(NSTimer*) t
{
    NSLog(@"start timer fetching: %@", [self getCurrentDateTimeString]);
    NSString *path = @"https://alpha-api.app.net/stream/0/posts/stream/global";
    [self startFetching];
    [self fetchAddress:path];
}

-(void)startFetching
{
    NSLog(@"Fetching...");
}

-(void)stopFetching:(NSString *)result
{
    NSLog(@"Done Fetching!");
    NSError *err = nil;
    NSDictionary *resultDictionary = [NSJSONSerialization JSONObjectWithData:[result dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:&err];
    
    twitterFeedsArray = [resultDictionary objectForKey:@"data"];
    
//    NSLog(@"twitterFeedsArray: %@", twitterFeedsArray);
//    NSLog(@"#twitterFeedsArray: %d", twitterFeedsArray.count);
    
    [self.twitterResultTable reloadData];
    
}

-(IBAction)sliderValueChanged:(UISlider *)sender {
    
    float numberToRound;
    
    numberToRound = sender.value *10;
    
    sliderValue = roundf(numberToRound);
    
    NSInteger changeSliderValue = abs(sliderValue - previousSliderValue);
    
    previousSliderValue = sliderValue;
    
    NSString *resultAsString;
    
    switch (sliderValue) {
        case 0:
            resultAsString = @"10 sec.";
            secondsUntilRefresh = 10;
            break;
        case 1:
            resultAsString = @"30 sec.";
            secondsUntilRefresh = 30;
            break;
        case 2:
            resultAsString = @"1 min.";
            secondsUntilRefresh = 60;
            break;
        case 3:
            resultAsString = @"2 min.";
            secondsUntilRefresh = 120;
            break;
        case 4:
            resultAsString = @"3 min.";
            secondsUntilRefresh = 180;
            break;
        case 5:
            resultAsString = @"5 min.";
            secondsUntilRefresh = 300;
            break;
        case 6:
            resultAsString = @"10 min.";
            secondsUntilRefresh = 600;
            break;
        case 7:
            resultAsString = @"20 min.";
            secondsUntilRefresh = 1200;
            break;
        case 8:
            resultAsString = @"30 min.";
            secondsUntilRefresh = 1800;
            break;
        case 9:
            resultAsString = @"1 hr.";
            secondsUntilRefresh = 3600;
            break;
        case 10:
            resultAsString = @"6 hr.";
            secondsUntilRefresh = 21600;
            break;
        default:
            break;
    }
    
    if ( changeSliderValue > 0) {
        NSLog(@"CHANGED!");
        sliderLabel.text = [NSString stringWithFormat:@"%@ refresh interval",resultAsString];
        [self viewDidAppear:YES];
        
    }
    
}

-(NSString *)getCurrentDateTimeString {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateStyle:NSDateFormatterShortStyle];
    
    [dateFormatter setTimeStyle:NSDateFormatterMediumStyle];
    
    NSDate *date = [NSDate new];
    
    NSString *formattedDateString = [dateFormatter stringFromDate:date];
    
    return formattedDateString;
}

@end
