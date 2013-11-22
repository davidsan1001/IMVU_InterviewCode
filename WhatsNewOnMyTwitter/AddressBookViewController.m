//
//  AddressBookViewController.m
//  WhatsNewOnMyTwitter
//
//  Created by David Sanchez on 11/16/13.
//  Copyright (c) 2013 David Sanchez. All rights reserved.
//

#import "AddressBookViewController.h"

@implementation AddressBookViewController

@synthesize addressBook, addressBookKeys;

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"");
    
    NSString *k1 = @"idBob1111";
    NSString *k2 = @"k2";
    NSString *k3 = @"k3";
    
    NSDictionary *addressDict1 = @{ @"name" : @"Bob", @"email" : @"bob@egads.com"};
    NSDictionary *addressDict2 = @{ @"name" : @"Barbara", @"email" : @"barbara@egads.com"};
    NSDictionary *addressDict3 = @{ @"name" : @"Brett", @"email" : @"brett@egads.com"};
    
    addressBook = @{ k1 : addressDict1, k2 : addressDict2, k3 : addressDict3 };
    
    addressBookKeys = [addressBook allKeys];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [addressBook count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    NSDictionary *addressBookEntry = [addressBook objectForKey:[addressBookKeys objectAtIndex:indexPath.row]];
    
    cell.textLabel.text = [addressBookEntry objectForKey:@"name"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     NSDictionary *addressBookEntry = [addressBook objectForKey:[addressBookKeys objectAtIndex:indexPath.row]];
    
 //   UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:[NSString stringWithFormat:@"You selected %@!", [addressBookEntry objectForKey:@"name"]] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//    [alert show];
    
//    UIImage *yourImage = someImg;
    
    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:[NSArray arrayWithObjects:@"abcdefgh",@"12345", nil] applicationActivities:nil];
    
    
    
    NSArray *excludedActivityTypesArray = @[UIActivityTypePostToFacebook,UIActivityTypePostToTwitter,UIActivityTypePostToWeibo,UIActivityTypePrint,UIActivityTypeCopyToPasteboard,UIActivityTypeAssignToContact,UIActivityTypeSaveToCameraRoll,UIActivityTypeAddToReadingList,UIActivityTypePostToFlickr,UIActivityTypePostToVimeo,UIActivityTypePostToTencentWeibo,UIActivityTypeAirDrop];
    
    activityVC.excludedActivityTypes = excludedActivityTypesArray;
    
    [activityVC setValue:@"abcdefgh" forKey:@"subject"];

    [self presentViewController:activityVC animated:YES completion:nil];
}

- (IBAction)showAddressBookPicker:(id)sender {
    
    ABPeoplePickerNavigationController *picker = [[ABPeoplePickerNavigationController alloc] init];
    
    picker.peoplePickerDelegate = self;
    
    
    
    [self presentModalViewController:picker animated:YES];
}

@end
