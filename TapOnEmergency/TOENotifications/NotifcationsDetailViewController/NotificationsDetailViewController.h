//
//  NotificationsDetailViewController.h
//  TapOnEmergency
//
//  Created by Subbu's Mac on 01/07/17.
//  Copyright © 2017 TOE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginDataModal.h"

@interface NotificationsDetailViewController : UIViewController

@property (strong,nonatomic) Incidents *incidentData;
@property (weak, nonatomic) IBOutlet UIScrollView *mainScrollView;

@property (weak, nonatomic) IBOutlet UILabel *notificationTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *notificationDescription;
@property (weak, nonatomic) IBOutlet UIView *bottomButtonsView;
@property (weak, nonatomic) IBOutlet UIButton *iamSafeButton;
- (IBAction)iamSafeButtonClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *needHelpButton;
- (IBAction)needHelpButtonClicked:(id)sender;

@end
