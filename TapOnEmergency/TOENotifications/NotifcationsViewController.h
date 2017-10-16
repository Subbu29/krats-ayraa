//
//  NotifcationsViewController.h
//  TapOnEmergency
//
//  Created by Subbu's Mac on 11/06/17.
//  Copyright © 2017 TOE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SideBarMenu.h"

@interface NotifcationsViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,SideBarMenuActionProtocol>

@property (weak, nonatomic) IBOutlet UITableView *notificationsTableView;

- (IBAction)sosButtonClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *sosButton;

@end
