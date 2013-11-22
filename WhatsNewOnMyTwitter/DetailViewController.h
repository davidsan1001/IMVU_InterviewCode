//
//  FlipsideViewController.h
//  WhatsNewOnMyTwitter
//
//  Created by David Sanchez on 11/15/13.
//  Copyright (c) 2013 David Sanchez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AddressBookUI/AddressBookUI.h>

@class DetailViewController;

@protocol DetailViewControllerDelegate

- (void)detailViewControllerDidFinish:(DetailViewController *)controller;

- (NSDictionary *)returnSingleTwitterFeed:(DetailViewController *)controller;

@end

@interface DetailViewController : UIViewController <ABPeoplePickerNavigationControllerDelegate>

@property (weak, nonatomic) id <DetailViewControllerDelegate> delegate;
@property (weak, nonatomic)             NSString        *emailAddress;
@property (weak, nonatomic)             NSString        *firstName;
@property (weak, nonatomic)             NSString        *lastName;
@property (weak, nonatomic)             NSString        *phoneNumber;
@property (strong, nonatomic)           NSDictionary    *singleTwitterFeed;

@property (nonatomic, strong) IBOutlet  UITextView      *titleTextView;
@property (nonatomic, strong) IBOutlet  UIWebView       *webView;

- (IBAction)done:(id)sender;
- (IBAction)showAddressBookPicker:(id)sender;

@end
