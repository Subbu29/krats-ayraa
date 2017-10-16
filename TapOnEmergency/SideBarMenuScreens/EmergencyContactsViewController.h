//
//  EmergencyContactsViewController.h
//  TapOnEmergency
//
//  Created by Subbu's Mac on 09/03/17.
//  Copyright © 2017 TOE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
#import <GooglePlacePicker/GooglePlacePicker.h>
#import "EmergencyContactsTableViewCell.h"

typedef enum {
    EMERGENCY_CONTACTS_TYPE =0,
    LOCATIONS_TYPE = 1
    
}ViewType;

@interface EmergencyContactsViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,ABPeoplePickerNavigationControllerDelegate,EmergencyContactProtocol,GMSPlacePickerViewControllerDelegate>

@property (nonatomic) ViewType viewType;

@property (weak, nonatomic) IBOutlet UITableView *emergencyContactsTableView;

@property (nonatomic, strong) ABPeoplePickerNavigationController *addressBookController;

@property (nonatomic, strong) NSMutableArray *arrContactsData;


@end
