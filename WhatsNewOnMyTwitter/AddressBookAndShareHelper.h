//
//  AddressBookHelper.h
//  WhatsNewOnMyTwitter
//
//  Created by David Sanchez on 11/19/13.
//  Copyright (c) 2013 David Sanchez. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AddressBookUI/AddressBookUI.h>

@interface AddressBookAndShareHelper : NSObject <ABPeoplePickerNavigationControllerDelegate>

@property (weak, nonatomic) NSString *firstName;
@property (weak, nonatomic) NSString *phoneNumber;

- (IBAction)forwardToContact:(id)sender;

- (IBAction)showAddressBookPicker:(id)sender;

- (void)showShareDialog;

@end
