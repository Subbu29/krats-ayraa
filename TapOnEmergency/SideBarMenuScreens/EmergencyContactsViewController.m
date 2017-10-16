//
//  EmergencyContactsViewController.m
//  TapOnEmergency
//
//  Created by Subbu's Mac on 09/03/17.
//  Copyright © 2017 TOE. All rights reserved.
//

#import "EmergencyContactsViewController.h"

#import "TOEConstants.h"
#import "TOEAPIConstants.h"
#import "TOEHttpUtil.h"


#define SELECTED_CELL_BACKGROUND_COLOR [UIColor colorWithRed:134.0f/255.0f green:214.0f/255.0f blue:246.0f/255.0f alpha:1.0f]
#define EDITVIEW_BACKGROUND_COLOR [UIColor colorWithRed:104.0f/255.0f green:104.0f/255.0f blue:104.0f/255.0f alpha:1.0f]

@interface EmergencyContactsViewController ()

@end

@implementation EmergencyContactsViewController
{
    LoginDataModal *userData;
    NSString *contactName;
    NSString *contactNumber;
    BOOL setFrames;
    BOOL isLongPressActive;
    NSMutableDictionary *selectedContactDictionary;
    
    UIView *editView;
    UIButton *doneButton;
    UIButton *deleteButton;
    UILabel *countLabel;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    selectedContactDictionary = [[NSMutableDictionary alloc] init];
    setFrames = NO;
    isLongPressActive = NO;
    [self setUpNavigationBar];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidLayoutSubviews
{
    if (setFrames) {
        [self setUpViews];
    }
    setFrames = !setFrames;
}

-(void)setUpNavigationBar
{
    UIButton *addContactButton = [UIButton buttonWithType:UIButtonTypeCustom];
    addContactButton.frame = CGRectMake(5, 5, 20, 20);
//    [addContactButton setImage:[UIImage imageNamed:@"SearchIcon"] forState:UIControlStateNormal];
    [addContactButton setTitle:[NSString stringWithFormat:@"A"] forState:UIControlStateNormal];
    [addContactButton addTarget:self action:@selector(addContactButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    addContactButton.adjustsImageWhenHighlighted = NO;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:addContactButton];
}

-(void)setUpViews
{
    [self setUpEditView];
    [self registerTableViewCells];
    [self loadUserData];
    if (_emergencyContactsTableView.contentSize.height<self.view.frame.size.height) {
        CGRect frame = _emergencyContactsTableView.frame;
        frame.size.height = _emergencyContactsTableView.contentSize.height;
        _emergencyContactsTableView.frame = frame;
        _emergencyContactsTableView.scrollEnabled = NO;
    }
}

-(void)registerTableViewCells
{
    [_emergencyContactsTableView registerNib:[UINib nibWithNibName:@"EmergencyContactsTableViewCell" bundle:nil] forCellReuseIdentifier:@"EmergencyContactsCellIdentifier"];
    [_emergencyContactsTableView registerClass:[EmergencyContactsTableViewCell class] forCellReuseIdentifier:@"EmergencyContactsCellIdentifier"];
}

-(void)loadUserData
{
    userData = [TOEConstants getUserData];
    [_emergencyContactsTableView reloadData];
}

#pragma mark - Table View Delegate Methods -

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (_viewType) {
        case LOCATIONS_TYPE:
            return userData.locations.count;
            break;
        case EMERGENCY_CONTACTS_TYPE:
            return userData.emergencyContacts.count;
            break;
        default:
            return 0;
            break;
    }
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    EmergencyContactsTableViewCell *cell = [_emergencyContactsTableView dequeueReusableCellWithIdentifier:@"EmergencyContactsCellIdentifier"];
    NSString *contactNameText;
    NSString *contactNumberText;
    
    switch (_viewType) {
        case LOCATIONS_TYPE:
        {
            Locations *locationObj =[userData.locations objectAtIndex:indexPath.row];
            contactNameText = locationObj.locationName;
            contactNumberText = @"";
            cell.contactNumber.hidden = YES;
        }
            
            break;
        case EMERGENCY_CONTACTS_TYPE:
        {
            EmergencyContacts *contactObj = [userData.emergencyContacts objectAtIndex:indexPath.row];
            contactNameText = contactObj.contactName;
            contactNumberText = contactObj.contactNumber;
            cell.contactNumber.hidden = NO;
        }
            
            break;
        default:
            return 0;
            break;
    }
    
    cell.contactName.text  = contactNameText;
    cell.contactNumber.text  = contactNumberText;
    cell.indexPathOfCell = indexPath;
    cell.cellDelegate = self;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

#pragma mark - Cell delegate -

-(void)cellRespondedForLongPressWithIndexPath:(NSIndexPath *)indexPath
{
    if (!isLongPressActive) {
        isLongPressActive = YES;
        
        switch (_viewType) {
            case LOCATIONS_TYPE:
            {
                Locations *locationObj = [userData.locations objectAtIndex:indexPath.row];
                EmergencyContactsTableViewCell *cell = [_emergencyContactsTableView cellForRowAtIndexPath:indexPath];
                
                if ([self locationIsSelectedWithDataObj:locationObj]) {
                    [self removeLocationToSelectedListWithDataObj:locationObj];
                    cell.backgroundColor = [UIColor whiteColor];
                }
                else {
                    [self addLocationToSelectedListWithDataObj:locationObj];
                    cell.backgroundColor = SELECTED_CELL_BACKGROUND_COLOR;
                }
            }
                
                break;
            case EMERGENCY_CONTACTS_TYPE:
            {
                EmergencyContacts *contactObj = [userData.emergencyContacts objectAtIndex:indexPath.row];
                EmergencyContactsTableViewCell *cell = [_emergencyContactsTableView cellForRowAtIndexPath:indexPath];
                
                if ([self contactIsSelectedWithDataObj:contactObj]) {
                    [self removeContactToSelectedListWithDataObj:contactObj];
                    cell.backgroundColor = [UIColor whiteColor];
                }
                else {
                    [self addContactToSelectedListWithDataObj:contactObj];
                    cell.backgroundColor = SELECTED_CELL_BACKGROUND_COLOR;
                }
            }
                
                break;
            default:
                break;
        }
        
        
        [self updateEditViewOnBar];
    }
}

-(void)cellRespondsForTapWithIndexPath:(NSIndexPath *)indexPath
{
    if (isLongPressActive) {
        switch (_viewType) {
            case LOCATIONS_TYPE:
            {
                Locations *locationObj = [userData.locations objectAtIndex:indexPath.row];
                EmergencyContactsTableViewCell *cell = [_emergencyContactsTableView cellForRowAtIndexPath:indexPath];
                
                if ([self locationIsSelectedWithDataObj:locationObj]) {
                    [self removeLocationToSelectedListWithDataObj:locationObj];
                    cell.backgroundColor = [UIColor whiteColor];
                }
                else {
                    [self addLocationToSelectedListWithDataObj:locationObj];
                    cell.backgroundColor = SELECTED_CELL_BACKGROUND_COLOR;
                }
            }
                
                break;
            case EMERGENCY_CONTACTS_TYPE:
            {
                EmergencyContacts *contactObj = [userData.emergencyContacts objectAtIndex:indexPath.row];
                EmergencyContactsTableViewCell *cell = [_emergencyContactsTableView cellForRowAtIndexPath:indexPath];
                
                if ([self contactIsSelectedWithDataObj:contactObj]) {
                    [self removeContactToSelectedListWithDataObj:contactObj];
                    cell.backgroundColor = [UIColor whiteColor];
                }
                else {
                    [self addContactToSelectedListWithDataObj:contactObj];
                    cell.backgroundColor = SELECTED_CELL_BACKGROUND_COLOR;
                }
            }
                
                break;
            default:
                break;
        }
        [self updateEditViewOnBar];
    }
}

#pragma mark - contacts delegate methods -

-(void)peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController *)peoplePicker{
    [_addressBookController dismissViewControllerAnimated:YES completion:nil];
}

- (void)peoplePickerNavigationController:(ABPeoplePickerNavigationController*)peoplePicker didSelectPerson:(ABRecordRef)person
{
    CFTypeRef generalCFObject;
    generalCFObject = ABRecordCopyValue(person, kABPersonFirstNameProperty);
    if (generalCFObject) {
        NSLog(@"%@",(__bridge NSString *)generalCFObject);
        contactName =(__bridge NSString *)generalCFObject;
        CFRelease(generalCFObject);
    }
    
    generalCFObject = ABRecordCopyValue(person, kABPersonLastNameProperty);
    if (generalCFObject) {
        NSLog(@"%@",(__bridge NSString *)generalCFObject);
        contactName =[contactName stringByAppendingString:[NSString stringWithFormat:@" %@",(__bridge NSString *)generalCFObject]];
        CFRelease(generalCFObject);
    }
    
    ABMultiValueRef phonesRef = ABRecordCopyValue(person, kABPersonPhoneProperty);
    for (int i=0; i<ABMultiValueGetCount(phonesRef); i++) {
        CFStringRef currentPhoneLabel = ABMultiValueCopyLabelAtIndex(phonesRef, i);
        CFStringRef currentPhoneValue = ABMultiValueCopyValueAtIndex(phonesRef, i);
        
        if (CFStringCompare(currentPhoneLabel, kABPersonPhoneMobileLabel, 0) == kCFCompareEqualTo) {
            NSLog(@"mobile number %@",(__bridge NSString *)currentPhoneValue);
            contactNumber = (__bridge NSString *)currentPhoneValue;
        }
        
        if (CFStringCompare(currentPhoneLabel, kABHomeLabel, 0) == kCFCompareEqualTo) {
            NSLog(@"home number%@",(__bridge NSString *)currentPhoneValue);
        }
        
        CFRelease(currentPhoneLabel);
        CFRelease(currentPhoneValue);
    }
    CFRelease(phonesRef);
    [self addEmergencyContact];
    // hit api .. and add emergency contacts
}

- (void)peoplePickerNavigationController:(ABPeoplePickerNavigationController*)peoplePicker didSelectPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier
{
    
}



#pragma mark -  handling Emergency selection -

-(void)addEmergencyContact
{
    NSLog(@"%@",contactNumber);
    
    contactNumber = [contactNumber stringByReplacingOccurrencesOfString:@"(" withString:@""];
    contactNumber = [contactNumber stringByReplacingOccurrencesOfString:@")" withString:@""];
    contactNumber = [contactNumber stringByReplacingOccurrencesOfString:@" " withString:@""];
    contactNumber = [contactNumber stringByReplacingOccurrencesOfString:@"-" withString:@""];
    if (contactNumber==nil) {
        // show alert
        contactName = nil;
        return;
    }
    // is contact present in list
    if ([self isContactWithMobileNumber:contactNumber]) {
        // show alert
        [TOEConstants showAlertWithTitle:@"Contact is already added" andMessage:[NSString stringWithFormat:@"Contact with number %@ is already present",contactNumber] inView:self];
    }
    else {
        NSDictionary *postDataDict= [NSDictionary dictionaryWithObjects:@[userData.userId,userData.token,contactName,contactNumber] forKeys:@[@"userId",@"token",@"contactName",@"contactNumber"]];
        
        [TOEHttpUtil postDataFromNetworkWithUrl:[NSString stringWithFormat:@"%@addEmergencyContact",TOE_WEB_API_URL] withParameters:postDataDict WithHeaders:[TOEAPIConstants addHeaders] WithCompletionBlock:^(AFHTTPRequestOperation *operation, NSInteger statusCode) {
            if (statusCode ==200) {
                EmergencyContacts *emergencyContact = [[EmergencyContacts alloc] init];
                emergencyContact.contactNumber = contactNumber;
                emergencyContact.userId = userData.userId;
                emergencyContact.contactName = contactName;
                emergencyContact.contactId = [operation.responseObject objectForKey:@"contactId"];
                [userData.emergencyContacts addObject:emergencyContact];
                [_emergencyContactsTableView reloadData];
                contactName = nil;
                contactNumber = nil;
            }
            NSLog(@"%@%ld",operation,(long)statusCode);
        }];
    }
}

-(BOOL)isContactWithMobileNumber:(NSString *)contactNo
{
    for (int i = 0; i<userData.emergencyContacts.count; i++) {
        EmergencyContacts *emergencyContact = [userData.emergencyContacts objectAtIndex:i];
        if ([emergencyContact.contactNumber isEqualToString:contactNo]) {
            return YES;
        }
    }
    return NO;
}

-(void)deleteContactWithNumber:(NSString *)contactNo
{
    for (int i = 0; i<userData.emergencyContacts.count; i++) {
        EmergencyContacts *emergencyContact = [userData.emergencyContacts objectAtIndex:i];
        if ([emergencyContact.contactNumber isEqualToString:contactNo]) {
            [userData.emergencyContacts removeObjectAtIndex:i];
        }
    }
}

-(BOOL)contactIsSelectedWithDataObj:(EmergencyContacts *)contactObj
{
    if ([selectedContactDictionary objectForKey:contactObj.contactId]) {
        return YES;
    }
    return NO;
}

-(void)addContactToSelectedListWithDataObj:(EmergencyContacts *)contactObj
{
    [selectedContactDictionary setObject:contactObj forKey:contactObj.contactId];
}

-(void)removeContactToSelectedListWithDataObj:(EmergencyContacts *)contactObj
{
    if ([selectedContactDictionary objectForKey:contactObj.contactId]) {
        [selectedContactDictionary removeObjectForKey:contactObj.contactId];
    }
}

-(void)deleteSelectedEmergencyContacts
{
    
    //    2) deleteEmergencyContact
    //
    //    userId
    //    token
    //    contactId
    //
    //    3) deleteBulkEmergencyContacts
    //
    //    contactIds (comma seperated)
    
    NSString *urlString;
    NSMutableDictionary *postDataDict = [[NSMutableDictionary alloc] initWithDictionary:[NSDictionary dictionaryWithObjects:@[userData.userId,userData.token] forKeys:@[@"userId",@"token"]]];
    
    if (selectedContactDictionary.allKeys.count>1) {
        urlString  = [NSString stringWithFormat:@"%@deleteBulkEmergencyContacts",TOE_WEB_API_URL];
        [postDataDict setObject:[selectedContactDictionary allKeys] forKey:@"contactIds"];
    }
    else if(selectedContactDictionary.allKeys.count == 1) {
        urlString  = [NSString stringWithFormat:@"%@deleteEmergencyContact",TOE_WEB_API_URL];
        NSArray *keysArray = selectedContactDictionary.allKeys;
        EmergencyContacts *selectedContact;
        for (int i=0; i<keysArray.count; i++) {
            NSString *key =(NSString *) [keysArray objectAtIndex:i];
            selectedContact = [selectedContactDictionary objectForKey:key];
        }
        [postDataDict setValue:selectedContact.contactId forKey:@"contactId"];
    }
    else {
        return;
    }
    
    //    NSDictionary *postDataDict= [NSDictionary dictionaryWithObjects:@[userData.userId,userData.token,contactName,contactNumber] forKeys:@[@"userId",@"token",@"contactName",@"contactNumber"]];
    
    [TOEHttpUtil postDataFromNetworkWithUrl:urlString withParameters:postDataDict WithHeaders:[TOEAPIConstants addHeaders] WithCompletionBlock:^(AFHTTPRequestOperation *operation, NSInteger statusCode) {
        if (statusCode ==200) {
            // update
            NSArray *keysArray = selectedContactDictionary.allKeys;
            EmergencyContacts *selectedContact;
            for (int i=0; i<keysArray.count; i++) {
                NSString *key =(NSString *) [keysArray objectAtIndex:i];
                selectedContact = [selectedContactDictionary objectForKey:key];
                [self deleteContactWithNumber:selectedContact.contactNumber];
            }
            [self doneButtonClicked];
        }
        else {
            [TOEConstants showAlertWithTitle:@"Some thing went wrong" andMessage:@"couldn't delete contact" inView:self];
        }
    }];
}

#pragma mark -  Updating Views -

-(void)updateEditViewOnBar
{
    editView.hidden = NO;
    countLabel.text = [NSString stringWithFormat:@"%lu",(unsigned long)[selectedContactDictionary allKeys].count];
}

-(void)setUpEditView
{
    editView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    editView.backgroundColor = EDITVIEW_BACKGROUND_COLOR;
    doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    doneButton.frame = CGRectMake(10, 20, 40, 40);
    [doneButton addTarget:self action:@selector(doneButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [doneButton setTitle:@"DO" forState:UIControlStateNormal];
    
    countLabel = [[UILabel alloc] initWithFrame:CGRectMake(doneButton.frame.origin.x+doneButton.frame.size.width+5, 20, 20, 40)];
    countLabel.textColor = [UIColor whiteColor];
    
    deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
    deleteButton.frame = CGRectMake(editView.frame.size.width - 60, 20, 40, 40);
    [deleteButton addTarget:self action:@selector(deleteButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [deleteButton setTitle:@"DE" forState:UIControlStateNormal];
    
    [editView addSubview:doneButton];
    [editView addSubview:countLabel];
    [editView addSubview:deleteButton];
    editView.hidden = YES;
    [[UIApplication sharedApplication].keyWindow addSubview:editView];
}

#pragma mark - Navigation Button Action Methods -

-(void)addContactButtonClicked
{
    switch (_viewType) {
        case EMERGENCY_CONTACTS_TYPE:
        {
            _addressBookController = [[ABPeoplePickerNavigationController alloc] init];
            [_addressBookController setPeoplePickerDelegate:self];
            [self presentViewController:_addressBookController animated:YES completion:nil];
        }
            
            break;
        case LOCATIONS_TYPE:
        {
            GMSPlacePickerConfig *config = [[GMSPlacePickerConfig alloc] initWithViewport:nil];
            GMSPlacePickerViewController *placePicker =
            [[GMSPlacePickerViewController alloc] initWithConfig:config];
            placePicker.delegate = self;
            [self presentViewController:placePicker animated:YES completion:nil];
        }
            break;
        default:
            break;
    }
    
}

-(void)doneButtonClicked
{
    editView.hidden = YES;
    isLongPressActive =  NO;
    selectedContactDictionary = [[NSMutableDictionary alloc] init];
    [_emergencyContactsTableView reloadData];
}

-(void)deleteButtonClicked
{
    isLongPressActive =  NO;
    
    switch (_viewType) {
        case EMERGENCY_CONTACTS_TYPE:
            [self deleteSelectedEmergencyContacts];
            break;
        case LOCATIONS_TYPE:
            
            break;
            
        default:
            break;
    }
}

#pragma mark - Place Picker delegates -

- (void)placePicker:(GMSPlacePickerViewController *)viewController didPickPlace:(GMSPlace *)place {
    // Dismiss the place picker, as it cannot dismiss itself.
    [viewController dismissViewControllerAnimated:YES completion:nil];
    NSLog(@"latitude :: %f longitude :: %f",place.coordinate.latitude,place.coordinate.longitude);
    NSLog(@"Place name %@", place.name);
    NSLog(@"Place address %@", place.formattedAddress);
    NSLog(@"Place attributions %@", place.attributions.string);
    
    // hit api and add it in tableview
    [TOEConstants showAlertWithTitle:@"API is not yet done" andMessage:[NSString stringWithFormat:@"Place picked is %@",place.formattedAddress] inView:self];
}

- (void)placePickerDidCancel:(GMSPlacePickerViewController *)viewController {
    // Dismiss the place picker, as it cannot dismiss itself.
    [viewController dismissViewControllerAnimated:YES completion:nil];
    NSLog(@"No place selected");
}

#pragma mark -  handling Locations selection -

-(BOOL)locationIsSelectedWithDataObj:(Locations *)locationObj
{
    if ([selectedContactDictionary objectForKey:locationObj.locationId]) {
        return YES;
    }
    return NO;
}

-(void)addLocationToSelectedListWithDataObj:(Locations *)locationObj
{
    [selectedContactDictionary setObject:locationObj forKey:locationObj.locationId];
}

-(void)removeLocationToSelectedListWithDataObj:(Locations *)locationObj
{
    if ([selectedContactDictionary objectForKey:locationObj.locationId]) {
        [selectedContactDictionary removeObjectForKey:locationObj.locationId];
    }
}

@end
