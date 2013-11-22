//
//  DetailViewController.m
//  WhatsNewOnMyTwitter
//
//  Created by David Sanchez on 11/15/13.
//  Copyright (c) 2013 David Sanchez. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

@synthesize singleTwitterFeed;
@synthesize titleTextView;
@synthesize webView;
@synthesize firstName, lastName, phoneNumber, emailAddress;

- (void)awakeFromNib
{
    self.preferredContentSize = CGSizeMake(320.0, 480.0);
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    singleTwitterFeed = [self.delegate returnSingleTwitterFeed:self];
    NSLog(@"singleTwitterFeed: %@", singleTwitterFeed);
    [titleTextView sizeToFit];
    titleTextView.text = [singleTwitterFeed objectForKey:@"text"];
    
    NSDictionary *entities = [singleTwitterFeed objectForKey:@"entities"];
    
//    NSLog(@"entities: %@", entities);
    
    NSDictionary *links = [entities objectForKey:@"links"];
    
    NSLog(@"links: %@", links);
    
//    id urlDict = [links objectForKey:@"url"];
    
//    NSLog(@"url: %@", urlDict);
    
    NSString *fullURL = [singleTwitterFeed objectForKey:@"canonical_url"];
    
    NSLog(@"fullURL: %@", fullURL);
    
    NSURL *url = [NSURL URLWithString:fullURL];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    [webView loadRequest:requestObj];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions

- (IBAction)done:(id)sender
{
    [self.delegate detailViewControllerDidFinish:self];
}

#pragma mark - Address Book Methods

- (IBAction)showAddressBookPicker:(id)sender
{
    ABPeoplePickerNavigationController *picker = [[ABPeoplePickerNavigationController alloc] init];
    picker.peoplePickerDelegate = self;
    [self presentViewController:picker animated:YES completion:nil];
}

- (void)peoplePickerNavigationControllerDidCancel: (ABPeoplePickerNavigationController *)peoplePicker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker
      shouldContinueAfterSelectingPerson:(ABRecordRef)person
{
    NSLog(@"peoplePickerNavigationController");
    
    firstName = (__bridge NSString *)ABRecordCopyValue(person, kABPersonFirstNameProperty);
    lastName = (__bridge NSString *)ABRecordCopyValue(person, kABPersonLastNameProperty);
    
    NSMutableArray *phoneNumbers = [[NSMutableArray alloc] init];
    ABMultiValueRef multiPhones = ABRecordCopyValue(person,kABPersonPhoneProperty);
    for(CFIndex i=0;i<ABMultiValueGetCount(multiPhones);++i) {
        CFStringRef phoneNumberRef = ABMultiValueCopyValueAtIndex(multiPhones, i);
        phoneNumber = (__bridge NSString *) phoneNumberRef;
        [phoneNumbers addObject:phoneNumber];
    }
    
    NSMutableArray *emails = [[NSMutableArray alloc] init];
    ABMultiValueRef multiEmails = ABRecordCopyValue(person,kABPersonEmailProperty);
    for(CFIndex i=0;i<ABMultiValueGetCount(multiEmails);++i) {
        CFStringRef emailRef = ABMultiValueCopyValueAtIndex(multiEmails, i);
        emailAddress = (__bridge NSString *) emailRef;
        [emails addObject:emailAddress];
    }
    
    NSLog(@"firstName: %@", firstName);
    NSLog(@"lastName: %@", lastName);
    NSLog(@"emailAddress: %@", [emails objectAtIndex:0]);
    NSLog(@"phoneNumber: %@", [phoneNumbers objectAtIndex:0]);
    
    [self dismissViewControllerAnimated:YES completion:^{[self showShareDialog];}];
    return NO;
}

- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker
      shouldContinueAfterSelectingPerson:(ABRecordRef)person
                                property:(ABPropertyID)property
                              identifier:(ABMultiValueIdentifier)identifier
{
    NSLog(@"peoplePickerNavigationController, second one");
    
    return NO;
}

#pragma mark - Sharing Methods

//fires when share dialog is dismissed
- (void)showShareDialog {
    
    NSLog(@"showShareDialog");
    
    //  emailAddress & phoneNumber are class properties set in peoplePickerNavigationController, shouldContinueAfterSelectingPerson
    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:[NSArray arrayWithObjects:emailAddress, phoneNumber, [singleTwitterFeed objectForKey:@"text"], nil] applicationActivities:nil];
    
    NSArray *excludedActivityTypesArray = @[UIActivityTypePostToFacebook,UIActivityTypePostToTwitter,UIActivityTypePostToWeibo,UIActivityTypePrint,UIActivityTypeCopyToPasteboard,UIActivityTypeAssignToContact,UIActivityTypeSaveToCameraRoll,UIActivityTypeAddToReadingList,UIActivityTypePostToFlickr,UIActivityTypePostToVimeo,UIActivityTypePostToTencentWeibo,UIActivityTypeAirDrop];
    
    activityVC.excludedActivityTypes = excludedActivityTypesArray;

//    would love to prepoplute the address field with something like this
//    [activityVC setValue:@"Thought you'd find this interesting" forKey:@"to"];   //would also be nice if there was a way to tell if this was going to be an sms or email
    
    [activityVC setValue:@"Thought you'd find this interesting" forKey:@"subject"];
    
    [self presentViewController:activityVC animated:YES completion:nil];
    
}

@end
