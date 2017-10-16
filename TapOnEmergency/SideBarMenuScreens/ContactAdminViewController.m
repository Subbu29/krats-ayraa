//
//  ContactAdminViewController.m
//  TapOnEmergency
//
//  Created by Subbu's Mac on 06/03/17.
//  Copyright © 2017 TOE. All rights reserved.
//

#import "ContactAdminViewController.h"
#import "TOEConstants.h"

@interface ContactAdminViewController ()

@end

@implementation ContactAdminViewController
{
    BOOL setFrames;
    LoginDataModal *userData;
    
    MFMessageComposeViewController *messageController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    setFrames = NO;
    [self loadUserData];
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

#pragma mark - Setup Views -

-(void)setUpViews
{
    [self setUpAdminDetailsView];
    [self setUpContactAdminView];
}

-(void)setUpAdminDetailsView
{
    
    [self setUpAdminDetailsViewFrames];
    [TOEConstants addBottomBorderToTextField:_adminDetailsLabel andBorderColor:[UIColor colorWithRed:0.0/255.0f green:140.0/255.0f blue:124.0/255.0f alpha:1.0f] andWidth:1.0f];
    
    [TOEConstants addBottomBorderToTextField:_adminName andBorderColor:[UIColor lightGrayColor] andWidth:1.0f];
    [TOEConstants addBottomBorderToTextField:_adminMailLabel andBorderColor:[UIColor lightGrayColor] andWidth:1.0f];
    [TOEConstants addBottomBorderToTextField:_adminMailButton andBorderColor:[UIColor lightGrayColor] andWidth:1.0f];
    _adminDetailsView.layer.shadowColor = [UIColor blackColor].CGColor;
    _adminDetailsView.layer.shadowOffset = CGSizeMake(1, 1);
    _adminDetailsView.layer.shadowOpacity = 0.3f;
    _adminDetailsView.layer.cornerRadius = 2.0f;
    _adminDetailsView.layer.shadowRadius = 2.0f;

}

-(void)setUpAdminDetailsViewFrames
{
    _adminDetailsLabel.frame = CGRectMake(PADDING_15, PADDING_5, self.view.frame.size.width-PADDING_30-PADDING_30, PADDING_40);
    _adminName.frame = CGRectMake(PADDING_15, _adminDetailsLabel.frame.size.height+_adminDetailsLabel.frame.origin.y+PADDING_10, self.view.frame.size.width-PADDING_30-PADDING_30, PADDING_40);
    _adminMailLabel.frame = CGRectMake(PADDING_15, _adminName.frame.size.height+_adminName.frame.origin.y+PADDING_10, self.view.frame.size.width-PADDING_30-PADDING_30-PADDING_20, PADDING_40);
    _adminMailButton.frame = CGRectMake(_adminMailLabel.frame.origin.x+_adminMailLabel.frame.size.width, _adminMailLabel.frame.origin.y, PADDING_20, PADDING_40);
    _adminMobileNoLabel.frame = CGRectMake(PADDING_15, _adminMailLabel.frame.size.height+_adminMailLabel.frame.origin.y+PADDING_10, self.view.frame.size.width-PADDING_30-PADDING_30-PADDING_20, PADDING_40);
    _adminMobileCallButton.frame = CGRectMake(_adminMobileNoLabel.frame.origin.x+_adminMobileNoLabel.frame.size.width, _adminMobileNoLabel.frame.origin.y, PADDING_20, PADDING_40);
    
    _adminDetailsView.frame = CGRectMake(PADDING_15, PADDING_10, self.view.frame.size.width-PADDING_30, _adminMobileNoLabel.frame.origin.y+_adminMobileNoLabel.frame.size.height+PADDING_10);
    
    
}

-(void)setUpContactAdminView
{
    [self setUpContactAdminViewFrames];
    [TOEConstants addBottomBorderToTextField:_adminMessageBoxLabel andBorderColor:[UIColor colorWithRed:0.0/255.0f green:140.0/255.0f blue:124.0/255.0f alpha:1.0f]andWidth:1.0f];
    [TOEConstants addBottomBorderToTextField:_adminMessageTextView andBorderColor:[UIColor colorWithRed:0.0/255.0f green:140.0/255.0f blue:124.0/255.0f alpha:1.0f]andWidth:2.0f];
    [TOEConstants addTopBorderToView:_sendButton andBorderColor:[UIColor lightGrayColor] andWidth:1.0f];
    _contactAdminView.layer.shadowColor = [UIColor blackColor].CGColor;
    _contactAdminView.layer.shadowOffset = CGSizeMake(1, 1);
    _contactAdminView.layer.shadowOpacity = 0.3f;
    _contactAdminView.layer.cornerRadius = 2.0f;
    _contactAdminView.layer.shadowRadius = 2.0f;
}

-(void)setUpContactAdminViewFrames
{
    _adminMessageBoxLabel.frame = CGRectMake(PADDING_15, PADDING_5, self.view.frame.size.width-PADDING_20-PADDING_30, PADDING_50);
    _adminMessageTextView.frame = CGRectMake(PADDING_15, _adminMessageBoxLabel.frame.origin.y+_adminMessageBoxLabel.frame.size.height+PADDING_5, self.view.frame.size.width-PADDING_20-PADDING_30, PADDING_50+PADDING_50);
    _shareLocationButton.frame = CGRectMake(PADDING_15, _adminMessageTextView.frame.origin.y+_adminMessageTextView.frame.size.height+PADDING_5, _adminMessageTextView.frame.size.width/2, PADDING_20);
    _emergencyButton.frame = CGRectMake(_shareLocationButton.frame.origin.x+_shareLocationButton.frame.size.width, _adminMessageTextView.frame.origin.y+_adminMessageTextView.frame.size.height+PADDING_5, _adminMessageTextView.frame.size.width/2, PADDING_20);
    _sendButton.frame = CGRectMake(PADDING_15, _emergencyButton.frame.size.height+_emergencyButton.frame.origin.y+PADDING_10, self.view.frame.size.width-PADDING_20-PADDING_30, PADDING_40);
    
    _contactAdminView.frame = CGRectMake(PADDING_15, _adminDetailsView.frame.origin.y+_adminDetailsView.frame.size.height+PADDING_20, self.view.frame.size.width-PADDING_30, _sendButton.frame.origin.y+_sendButton.frame.size.height+PADDING_10);
}


-(void)loadUserData
{
    userData  = [TOEConstants getUserData];
    _adminName.text = userData.adminInfo.name;
    _adminMailLabel.text = userData.adminInfo.emailId;
    _adminMobileNoLabel.text = userData.adminInfo.mobileNumber;
}


- (IBAction)callButtonClicked:(id)sender
{
    NSString *phoneNumber = [@"tel:" stringByAppendingString:userData.adminInfo.mobileNumber];
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:phoneNumber]]){
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneNumber]];
    }
    else {
        [TOEConstants showAlertWithTitle:@"Error in call" andMessage:@"cant make a call sorry for inconvience" inView:self];
    }
}

