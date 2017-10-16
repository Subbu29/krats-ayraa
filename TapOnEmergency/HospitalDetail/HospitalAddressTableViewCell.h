//
//  HospitalAddressTableViewCell.h
//  TapOnEmergency
//
//  Created by Subbu's Mac on 14/04/17.
//  Copyright © 2017 TOE. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HospitalAddressTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *shadowView;

@property (weak, nonatomic) IBOutlet UILabel *cellTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UIView *mapsView;

@end
