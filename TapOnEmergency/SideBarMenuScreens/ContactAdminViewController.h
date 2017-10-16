//
//  ContactAdminViewController.h
//  TapOnEmergency
//
//  Created by Subbu's Mac on 06/03/17.
//  Copyright © 2017 TOE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@interface ContactAdminViewController : UIViewController<MFMessageComposeViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UIView *adminDetailsView;
@property (weak, nonatomic) IBOutlet UILabel *adminDetailsLabel;
@property (weak, nonatomic) IBOutlet UIButton *adminMobileCallButton;
@property (weak, nonatomic) IBOutlet UILabel *adminName;
@property (weak, nonatomic) IBOutlet UIButton *adminMailButton;
@property (weak, nonatomic) IBOutlet UILabel *adminMailLabel;
@property (weak, nonatomic) IBOutlet UILabel *adminMobileNoLabel;

@property (weak, nonatomic) IBOutlet UIView *contactAdminView;
@property (weak, nonatomic) IBOutlet UIButton *sendButton;
@property (weak, nonatomic) IBOutlet UIButton *shareLocationButton;
@property (weak, nonatomic) IBOutlet UITextView *adminMessageTextView;
@property (weak, nonatomic) IBOutlet UIButton *emergencyButton;
@property (weak, nonatomic) IBOutlet UILabel *adminMessageBoxLabel;

- (IBAction)callButtonClicked:(id)sender;
- (IBAction)mailButtonClicked:(id)sender;
- (IBAction)shareLocationButtonClicked:(id)sender;
- (IBAction)inEmergencyButtonClicked:(id)sender;
- (IBAction)sendButtonButtonClicked:(id)sender;

@end
