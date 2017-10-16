//
//  SOSViewController.m
//  TapOnEmergency
//
//  Created by Subbu's Mac on 12/03/17.
//  Copyright © 2017 TOE. All rights reserved.
//

#import "SOSViewController.h"
#import "LoginDataModal.h"
#import "TOEConstants.h"
#import "SOSContactsTableViewCell.h"

@interface SOSViewController ()

@end

@implementation SOSViewController
{
    LoginDataModal *userData;
    
    MFMessageComposeViewController *messageController;
    NSMutableDictionary *selectedContacts;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    selectedContacts = [[NSMutableDictionary alloc] init];
    [self setUpViews];
    [self setUpNavigationBar];
    [self registerTableViewCells];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setUpNavigationBar
{
    UIButton *rightSelectAllButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightSelectAllButton.frame = CGRectMake(5, 5, 20, 20);
    //    [rightSearchButton setImage:[UIImage imageNamed:@"SearchIcon"] forState:UIControlStateNormal];
    [rightSelectAllButton setTitle:[NSString stringWithFormat:@"A"] forState:UIControlStateNormal];
    [rightSelectAllButton addTarget:self action:@selector(selectAllContactButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    rightSelectAllButton.adjustsImageWhenHighlighted = NO;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightSelectAllButton];
}

-(void)registerTableViewCells
{
    [_contactsTableView registerNib:[UINib nibWithNibName:@"SOSContactsTableViewCell" bundle:nil] forCellReuseIdentifier:@"SOSContactsTableViewCellIdentifier"];
    [_contactsTableView registerClass:[SOSContactsTableViewCell class] forCellReuseIdentifier:@"SOSContactsTableViewCellIdentifier"];
}

-(void)selectAllContactButtonClicked
{
    [self selectAllContacts];
    [_contactsTableView reloadData];
    [self updateTableViewFrames];
}

-(void)setUpViews
{
    userData = [TOEConstants getUserData];
    [_contactsTableView reloadData];
    [self updateTableViewFrames];
}

-(void)updateTableViewFrames
{
    if (_contactsTableView.contentSize.height<(self.view.frame.size.height-_contactsTableView.frame.origin.y)) {
        CGRect frame = _contactsTableView.frame;
        frame.size.height = _contactsTableView.contentSize.height;
        _contactsTableView.frame = frame;
        _contactsTableView.scrollEnabled = NO;
    }
    else{
        _contactsTableView.frame = CGRectMake(_contactsTableView.frame.origin.x, _contactsTableView.frame.origin.y, _contactsTableView.frame.size.width, (self.view.frame.size.height-_contactsTableView.frame.origin.y));
        _contactsTableView.scrollEnabled = YES;
    }

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return (userData.emergencyContacts.count+1);
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SOSContactsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SOSContactsTableViewCellIdentifier"];
    if (indexPath.row==0) {
        cell.selectImageView.backgroundColor = [UIColor brownColor];
        cell.contactNameLabel.text = [NSString stringWithFormat:@"ADMIN"];
        cell.contactNumberLabel.text =  userData.adminInfo.mobileNumber;
        cell.adminTag.hidden = NO;
    }
    else{
        EmergencyContacts *contactObj = [userData.emergencyContacts objectAtIndex:(indexPath.row-1)];
        if ([selectedContacts objectForKey:contactObj.contactId]) {
            cell.selectImageView.backgroundColor = [UIColor brownColor];
        }
        else {
            cell.selectImageView.backgroundColor = [UIColor grayColor];
        }
        cell.contactNameLabel.text = contactObj.contactName;
        cell.contactNumberLabel.text =  contactObj.contactNumber;
        cell.adminTag.hidden = YES;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row!=0) {
        SOSContactsTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        
        EmergencyContacts *contactObj = [userData.emergencyContacts objectAtIndex:(indexPath.row-1)];
        
        if ([selectedContacts objectForKey:contactObj.contactId]) {
            [self deleteContactFromSelectionWithObj:contactObj];
            cell.selectImageView.backgroundColor = [UIColor grayColor];
        }
        else {
            [self addContactToSelectionWithObj:contactObj];
            cell.selectImageView.backgroundColor = [UIColor brownColor];
        }
    }
}

- (IBAction)sendSOSButtonClicked:(id)sender
{
    // hit api
    [self sendMessage];
}

- (IBAction)shareLocationButtonClicked:(id)sender
{
    // get location
}

- (void)sendMessage {
    if([MFMessageComposeViewController canSendText]) {
        messageController = [[MFMessageComposeViewController alloc] init]; // Create message VC
        messageController.messageComposeDelegate = self; // Set delegate to current instance
        
        NSMutableArray *recipients = [[NSMutableArray alloc] init]; // Create an array to hold the recipients
        [recipients addObject:userData.adminInfo.mobileNumber];
        // Append example phone number to array
        NSArray *allSelectedKeys = [selectedContacts allKeys];
        for (int i = 0; i<allSelectedKeys.count; i++) {
            if ([selectedContacts objectForKey:[allSelectedKeys objectAtIndex:i]]) {
                EmergencyContacts *contactObj = [selectedContacts objectForKey:[allSelectedKeys objectAtIndex:i]];
                
                [recipients addObject:contactObj.contactNumber];
            }
        }
        messageController.recipients = recipients; // Set the recipients of the message to the created array
        
        messageController.body = _emergencyTextView.text; // Set initial text to example message
        
        // Present VC when possible
        [self presentViewController:messageController animated:YES completion:nil];
        
    }
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    [messageController dismissViewControllerAnimated:YES completion:nil];
    NSLog(@"message compose relust %ld",(long)result);
}

#pragma mark - selection of contacts -

-(void)selectAllContacts
{
    for (int i = 0 ; i<userData.emergencyContacts.count; i++) {
        EmergencyContacts *contactObj = [userData.emergencyContacts objectAtIndex:i];
        [self addContactToSelectionWithObj:contactObj];
    }
}

#pragma mark - Selection and deselection -

-(void)addContactToSelectionWithObj:(EmergencyContacts *)contactObj
{
    [selectedContacts setObject:contactObj forKey:contactObj.contactId];
}

-(void)deleteContactFromSelectionWithObj:(EmergencyContacts *)contactObj
{
    [selectedContacts removeObjectForKey:contactObj.contactId];
}


@end
