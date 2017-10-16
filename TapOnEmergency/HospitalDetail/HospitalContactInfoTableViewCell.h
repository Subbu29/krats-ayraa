//
//  HospitalContactInfoTableViewCell.h
//  TapOnEmergency
//
//  Created by Subbu's Mac on 14/04/17.
//  Copyright © 2017 TOE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HospitalsListDataModal.h"

@interface HospitalContactInfoTableViewCell : UITableViewCell

@property (strong,nonatomic) HospitalsListDataModal *hospitalDetailData;

@property (weak, nonatomic) IBOutlet UIView *shadowView;
@property (weak, nonatomic) IBOutlet UILabel *contactInfoLabel;

@property (weak, nonatomic) IBOutlet UIView *phoneNumberView1;
@property (weak, nonatomic) IBOutlet UIImageView *phoneNumberViewImageView1;
@property (weak, nonatomic) IBOutlet UILabel *phNoLabel1;
@property (weak, nonatomic) IBOutlet UIButton *phNoButton1;
- (IBAction)phNoButton1Clicked:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *phoneNumberView2;
@property (weak, nonatomic) IBOutlet UIImageView *phoneNumberViewImageView2;
@property (weak, nonatomic) IBOutlet UILabel *phNoLabel2;
@property (weak, nonatomic) IBOutlet UIButton *phNoButton2;
- (IBAction)phNoButton2Clicked:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *emailIdView;
@property (weak, nonatomic) IBOutlet UILabel *emailLabel;
@property (weak, nonatomic) IBOutlet UIButton *emailButton;
- (IBAction)emailButtonClicked:(id)sender;

@end
