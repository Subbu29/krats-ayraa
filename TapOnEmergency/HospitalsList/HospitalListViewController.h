//
//  HospitalListViewController.h
//  TapOnEmergency
//
//  Created by Subbu's Mac on 05/02/17.
//  Copyright © 2017 TOE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SideBarMenu.h"
#import "CardsTableViewCell.h"
#import "FiltersViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface HospitalListViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,SideBarMenuActionProtocol,CardsCellProtocol,FiltersProtocol,CLLocationManagerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *cardsTableView;
@property (weak, nonatomic) IBOutlet UIButton *emergencyButton;
- (IBAction)emergencyButtonClicked:(id)sender;

@end
