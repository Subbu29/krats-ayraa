//
//  SOSViewController.h
//  TapOnEmergency
//
//  Created by Subbu's Mac on 12/03/17.
//  Copyright © 2017 TOE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@interface SOSViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,MFMessageComposeViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UITextView *emergencyTextView;

@property (weak, nonatomic) IBOutlet UILabel *noOfCharactersLabel;

@property (weak, nonatomic) IBOutlet UIButton *shareLocationButton;
- (IBAction)shareLocationButtonClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *contactsTableView;
@property (weak, nonatomic) IBOutlet UIButton *sendSOSButton;
- (IBAction)sendSOSButtonClicked:(id)sender;

@end
