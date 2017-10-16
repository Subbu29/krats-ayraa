//
//  SOSContactsTableViewCell.h
//  TapOnEmergency
//
//  Created by Subbu's Mac on 19/05/17.
//  Copyright © 2017 TOE. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SOSContactsTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *selectImageView;
@property (weak, nonatomic) IBOutlet UILabel *contactNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *contactNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *adminTag;

@end