- (IBAction)mailButtonClicked:(id)sender
{
    if ((userData.adminInfo.emailId.length>0) && ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:[NSString stringWithFormat:@"mailto:%@",userData.adminInfo.emailId]]])) {
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"mailto:%@",userData.adminInfo.emailId]]];
    }
}

- (IBAction)shareLocationButtonClicked:(id)sender
{
    
}

- (IBAction)inEmergencyButtonClicked:(id)sender
{
    
}

- (IBAction)sendButtonButtonClicked:(id)sender
{
    [self sendMessage];
}

- (void)sendMessage {
    if([MFMessageComposeViewController canSendText]) {
        messageController = [[MFMessageComposeViewController alloc] init]; // Create message VC
        messageController.messageComposeDelegate = self; // Set delegate to current instance
        
        NSMutableArray *recipients = [[NSMutableArray alloc] init]; // Create an array to hold the recipients
        [recipients addObject:userData.adminInfo.mobileNumber]; // Append example phone number to array
        messageController.recipients = recipients; // Set the recipients of the message to the created array
        
        messageController.body = _adminMessageTextView.text; // Set initial text to example message
        
         // Present VC when possible
        [self presentViewController:messageController animated:YES completion:NULL];
    }
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    [messageController dismissViewControllerAnimated:YES completion:nil];
    NSLog(@"message compose relust %ld",(long)result);
}

@end
