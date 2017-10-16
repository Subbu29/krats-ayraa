//
//  HospitalContactInfoTableViewCell.m
//  TapOnEmergency
//
//  Created by Subbu's Mac on 14/04/17.
//  Copyright © 2017 TOE. All rights reserved.
//

#import "HospitalContactInfoTableViewCell.h"
#import "TOEConstants.h"

@implementation HospitalContactInfoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _shadowView.layer.cornerRadius= 5.0;
    _shadowView.layer.masksToBounds = NO;
    _shadowView.layer.shadowColor = [UIColor blackColor].CGColor;
    _shadowView.layer.shadowOffset = CGSizeMake(0.0f, 2.0f);
    _shadowView.layer.shadowOpacity = 0.5f;
    
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}




-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        NSArray *nibArray = [[NSBundle mainBundle] loadNibNamed:@"HospitalContactInfoTableViewCell" owner:self options:nil];
        self = [nibArray objectAtIndex:0];
    }
    return self;
}


-(void)setHospitalDetailData:(HospitalsListDataModal *)hospitalDetailData
{
    _phoneNumberView1.hidden = YES;
    _phoneNumberView2.hidden = YES;
    
    if (hospitalDetailData.contact1.length!=0) {
        _phoneNumberView1.hidden = NO;
        _phNoLabel1.text = hospitalDetailData.contact1;
        if (hospitalDetailData.contact2.length!=0) {
            _phoneNumberView2.hidden = NO;
            _phNoLabel2.text = hospitalDetailData.contact2;
        }
    }
    else if (hospitalDetailData.contact2.length!=0) {
        _phoneNumberView1.hidden = NO;
        _phNoLabel1.text = hospitalDetailData.contact2;
    }
    if (hospitalDetailData.email1.length!=0) {
        _emailIdView.hidden = NO;
        _emailLabel.text =hospitalDetailData.email1;
    }
}


- (IBAction)phNoButton1Clicked:(id)sender
{
    NSString *phoneNumber = [@"tel:" stringByAppendingString:_phNoLabel1.text];
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:phoneNumber]]){
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneNumber]];
    }
    else {
        
    }
}

- (IBAction)phNoButton2Clicked:(id)sender
{
    NSString *phoneNumber = [@"tel:" stringByAppendingString:_phNoLabel2.text];
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:phoneNumber]]){
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneNumber]];
    }
    else {
        
    }
}

- (IBAction)emailButtonClicked:(id)sender
{
    // open mail client
}

@end
