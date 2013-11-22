//
//  AddressBookHelper.m
//  WhatsNewOnMyTwitter
//
//  Created by David Sanchez on 11/19/13.
//  Copyright (c) 2013 David Sanchez. All rights reserved.
//

#import "AddressBookAndShareHelper.h"

@implementation AddressBookAndShareHelper

@synthesize firstName, phoneNumber;

- (IBAction)forwardToContact:(id)sender {
    //        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"forwardToContact" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    //        [alert show];
    [self showAddressBookPicker:self];
}

- (IBAction)showAddressBookPicker:(id)sender {
    
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
    [self dismissViewControllerAnimated:YES completion:^{[self showShareDialog];}];
    return NO;    
}

- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker
      shouldContinueAfterSelectingPerson:(ABRecordRef)person
                                property:(ABPropertyID)property
                              identifier:(ABMultiValueIdentifier)identifier
{
    return NO;
}

- (void)showShareDialog {
    
    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:[NSArray
                                                                                  arrayWithObjects:@"abcdefgh",@"12345", nil]
                                                                             applicationActivities:nil];
    
    NSArray *excludedActivityTypesArray = @[UIActivityTypePostToFacebook,UIActivityTypePostToTwitter,UIActivityTypePostToWeibo,UIActivityTypePrint,UIActivityTypeCopyToPasteboard,UIActivityTypeAssignToContact,UIActivityTypeSaveToCameraRoll,UIActivityTypeAddToReadingList,UIActivityTypePostToFlickr,UIActivityTypePostToVimeo,UIActivityTypePostToTencentWeibo,UIActivityTypeAirDrop];
    
    activityVC.excludedActivityTypes = excludedActivityTypesArray;
    
    [activityVC setValue:@"abcdefgh" forKey:@"subject"];
    
    [self presentViewController:activityVC animated:YES completion:nil];
}

- (void)peoplePickerNavigationControllerDidCancel: (ABPeoplePickerNavigationController *)peoplePicker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker

      shouldContinueAfterSelectingPerson:(ABRecordRef)person {
    
    //    [self displayPerson:person];
    
    [self dismissViewControllerAnimated:YES completion:^{[self showShareDialog];}];
    
    return NO;
    
}



- (BOOL)peoplePickerNavigationController:

(ABPeoplePickerNavigationController *)peoplePicker

      shouldContinueAfterSelectingPerson:(ABRecordRef)person

                                property:(ABPropertyID)property

                              identifier:(ABMultiValueIdentifier)identifier

{

    return NO;

}





@end
