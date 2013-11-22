//
//  AddressBookViewController.h
//  WhatsNewOnMyTwitter
//
//  Created by David Sanchez on 11/16/13.
//  Copyright (c) 2013 David Sanchez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AddressBookUI/AddressBookUI.h>

@interface AddressBookViewController : UITableViewController  <ABPeoplePickerNavigationControllerDelegate>

@property (strong, nonatomic) NSDictionary *addressBook;
@property (strong, nonatomic) NSArray *addressBookKeys;

- (IBAction)showAddressBookPicker:(id)sender;

@end
