//
//  MainViewController.h
//  WhatsNewOnMyTwitter
//
//  Created by David Sanchez on 11/15/13.
//  Copyright (c) 2013 David Sanchez. All rights reserved.
//

#import "DetailViewController.h"


@interface MainViewController : UIViewController <DetailViewControllerDelegate, UIPopoverControllerDelegate, UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) UIPopoverController *detailPopoverController;
@property (nonatomic)                   NSDate          *previousSliderDate;
@property (nonatomic)                   NSInteger       previousSliderValue;

@property (nonatomic)                   NSInteger       secondsUntilRefresh;
@property (strong, nonatomic)           NSDictionary    *singleTwitterFeed;
@property (nonatomic, strong) IBOutlet  UISlider        *slider;
@property (nonatomic, strong) IBOutlet  UILabel         *sliderLabel;
@property (nonatomic)                   NSInteger       sliderValue;
@property (nonatomic, strong)           NSTimer*        timer;
@property (strong, nonatomic)           NSArray         *twitterFeedsArray;
@property (nonatomic, strong) IBOutlet  UITableView     *twitterResultTable;

-(IBAction)sliderValueChanged:(UISlider *)sender;


@end
