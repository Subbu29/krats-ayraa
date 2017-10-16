//
//  HospitalDetailViewController.h
//  TapOnEmergency
//
//  Created by Subbu's Mac on 14/04/17.
//  Copyright © 2017 TOE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HospitalsListDataModal.h"

@interface HospitalDetailViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (strong,nonatomic) HospitalsListDataModal *hospitalData;

@property (weak, nonatomic) IBOutlet UITableView *mainTableView;

@end
