//
//  NotifcationsTableViewCell.h
//  TapOnEmergency
//
//  Created by Subbu's Mac on 11/06/17.
//  Copyright © 2017 TOE. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NotifcationsTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *incidentTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *incidentDescription;

@end
