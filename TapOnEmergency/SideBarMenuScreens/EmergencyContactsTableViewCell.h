//
//  EmergencyContactsTableViewCell.h
//  TapOnEmergency
//
//  Created by Subbu's Mac on 09/03/17.
//  Copyright © 2017 TOE. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol EmergencyContactProtocol <NSObject>

-(void)cellRespondedForLongPressWithIndexPath:(NSIndexPath *)indexPath;

-(void)cellRespondsForTapWithIndexPath:(NSIndexPath *)indexPath;

@end

@interface EmergencyContactsTableViewCell : UITableViewCell

@property (strong, nonatomic) NSIndexPath *indexPathOfCell;

@property (weak, nonatomic) IBOutlet UILabel *contactName;
@property (weak, nonatomic) IBOutlet UILabel *contactNumber;

@property (strong, nonatomic) id<EmergencyContactProtocol> cellDelegate;


@end
