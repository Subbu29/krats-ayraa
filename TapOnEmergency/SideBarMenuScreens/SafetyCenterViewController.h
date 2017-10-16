//
//  SafetyCenterViewController.h
//  TapOnEmergency
//
//  Created by Subbu's Mac on 09/03/17.
//  Copyright © 2017 TOE. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SafetyCenterViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *peronalHealthButton;
@property (weak, nonatomic) IBOutlet UIButton *familyAndFriendsHealthButton;
- (IBAction)personalHealthButtonClicked:(id)sender;
- (IBAction)familyAndFriendsHealthButtonClicked:(id)sender;

@end
